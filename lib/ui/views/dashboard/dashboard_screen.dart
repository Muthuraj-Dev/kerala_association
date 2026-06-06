
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kerala_association/ui/views/events/event_screen.dart';
import 'package:kerala_association/ui/views/home/home_screen.dart';
import 'package:kerala_association/ui/views/members/member_screen.dart';

import 'package:kerala_association/ui/views/profile/profile_screen.dart';
import '../../../core/res/colors.dart';
import '../../../services/appconfig_service.dart';
import '../news/news_screen.dart';
import '../notification/notification_screen.dart';
import 'dashboard_controller.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final DashboardController controller =
  Get.put(DashboardController(), permanent: true);

  final AppConfigService configService = Get.find();

  // static final List<Widget> pages = [
  //   HomeScreen(),
  //   NewsScreen(),
  //   EventScreen(),
  //   MemberScreen(),   // Here display/hide dynamically
  //   ProfileScreen(),
  // ];

  /// 🔥 Dynamic pages (reactive-safe)
  List<Widget> getPages() {
    final config = configService.configRx.value; // ✅ THIS is key

    final pages = <Widget>[
      HomeScreen(),
      NewsScreen(),
      EventScreen(),
    ];

    if (config.features?.showMembers ?? true) {
      pages.add(MemberScreen());
    }

    pages.add(ProfileScreen());

    return pages;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {

      // ✅ STEP 1: Block UI until config is ready
      if (!configService.isLoaded.value) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }

      final pages = getPages();

      // 🔥 prevent crash if tabs change
      controller.validateIndex(pages.length);

      final index = controller.selectedIndex.value;

      return Scaffold(
        extendBodyBehindAppBar: index == 0,

        appBar: _DashboardAppBar(),

        body: IndexedStack(
          index: index,
          children: pages,
        ),

   //     bottomNavigationBar: _DashboardBottomNav(),
        bottomNavigationBar: _DashboardBottomNav(pages: pages),
      );
    });
  }
}

// class _DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const _DashboardAppBar();
//
//   @override
//   Size get preferredSize => const Size.fromHeight(60);
//
//   @override
//   Widget build(BuildContext context) {
//       return AppBar(
//         elevation: 2,
//         backgroundColor: AppColor.background,
//
//         flexibleSpace: Padding(
//           padding: const EdgeInsets.only(top: 40, left: 10),
//           child: Align(
//             alignment: Alignment.centerLeft,
//             child: Image.asset(
//               'assets/Logo.png',
//               height: 50,
//             ),
//           ),
//         ),
//
//         // Temporary Hide //
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.notifications, size: 30),
//             color: AppColor.secondary,
//             onPressed: () => Get.to(() => NotificationScreen()),
//           ),
//         ],
//       );
//   }
// }

class _DashboardAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const _DashboardAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    final configService = Get.find<AppConfigService>();

    return Obx(() {
      final showNotification = configService.showNotification;

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
          if (showNotification) // ✅ controlled by remote config
            IconButton(
              icon: const Icon(Icons.notifications, size: 30),
              color: AppColor.secondary,
              onPressed: () {
                // extra safety (optional but good)
                if (configService.showNotification) {
                  Get.to(() => NotificationScreen());
                }
              },
            ),
        ],
      );
    });
  }
}

class _DashboardBottomNav extends StatelessWidget {
  final List<Widget> pages;
  const _DashboardBottomNav({required this.pages});


  @override
  Widget build(BuildContext context) {

    final controller = Get.find<DashboardController>();
    final configService = Get.find<AppConfigService>();


    return Obx(() {
      final index = controller.selectedIndex.value;

      // ✅ MUST read Rx value here (this triggers rebuild)
      final config = configService.configRx.value;
      final showMembers = config.features!.showMembers;

      final items = <BottomNavigationBarItem>[
        _navItem('Home', 'assets/home_inactive.png', index == 0),
        _navItem('News', 'assets/newsIcon.png', index == 1),
        _navItem('Pre-Register', 'assets/event_inactive.png', index == 2),
      ];

      // ✅ Proper reactive condition
      if (showMembers) {
        items.add(
          _navItem('Members', 'assets/member_inactive.png', index == items.length),
        );
      }

      // ✅ Always add Profile
      items.add(
        _navItem('Profile', 'assets/profile_inactive.png', index == items.length),
      );

      return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColor.background,
        currentIndex: index,
        elevation: 0,
        selectedItemColor: AppColor.secondary,
        unselectedItemColor: AppColor.green,
        onTap: controller.onItemTapped,
        items: items,
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
