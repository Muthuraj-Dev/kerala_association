import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../signIn/signIn_Screen.dart';

class SignUpController extends GetxController{
  final TextEditingController nameController = TextEditingController();
  FocusNode nameFocusNode = FocusNode();

  final TextEditingController mobileController = TextEditingController();
  FocusNode mobileFocusNode = FocusNode();

  final TextEditingController emailController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();

  final TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocusNode = FocusNode();

  final TextEditingController confirmPassController = TextEditingController();
  FocusNode confirmPassFocusNode = FocusNode();

  final TextEditingController branchController = TextEditingController();
  FocusNode branchFocusNode = FocusNode();

  final formSignUp = GlobalKey<FormState>();


  @override
  void dispose() {
    nameController.dispose();
    nameFocusNode.dispose();

    super.dispose();
  }

  void sendOtp() {
    if (formSignUp.currentState?.validate() != true) {
      print('Form is invalid. Please correct the errors.');
      return;
    }
    Get.to(SignInScreen());
  }
}