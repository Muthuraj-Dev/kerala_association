import 'dart:convert';

import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:kerala_association/router.dart';
import 'package:kerala_association/services/appconfig_service.dart';
import 'package:kerala_association/services/network_service.dart';
import 'package:kerala_association/services/onesignal_service.dart';
import 'package:kerala_association/services/secure_storage_service.dart';
import 'package:kerala_association/ui/app_binding.dart';
import 'package:toastification/toastification.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

import 'core/res/colors.dart';
import 'core/res/styles.dart';

import 'firebase_options_prod.dart';
import 'locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // // 🔥 INIT ONESIGNAL HERE
  // await OneSignalService.init();
  //
  // // Setup service locator
  // Init network service (after config is set)
  // ✅ Register BEFORE anything uses it
  Get.put(SecureStorageService(), permanent: true);

  setupLocator();
  locator<NetworkService>().onInit();

  try {
    // Fetch config from Firebase Remote Config
    final remoteConfig = FirebaseRemoteConfig.instance;

    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(seconds: 0),
      ),
    );

    await remoteConfig.fetchAndActivate();

    final rawJson = remoteConfig.getString('config');
    final Map<String, dynamic> configMap = jsonDecode(rawJson);

    // Set App Config into service
    locator<AppConfigService>().setConfig(configMap);
  } catch (e) {
    debugPrint('Failed to fetch or decode remote config: $e');
  }

  runApp(
    ToastificationWrapper(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return GetMaterialApp(
      title: 'Retailer',
      initialRoute: '/',
      // login
      initialBinding: AppBinding(),
      debugShowCheckedModeBanner: false,
      getPages: AppRoutes.pages,
      theme: AppStyle.appTheme,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      showPerformanceOverlay: false,
    );
  }
}
