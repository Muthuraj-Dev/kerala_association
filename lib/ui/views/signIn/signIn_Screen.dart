
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kerala_association/common_widget/common_button.dart';
import 'package:kerala_association/core/res/colors.dart';
import 'package:kerala_association/ui/views/forgetPassword/forgetPassword_screen.dart';
import 'package:kerala_association/ui/views/signIn/signIn_Controller.dart';
import 'package:kerala_association/ui/views/signUp/signUp_screen.dart';


import '../../../common_widget/common_text_field.dart';
import '../../../common_widget/tap_outside_unfocus.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final SignInController controller = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: TapOutsideUnFocus(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Form (
                key: controller.formSignIn,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 52),
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
                      child: Text("Sign-In", style: TextStyle(fontSize: 24)),
                    ),
                    SizedBox(height: 15),

                    Text("Mobile Number :", style: TextStyle(fontSize: 15)),
                    SizedBox(height: 6),
                    CommonTextField.phone(
                      controller: controller.mobileController,
                      focusNode: controller.mobileFocusNode,
                      hintText: 'Enter Mobile Number',
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Please enter mobile number';
                        }
                        RegExp phoneRegExp = RegExp(
                          r'^[0-9]{10}$',
                        );
                        if (!phoneRegExp.hasMatch(val)) {
                          return 'Please enter a valid mobile number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),

                    Text("Password :", style: TextStyle(fontSize: 15)),
                    SizedBox(height: 6),
                    CommonTextField.password(
                      controller: controller.passwordController,
                      focusNode: controller.passwordFocusNode,
                      hintText: "Enter Password",
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Password cannot be empty!';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30),
                    CommonButton(
                      text: "Login",
                      onPressed: () {
                        controller.signIn();

                      },
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Don’t have an account ?",
                          style: TextStyle(fontSize: 15),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(SignupScreen());
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColor.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    InkWell(
                      onTap: () {
                        Get.to(ForgetPasswordScreen());
                      },
                      child: Text(
                        "Forget Password ?",
                        style: TextStyle(
                          color: AppColor.error,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
