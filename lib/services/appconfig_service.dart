import 'dart:convert';

import 'package:get/get.dart';

class AppConfigService extends GetxService {
  // AppConfig _appConfig = AppConfig(
  //   appName: "TJW",
  //   baseApiUrl: "",
  //   firebaseNotificationApiKey: "",
  // );

  final RxBool isLoaded = false.obs;

  final Rx<AppConfig> _appConfig =
      AppConfig(
        appName: "TJW",
        baseApiUrl: "",
        firebaseNotificationApiKey: "",
        features: Features(
          showMembers: true,
          showNotification: true, // ✅ ADD
        ),
      ).obs;

  String? _packageName;

  String get envString {
    if (_packageName?.endsWith(".dev") == true) {
      return "DEVELOP";
    } else if (_packageName?.endsWith(".uat") == true) {
      return "UAT";
    } else {
      return "PROD";
    }
  }

  AppConfig get config => _appConfig.value;

  /// 🔥 Expose stream for UI
  // ✅ Reactive access (only where needed)
  Rx<AppConfig> get configRx => _appConfig;

  void setConfig(Map<String, dynamic> value) {
    _appConfig.value = AppConfig.fromJson(value); // ✅ FIX
    print(
      'AppConfig loaded:\n${const JsonEncoder.withIndent('  ').convert(_appConfig.value.toJson())}',
    );
    isLoaded.value = true;
    print("✅ CONFIG SET");
  }

  void setPackageName(String packageName) {
    _packageName = packageName;
  }

  bool get showMembers => _appConfig.value.features!.showMembers;

  bool get showNotification =>
      _appConfig.value.features?.showNotification ?? true;

}

class AppConfig {
  String appName;
  String baseApiUrl;
  String? firebaseNotificationApiKey;
  Android? android;
  IOS? iOS;
  List<String>? banners;
  String? termsAndConditions;
  bool? forceUpdate;

  Features? features; // ✅ NEW

  AppConfig({
    required this.appName,
    required this.baseApiUrl,
    this.firebaseNotificationApiKey,
    this.android,
    this.iOS,
    this.banners,
    this.termsAndConditions,
    this.forceUpdate,
    this.features,
  });

  factory AppConfig.fromJson(Map<String, dynamic> json) {
    return AppConfig(
      appName: json['AppName'] ?? '',
      baseApiUrl: json['BaseApiUrl'] ?? '',
      firebaseNotificationApiKey: json['FirebaseNotificationApiKey'],
      android:
          json['Android'] != null ? Android.fromJson(json['Android']) : null,
      iOS: json['IOS'] != null ? IOS.fromJson(json['IOS']) : null,
      banners:
          (json['Banners'] as List<dynamic>?)?.map((e) => e as String).toList(),
      termsAndConditions: json['TermsAndConditions'],
      forceUpdate: json['ForceUpdate'] as bool?,

      // ✅ IMPORTANT: fallback if missing
      features: json['Features'] != null
          ? Features.fromJson(json['Features'])
          : Features(
        showMembers: true,
        showNotification: true,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'AppName': appName,
      'BaseApiUrl': baseApiUrl,
      'FirebaseNotificationApiKey': firebaseNotificationApiKey,
      'TermsAndConditions': termsAndConditions,
    };
    if (android != null) data['Android'] = android!.toJson();
    if (iOS != null) data['IOS'] = iOS!.toJson();
    if (banners != null) data['Banners'] = banners;

    // ✅ ADD THIS
    if (features != null) data['Features'] = features!.toJson();

    return data;
  }
}

class Android {
  String? url;
  String? version;
  String? appID;

  Android({this.url, this.version, this.appID});

  factory Android.fromJson(Map<String, dynamic> json) {
    return Android(
      url: json['Url'],
      version: json['Version'],
      appID: json['AppID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'Url': url, 'Version': version, 'AppID': appID};
  }
}

class IOS {
  String? url;
  String? version;
  String? appId;

  IOS({this.url, this.version, this.appId});

  factory IOS.fromJson(Map<String, dynamic> json) {
    return IOS(
      url: json['Url'],
      version: json['Version'],
      appId: json['AppId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'Url': url, 'Version': version, 'AppId': appId};
  }
}

class Features {
  final bool showMembers;
  final bool showNotification;

  Features({required this.showMembers, required this.showNotification});

  factory Features.fromJson(Map<String, dynamic> json) {
    print("Features JSON: $json"); // 👈 add this
    return Features(
      showMembers: json['ShowMembers'] ?? true,
      showNotification: json['ShowNotification'] ?? true, // ✅ ADD
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ShowMembers': showMembers,
      'ShowNotification': showNotification, // ✅ ADD
    };
  }
}
