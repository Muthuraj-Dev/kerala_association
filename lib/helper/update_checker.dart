import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

import '../core/res/colors.dart';
import '../core/res/styles.dart';
import '../core/res/spacing.dart';
import '../core/res/images.dart';

import '../services/appconfig_service.dart';
import '../ui/widgets/button.dart';

// class UpdateChecker {
//   versionCheck() async {
//     final PackageInfo info = await PackageInfo.fromPlatform();
//     final String currentVersion = info.version;
//
//     try {
//       final AppConfig appConfig = locator<AppConfigService>().config;
//
//       final String version =
//           Platform.isAndroid
//               ? appConfig.android?.version ?? ''
//               : appConfig.iOS?.version ?? '';
//
//       final String url =
//           Platform.isAndroid
//               ? appConfig.android?.url ?? ''
//               : appConfig.iOS?.url ?? '';
//
//       final bool isForceUpdate = appConfig.forceUpdate ?? false;
//
//       if (version.isEmpty || url.isEmpty) return;
//
//       final int remoteVersion = int.parse(version.replaceAll(".", ""));
//       final int localVersion = int.parse(currentVersion.replaceAll(".", ""));
//
//       print("remoteVersion $remoteVersion");
//       print("localVersion $localVersion");
//
//       if (remoteVersion > localVersion) {
//         // && (appConfig.forceUpdate ?? false)
//         print("TRUEEEE");
//         await Get.dialog(
//           AlertDialog(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             content: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   //       SvgPicture.asset(Images.updateIcon),
//                   VerticalSpacing.custom(value: 24),
//                   Text("Update Available"),
//                   VerticalSpacing.custom(value: 12),
//                   Text(
//                     isForceUpdate
//                         ? "You must update the app to continue using it."
//                         : "A new version is available for better experience.",
//                     style: const TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff414141),
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   VerticalSpacing.custom(value: 20),
//                   Button(
//                     "Update",
//                     key: UniqueKey(),
//                     // onPressed: () async {
//                     //   print("URL=== $url");
//                     //   if (await canLaunchUrl(Uri.parse(url))) {
//                     //     await launchUrl(
//                     //       Uri.parse(url),
//                     //       mode: LaunchMode.externalApplication,
//                     //     );
//                     //   }
//                     //   Get.back(); // Close dialog
//                     // },
//                       onPressed: () async {
//                         print("URL=== $url");
//
//                         final uri = Uri.parse(url);
//
//                         if (await canLaunchUrl(uri)) {
//                           final launched = await launchUrl(
//                             uri,
//                             mode: LaunchMode.externalApplication,
//                           );
//
//                           if (launched) {
//                             Get.back(); // Close only if launch succeeded
//                           }
//                         } else {
//                           print("Could not launch $url");
//                         }
//                       }
//                   ),
//
//                   if (!isForceUpdate) ...[
//                     VerticalSpacing.custom(value: 12),
//                     Button(
//                       "Later",
//                       color: AppColor.divider,
//                       textStyle: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w700,
//                         color: Color(0xff312D4A),
//                       ),
//                       onPressed: Get.back,
//                     ),
//                   ],
//
//                 ],
//               ),
//             ),
//           ),
//           barrierDismissible: !isForceUpdate,
//         );
//       }
//     } catch (exception, stacktrace) {
//       // Logger.e("Unable to check for version info", e: exception, s: stacktrace);
//       print("Version check failed $stacktrace");
//     }
//   }
// }


class UpdateChecker extends GetxService {
  Future<void> versionCheck() async {
    final configService = Get.find<AppConfigService>();

    // ✅ Wait until config is loaded
    if (!configService.isLoaded.value) {
      ever(configService.isLoaded, (loaded) {
        if (loaded == true) {
          versionCheck(); // retry once loaded
        }
      });
      return;
    }

    final PackageInfo info = await PackageInfo.fromPlatform();
    final String currentVersion = info.version;

    try {
      final AppConfig appConfig = configService.config;

      final String version = Platform.isAndroid
          ? appConfig.android?.version ?? ''
          : appConfig.iOS?.version ?? '';

      final String url = Platform.isAndroid
          ? appConfig.android?.url ?? ''
          : appConfig.iOS?.url ?? '';

      final bool isForceUpdate = appConfig.forceUpdate ?? false;

      if (version.isEmpty || url.isEmpty) return;

      final int remoteVersion = int.parse(version.replaceAll(".", ""));
      final int localVersion = int.parse(currentVersion.replaceAll(".", ""));

      print("remoteVersion $remoteVersion");
      print("localVersion $localVersion");

      if (remoteVersion > localVersion) {
        await Get.dialog(
          AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 24),

                const Text("Update Available"),

                const SizedBox(height: 12),

                Text(
                  isForceUpdate
                      ? "You should update the app to continue using it."
                      : "A new version is available for better experience.",
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () async {
                    final uri = Uri.parse(url);

                    if (await canLaunchUrl(uri)) {
                      final launched = await launchUrl(
                        uri,
                        mode: LaunchMode.externalApplication,
                      );

                      if (launched) Get.back();
                    }
                  },
                  child: const Text("Update"),
                ),

                if (!isForceUpdate) ...[
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: Get.back,
                    child: const Text("Later"),
                  ),
                ],
              ],
            ),
          ),
          barrierDismissible: !isForceUpdate,
        );
      }
    } catch (e, s) {
      print("Version check failed: $e\n$s");
    }
  }
}