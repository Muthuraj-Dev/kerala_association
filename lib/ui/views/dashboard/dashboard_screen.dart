
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kerala_association/ui/views/events/event_screen.dart';
import 'package:kerala_association/ui/views/home/home_screen.dart';
import 'package:kerala_association/ui/views/members/member_screen.dart';
import 'package:kerala_association/ui/views/notification/notification_screen.dart';
import 'package:kerala_association/ui/views/profile/profile_screen.dart';
import '../../../core/res/colors.dart';

import '../../../helper/update_checker.dart';
import '../news/news_screen.dart';
import 'dashboard_controller.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final DashboardController controller =
  Get.put(DashboardController(), permanent: true);

  static final List<Widget> _pages = [
    HomeScreen(),
    NewsScreen(),
    EventScreen(),
    // MemberScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final index = controller.selectedIndex.value;

      return Scaffold(
        extendBodyBehindAppBar: index == 0,

        appBar: _DashboardAppBar(),
     //   appBar: index == 3 ? null : const _DashboardAppBar(),

        body: IndexedStack(
          index: index,
          children: _pages,
        ),

        bottomNavigationBar: _DashboardBottomNav(),
      );
    });
  }
}

class _DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _DashboardAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
      return AppBar(
        elevation: 2,
        backgroundColor: AppColor.background,

        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 40, left: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Image.asset(
              'assets/Logo.png',
              height: 50,
            ),
          ),
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, size: 30),
            color: AppColor.secondary,
            onPressed: () => Get.to(() => NotificationScreen()),
          ),
        ],
      );
  }
}

class _DashboardBottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardController>();

    return Obx(() {
      final index = controller.selectedIndex.value;

      return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColor.background,
        currentIndex: index,
        elevation: 0,
        selectedItemColor: AppColor.secondary,
        unselectedItemColor: AppColor.green,
        onTap: controller.onItemTapped,

        items: [
          _navItem('Home', 'assets/home_inactive.png', index == 0),
          _navItem('News', 'assets/newsIcon.png', index == 1),
          _navItem('Events', 'assets/event_inactive.png', index == 2),
      //    _navItem('Members', 'assets/member_inactive.png', index == 3),
          _navItem('Profile', 'assets/profile_inactive.png', index == 3),
        ],
      );
    });
  }
  BottomNavigationBarItem _navItem(
      String label, String asset, bool selected) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        asset,
        width: 28,
        height: 28,
        color: selected ? AppColor.secondary : AppColor.green,
      ),
      label: label,
    );
  }
}
