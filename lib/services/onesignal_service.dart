import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

import '../common_widget/common_dialog.dart';
import '../core/res/colors.dart';
import '../core/state/app_launch_state.dart';
import '../ui/views/dashboard/dashboard_controller.dart';
import '../ui/views/dashboard/dashboard_screen.dart';

class OneSignalService {
  static const String _appId = "72ad7a78-09fe-4bf9-b3a9-98db4d68bb18";

  static Future<void> init(BuildContext context) async {
    if (kDebugMode) {
      OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    }

    OneSignal.initialize(_appId);
    debugPrint("🔥 OneSignal initialized");

    // // ✅ HANDLE OS PERMISSION FIRST
    await requestNotificationPermission(context);

    // ✅ READ CURRENT STATE
    final sub = OneSignal.User.pushSubscription;
    debugPrint("📌 CURRENT SUB ID: ${sub.id}");
    debugPrint("📌 CURRENT TOKEN: ${sub.token}");
    debugPrint("📌 CURRENT OPTED IN: ${sub.optedIn}");

    // ✅ LISTEN FOR FUTURE CHANGES
    OneSignal.User.pushSubscription.addObserver((state) {
      debugPrint("🔄 Subscription observer fired");
      debugPrint("SUB ID: ${state.current.id}");
      debugPrint("TOKEN: ${state.current.token}");
      debugPrint("OPTED IN: ${state.current.optedIn}");
      if (state.current.id != null) {
        // 🔥 SEND TO BACKEND
 //       sendSubscriptionToBackend(state.current.id);
      }
    });

    OneSignal.Notifications.addClickListener((event) {
      AppLaunchState.openedFromNotification = true;
      final data = event.notification.additionalData;

      if (data == null) return;

      if (data["screen"] == "news") {
        final newsId = data["news_id"]?.toString();

        if (newsId == null || newsId.isEmpty) return;

        // 1. Go to dashboard
        Get.offAll(() => DashboardScreen());

        // 2. Wait until UI is ready (safer than fixed delay)
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final dashboardController = Get.find<DashboardController>();

          dashboardController.setPendingNews(newsId);
          dashboardController.onItemTapped(1);
        });
      }
    });

  }

  /// ✅ SIMPLE HELPER FOR UI
  static bool get isNotificationEnabled {
    return OneSignal.User.pushSubscription.optedIn == true;
  }

  /// ✅ OPTIONAL: expose subscription ID safely
  static String? get subscriptionId {
    return OneSignal.User.pushSubscription.id;
  }


  static Future<void> requestNotificationPermission(
      BuildContext context) async {
    // Android 13+ requires runtime permission
    final status = await Permission.notification.status;

    debugPrint("🔔 Notification permission status: $status");

    if (status.isGranted) {
      return;
    }

    if (status.isPermanentlyDenied) {
      _showSettingsDialog(context);
      return;
    }

    // Ask permission
    final result = await Permission.notification.request();

    if (result.isGranted) {
      return;
    }

    if (result.isPermanentlyDenied) {
      _showSettingsDialog(context);
    } else {
      Fluttertoast.showToast(
        msg: "Please allow notifications to stay updated",
      );
    }
  }

  static void _showSettingsDialog(BuildContext context) {
    CommonDialog.showConfirmDialog(
      title: "Enable Notifications",
      content:
      "Notifications are disabled. Please enable them from app settings to receive updates.",
      confirmText: "Open Settings",
      cancelTextHide: true,
      leading: Icon(
        Icons.notifications_active_outlined,
        size: 48,
        color: AppColor.primary,
      ),
      onConfirm: () {
        openAppSettings();
      },
      dismissible: true,
    );
  }
}