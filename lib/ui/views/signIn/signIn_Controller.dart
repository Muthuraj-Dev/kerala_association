import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../dashboard/dashboard_screen.dart';


class SignInController extends GetxController{
  final TextEditingController mobileController = TextEditingController();
  FocusNode mobileFocusNode = FocusNode();

  final TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocusNode = FocusNode();

  final formSignIn = GlobalKey<FormState>();



  @override
  void dispose() {
    // TODO: implement dispose
    mobileController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  void signIn() {
    if (formSignIn.currentState?.validate() != true) {
      print('Form is invalid. Please correct the errors.');
      return;
    }
    Get.off(DashboardScreen());
  }

}