import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SetForgetPasswordController extends GetxController{
  final TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocusNode = FocusNode();

  final TextEditingController reEnterPassController = TextEditingController();
  FocusNode reEnterPassFocusNode = FocusNode();


  @override
  void dispose() {
    // TODO: implement dispose
    passwordController.dispose();
    passwordFocusNode.dispose();

    reEnterPassController.dispose();
    reEnterPassFocusNode.dispose();

    super.dispose();
  }

}