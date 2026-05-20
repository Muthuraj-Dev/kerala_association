

import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:kerala_association/ui/views/dashboard/dashboard_screen.dart';
import 'package:kerala_association/ui/views/newsDetail/newsDetail_screen.dart';
import 'package:kerala_association/ui/views/splash/splash_screen.dart';


class AppRoutes {
  static const String splash = '/';
  static const String loginScreen = '/signUp';
  static const String dashboardScreen = '/dashboard';

  // Define the pages and their routes
  static final List<GetPage> pages = [
    GetPage(
      name: splash,
      page: () => SplashScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: dashboardScreen,
      page: () => DashboardScreen(),
      transition: Transition.rightToLeft,
    ),

    // Add more pages here
  ];
}
