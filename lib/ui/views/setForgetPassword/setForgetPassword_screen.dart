
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kerala_association/common_widget/common_button.dart';
import 'package:kerala_association/common_widget/common_text_field.dart';
import 'package:kerala_association/common_widget/tap_outside_unfocus.dart';
import 'package:kerala_association/core/res/colors.dart';
import 'package:kerala_association/ui/views/setForgetPassword/setForgetPassword_Controller.dart';

import '../signIn/signIn_Screen.dart';


class SetForgetPasswordScreen extends StatefulWidget {
  const SetForgetPasswordScreen({super.key});

  @override
  State<SetForgetPasswordScreen> createState() => _SetForgetPasswordScreenState();
}

class _SetForgetPasswordScreenState extends State<SetForgetPasswordScreen> {

  final SetForgetPasswordController controller = Get.put(SetForgetPasswordController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.background,
      body : SafeArea(
        child: TapOutsideUnFocus (
          child: SingleChildScrollView (
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back, color: AppColor.black),
                  ),
                  SizedBox(height: 50),
                  Center(
                    child: Container(
                      height: 129,
                      width: 129,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                          image: AssetImage("assets/logo.png"),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: Text(
                      "Set New Password",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  SizedBox(height: size.height * 0.09),
                  Text("Password :", style: TextStyle(fontSize: 15)),
                  SizedBox(height: 6),
                  CommonTextField(
                    controller: controller.passwordController,
                    focusNode: controller.passwordFocusNode,
                    hintText: "Enter Password",
                  ),
                  SizedBox(height: 15),

                  Text("Re-Enter Password :", style: TextStyle(fontSize: 15)),
                  SizedBox(height: 6),
                  CommonTextField(
                    controller: controller.reEnterPassController,
                    focusNode: controller.reEnterPassFocusNode,
                    hintText: "Confirm Password",
                  ),

                  SizedBox(height: 30),
                  CommonButton(
                    text: "Change Password",
                    onPressed: () {
                      Get.offAll(SignInScreen());
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
