import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController{
  final TextEditingController mobileController = TextEditingController();
  FocusNode mobileFocusNode = FocusNode();


  @override
  void dispose() {
    // TODO: implement dispose
    mobileController.dispose();

    super.dispose();
  }


}