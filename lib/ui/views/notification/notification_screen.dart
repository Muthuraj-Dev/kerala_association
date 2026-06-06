import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kerala_association/core/res/colors.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../common_widget/common_dialog.dart';
import '../../../services/onesignal_service.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with WidgetsBindingObserver {
  bool _isNotificationEnabled = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    // Initial sync when screen opens
    _syncNotificationState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Re-check when coming back from Settings
      _syncNotificationState();
    }
  }

  Future<void> _syncNotificationState() async {
    final status = await Permission.notification.status;
    final onesignalOptedIn = OneSignal.User.pushSubscription.optedIn == true;

    if (!mounted) return;

    setState(() {
      _isNotificationEnabled = status.isGranted && onesignalOptedIn;
    });
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: AppColor.background,
  //     appBar: AppBar(
  //       backgroundColor: Colors.transparent,
  //       title: Text("Notifications", style: TextStyle(color: AppColor.black)),
  //     ),
  //     body: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: SingleChildScrollView(
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Container(
  //               padding: const EdgeInsets.all(12),
  //               decoration: BoxDecoration(
  //                 color: AppColor.white,
  //                 borderRadius: BorderRadius.circular(12),
  //                 border: Border.all(color: AppColor.textPrimary),
  //               ),
  //               child: Row(
  //                 children: [
  //                   const Icon(Icons.notifications_active),
  //                   const SizedBox(width: 12),
  //                   const Expanded(
  //                     child: Text(
  //                       "Enable Notifications",
  //                       style: TextStyle(
  //                         fontSize: 16,
  //                         fontWeight: FontWeight.w500,
  //                       ),
  //                     ),
  //                   ),
  //                   CupertinoSwitch(
  //                     value: _isNotificationEnabled,
  //                     onChanged: (value) async {
  //                       await _handleNotificationToggle(value);
  //                     },
  //                   ),
  //                 ],
  //               ),
  //             ),
  //
  //             Text(
  //               "New",
  //               style: TextStyle(
  //                 fontSize: 18,
  //                 color: AppColor.primary,
  //                 fontWeight: FontWeight.w500,
  //               ),
  //             ),
  //             SizedBox(height: 10),
  //             Container(
  //               padding: EdgeInsets.all(8.0),
  //               decoration: BoxDecoration(
  //                 color: AppColor.white,
  //                 border: Border.all(color: AppColor.textPrimary),
  //                 borderRadius: BorderRadius.only(
  //                   topLeft: Radius.circular(12),
  //                   topRight: Radius.circular(12),
  //                   bottomLeft: Radius.circular(4),
  //                   bottomRight: Radius.circular(4),
  //                 ),
  //               ),
  //               child: Row(
  //                 children: [
  //                   Image.asset("assets/notify_gjiif.png", height: 38,),
  //                   SizedBox(width: 12),
  //                   Expanded(
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           "Kerala Jewellery International Fair",
  //                           style: TextStyle(
  //                             fontSize: 16,
  //                             fontWeight: FontWeight.w500,
  //                           ),
  //                         ),
  //                         Text(
  //                           "Visit Tamil Nadu's Biggest B2B Jewellery Exhibition",
  //                           style: TextStyle(
  //                             fontSize: 16,
  //                             fontWeight: FontWeight.w500,
  //                             color: AppColor.textDisable,
  //                           ),
  //                         ),
  //                         Text(
  //                           "5 Hours ago",
  //                           style: TextStyle(
  //                             fontSize: 12,
  //                             fontWeight: FontWeight.w500,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             SizedBox(height: 8),
  //             Container(
  //               padding: EdgeInsets.all(8.0),
  //               decoration: BoxDecoration(
  //                 color: AppColor.white,
  //                 border: Border.all(color: AppColor.textPrimary),
  //                 borderRadius: BorderRadius.only(
  //                   topLeft: Radius.circular(12),
  //                   topRight: Radius.circular(12),
  //                   bottomLeft: Radius.circular(4),
  //                   bottomRight: Radius.circular(4),
  //                 ),
  //               ),
  //               child: Row(
  //                 children: [
  //                   Image.asset("assets/notify_kerala.png", height: 38),
  //                   SizedBox(width: 12),
  //                   Expanded(
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           "Kerala Jewellery International Fair",
  //                           style: TextStyle(
  //                             fontSize: 16,
  //                             fontWeight: FontWeight.w500,
  //                           ),
  //                         ),
  //                         Text(
  //                           "Visit Tamil Nadu's Biggest B2B Jewellery Exhibition",
  //                           style: TextStyle(
  //                             fontSize: 16,
  //                             fontWeight: FontWeight.w500,
  //                             color: AppColor.textDisable,
  //                           ),
  //                         ),
  //                         Text(
  //                           "5 Hours ago",
  //                           style: TextStyle(
  //                             fontSize: 12,
  //                             fontWeight: FontWeight.w500,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             SizedBox(height: 8),
  //             Container(
  //               padding: EdgeInsets.all(8.0),
  //               decoration: BoxDecoration(
  //                 color: AppColor.white,
  //                 border: Border.all(color: AppColor.textPrimary),
  //                 borderRadius: BorderRadius.only(
  //                   topLeft: Radius.circular(12),
  //                   topRight: Radius.circular(12),
  //                   bottomLeft: Radius.circular(4),
  //                   bottomRight: Radius.circular(4),
  //                 ),
  //               ),
  //               child: Row(
  //                 children: [
  //                   Image.asset("assets/notify_gjiif.png", height: 38),
  //                   SizedBox(width: 12),
  //                   Expanded(
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           "Kerala Jewellery International Fair",
  //                           style: TextStyle(
  //                             fontSize: 16,
  //                             fontWeight: FontWeight.w500,
  //                           ),
  //                         ),
  //                         Text(
  //                           "Visit Tamil Nadu's Biggest B2B Jewellery Exhibition",
  //                           style: TextStyle(
  //                             fontSize: 16,
  //                             fontWeight: FontWeight.w500,
  //                             color: AppColor.textDisable,
  //                           ),
  //                         ),
  //                         Text(
  //                           "5 Hours ago",
  //                           style: TextStyle(
  //                             fontSize: 12,
  //                             fontWeight: FontWeight.w500,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //
  //             SizedBox(height: 8),
  //             Container(
  //               padding: EdgeInsets.all(8.0),
  //               decoration: BoxDecoration(
  //                 color: AppColor.white,
  //                 border: Border.all(color: AppColor.textPrimary),
  //                 borderRadius: BorderRadius.only(
  //                   topLeft: Radius.circular(12),
  //                   topRight: Radius.circular(12),
  //                   bottomLeft: Radius.circular(4),
  //                   bottomRight: Radius.circular(4),
  //                 ),
  //               ),
  //               child: Row(
  //                 children: [
  //                   Image.asset("assets/notify_gjiif.png", height: 38),
  //                   SizedBox(width: 12),
  //                   Expanded(
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           "Kerala Jewellery International Fair",
  //                           style: TextStyle(
  //                             fontSize: 16,
  //                             fontWeight: FontWeight.w500,
  //                           ),
  //                         ),
  //                         Text(
  //                           "Visit Tamil Nadu's Biggest B2B Jewellery Exhibition",
  //                           style: TextStyle(
  //                             fontSize: 16,
  //                             fontWeight: FontWeight.w500,
  //                             color: AppColor.textDisable,
  //                           ),
  //                         ),
  //                         Text(
  //                           "5 Hours ago",
  //                           style: TextStyle(
  //                             fontSize: 12,
  //                             fontWeight: FontWeight.w500,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //
  //             SizedBox(height: 12),
  //             Text(
  //               "Earlier",
  //               style: TextStyle(
  //                 fontSize: 18,
  //                 color: AppColor.primary,
  //                 fontWeight: FontWeight.w500,
  //               ),
  //             ),
  //             SizedBox(height: 10),
  //             Container(
  //               padding: EdgeInsets.all(8.0),
  //               decoration: BoxDecoration(
  //                 color: AppColor.white,
  //                 border: Border.all(color: AppColor.textPrimary),
  //                 borderRadius: BorderRadius.only(
  //                   topLeft: Radius.circular(12),
  //                   topRight: Radius.circular(12),
  //                   bottomLeft: Radius.circular(4),
  //                   bottomRight: Radius.circular(4),
  //                 ),
  //               ),
  //               child: Row(
  //                 children: [
  //                   Image.asset("assets/notify_kerala.png", height: 38),
  //                   SizedBox(width: 12),
  //                   Expanded(
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           "Kerala Jewellery International Fair",
  //                           style: TextStyle(
  //                             fontSize: 16,
  //                             fontWeight: FontWeight.w500,
  //                           ),
  //                         ),
  //                         Text(
  //                           "Visit Tamil Nadu's Biggest B2B Jewellery Exhibition",
  //                           style: TextStyle(
  //                             fontSize: 16,
  //                             fontWeight: FontWeight.w500,
  //                             color: AppColor.textDisable,
  //                           ),
  //                         ),
  //                         Text(
  //                           "12 Hours ago",
  //                           style: TextStyle(
  //                             fontSize: 12,
  //                             fontWeight: FontWeight.w500,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             SizedBox(height: 8),
  //             Container(
  //               padding: EdgeInsets.all(8.0),
  //               decoration: BoxDecoration(
  //                 color: AppColor.white,
  //                 border: Border.all(color: AppColor.textPrimary),
  //                 borderRadius: BorderRadius.only(
  //                   topLeft: Radius.circular(12),
  //                   topRight: Radius.circular(12),
  //                   bottomLeft: Radius.circular(4),
  //                   bottomRight: Radius.circular(4),
  //                 ),
  //               ),
  //               child: Row(
  //                 children: [
  //                   Image.asset("assets/notify_gjiif.png", height: 38),
  //                   SizedBox(width: 12),
  //                   Expanded(
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           "Kerala Jewellery International Fair",
  //                           style: TextStyle(
  //                             fontSize: 16,
  //                             fontWeight: FontWeight.w500,
  //                           ),
  //                         ),
  //                         Text(
  //                           "Visit Tamil Nadu's Biggest B2B Jewellery Exhibition",
  //                           style: TextStyle(
  //                             fontSize: 16,
  //                             fontWeight: FontWeight.w500,
  //                             color: AppColor.textDisable,
  //                           ),
  //                         ),
  //                         Text(
  //                           "12 Hours ago",
  //                           style: TextStyle(
  //                             fontSize: 12,
  //                             fontWeight: FontWeight.w500,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> newNotifications = [
      {
        "title": "South India Gold Expo",
        "subtitle": "Explore the latest gold collections from top jewellery brands across South India. Discover exclusive designs, new trends, and bulk buying opportunities all in one place.",
        "time": "2 hours ago",
        "image": "assets/notify_gjiif.png",
      },
      {
        "title": "Chennai Jewellery Meet",
        "subtitle": "Connect with premium jewellery wholesalers and manufacturers. Build strong business relationships and expand your network in the growing jewellery market.",
        "time": "4 hours ago",
        "image": "assets/notify_kerala.png",
      },
      {
        "title": "Diamond Showcase 2026",
        "subtitle": "Discover trending diamond collections, modern styles, and exclusive offers from leading exhibitors. A perfect opportunity to upgrade your inventory.",
        "time": "1 day ago",
        "image": "assets/notify_gjiif.png",
      },
      {
        "title": "Retailers Growth Summit",
        "subtitle": "Learn powerful strategies to scale your jewellery business. Attend expert sessions, gain insights, and unlock new growth opportunities in retail.",
        "time": "3 days ago",
        "image": "assets/notify_kerala.png",
      },
    ];

    final List<Map<String, dynamic>> earlierNotifications = [
      {
        "title": "Kerala Trade Expo",
        "subtitle": "Meet top jewellery manufacturers",
        "time": "12 hours ago",
        "image": "assets/notify_kerala.png",
      },
      {
        "title": "Gold Buyers Meetup",
        "subtitle": "Exclusive deals for bulk buyers",
        "time": "1 day ago",
        "image": "assets/notify_gjiif.png",
      },
    ];

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Notifications", style: TextStyle(color: AppColor.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            /// 🔔 Notification Toggle
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColor.textPrimary),
              ),
              child: Row(
                children: [
                  const Icon(Icons.notifications_active),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      "Enable Notifications",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  CupertinoSwitch(
                    value: _isNotificationEnabled,
                    onChanged: (value) async {
                      await _handleNotificationToggle(value);
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// 🔥 New Section
            _sectionTitle("New"),
            const SizedBox(height: 10),
            ...newNotifications.map((item) => _notificationCard(item)),

            const SizedBox(height: 16),

            /// 🕒 Earlier Section
            _sectionTitle("Earlier"),
            const SizedBox(height: 10),
            ...earlierNotifications.map((item) => _notificationCard(item)),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        color: AppColor.primary,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _notificationCard(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColor.white,
        border: Border.all(color: AppColor.textPrimary),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
          bottomLeft: Radius.circular(4),
          bottomRight: Radius.circular(4),
        ),
      ),
      child: Row(
        children: [
          Image.asset(item["image"], height: 38),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item["title"],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  item["subtitle"],
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColor.textDisable,
                  ),
                ),
                Text(
                  item["time"],
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleNotificationToggle(bool value) async {
    if (value) {
      final status = await Permission.notification.status;

      if (status.isPermanentlyDenied) {
        _showEnableNotificationDialog();
        return;
      }

      final granted = await OneSignal.Notifications.requestPermission(true);

      if (granted) {
        setState(() => _isNotificationEnabled = true);
      } else {
        _showEnableNotificationDialog();
        setState(() => _isNotificationEnabled = false);
      }
    } else {
      _showDisableInfoDialog();
      setState(() => _isNotificationEnabled = true);
    }
  }

  void _showEnableNotificationDialog() {
    CommonDialog.showConfirmDialog(
      title: "Enable Notifications",
      content:
          "Notifications are disabled. Please enable them from app settings.",
      confirmText: "Open Settings",
      cancelTextHide: true,
      onConfirm: () {
        openAppSettings();
      },
      dismissible: true,
    );
  }

  void _showDisableInfoDialog() {
    CommonDialog.showConfirmDialog(
      title: "Turn off Notifications",
      content: "You can turn off notifications from device settings.",
      confirmText: "Open Settings",
      cancelTextHide: true,
      onConfirm: () {
        openAppSettings();
      },
      dismissible: true,
    );
  }
}
