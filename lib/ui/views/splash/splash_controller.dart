import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kerala_association/ui/views/dashboard/dashboard_screen.dart';

import '../../../core/model/user_model.dart';
import '../../../core/state/app_launch_state.dart';
import '../contactUs/contact_screen.dart';
import '../create_account/create_account_screen.dart';
import '../management/management_screeen.dart';
import '../signUp/signUp_screen.dart';

class SplashController extends GetxController {
  var userModel = <UserModel>[].obs;
  var isLoading = true.obs;

  // Form controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final genderController = TextEditingController();
  final fruitController = TextEditingController();
  final emailController = TextEditingController();

  // Form key & focus nodes
  final formKey = GlobalKey<FormState>();
  final focusNode = FocusNode();
  final focusNodePhone = FocusNode();
  final focusNodeEmail = FocusNode();
  final focusNodePassword = FocusNode();

  @override
  void onInit() {
    super.onInit();
    init();
  }

  /// Initial method called on splash screen load
  Future<void> init() async {
    print("INSIDE INIT SPLASH CONTROLLER");
    // Simulate a short loading time (splash delay)
    await Future.delayed(const Duration(seconds: 2));

    // Optionally fetch data or check login state
    // await fetchUserData();

    /// 🚨 IMPORTANT FIX
    if (AppLaunchState.openedFromNotification) {
      return; // ❌ DO NOT navigate
    }
    // Navigate to dashboard (or login depending on logic)
    Get.off(() => DashboardScreen());
  //  Get.off(() => CreateAccountScreen());
    // OR Get.offNamed('/dashboard');
  }
}
