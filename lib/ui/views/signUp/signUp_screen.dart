
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kerala_association/common_widget/common_button.dart';
import 'package:kerala_association/common_widget/common_text_field.dart';
import 'package:kerala_association/ui/views/signIn/signIn_Screen.dart';
import 'package:kerala_association/ui/views/signUp/signUp_controller.dart';


import '../../../common_widget/common_dropdown.dart';
import '../../../common_widget/tap_outside_unfocus.dart';
import '../../../core/enum/view_state.dart';
import '../../../core/res/colors.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final SignUpController controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: TapOutsideUnFocus(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Form(
                key: controller.formSignUp,
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
                      child: Text(
                        "Create Your Account",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    SizedBox(height: 15),
                    Text("Full Name :", style: TextStyle(fontSize: 15)),
                    SizedBox(height: 6),
                    CommonTextField(
                      controller: controller.nameController,
                      focusNode: controller.nameFocusNode,
                      hintText: 'Enter Full Name',
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Please enter full name ';
                        }
                        return null;
                      },
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
                        RegExp phoneRegExp = RegExp(r'^[0-9]{10}$');
                        if (!phoneRegExp.hasMatch(val)) {
                          return 'Please enter a valid mobile number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),

                    Text("Email ID :", style: TextStyle(fontSize: 15)),
                    SizedBox(height: 6),
                    CommonTextField.email(
                      controller: controller.emailController,
                      focusNode: controller.emailFocusNode,
                      hintText: 'Enter Email-ID',
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return 'Please enter email';
                        }

                        final emailRegex = RegExp(
                          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+"
                          r"@"
                          r"[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?"
                          r"(?:\.[a-zA-Z]{2,})+$",
                        );

                        if (!emailRegex.hasMatch(val.trim())) {
                          return 'Please enter a valid email address';
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
                    SizedBox(height: 15),

                    Text("Confirm Password :", style: TextStyle(fontSize: 15)),
                    SizedBox(height: 6),
                    CommonTextField.password(
                      controller: controller.confirmPassController,
                      focusNode: controller.confirmPassFocusNode,
                      hintText: "Please Re-Enter Password",
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Password cannot be empty!';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),

                    Text("Select Branch :", style: TextStyle(fontSize: 15)),
                    SizedBox(height: 6),
                    // CommonTextField(
                    //   controller: controller.branchController,
                    //   focusNode: controller.branchFocusNode,
                    //   hintText: 'Select Branch',
                    //   suffixIcon: Icon(Icons.keyboard_arrow_down),
                    // ),

                    CommonDropdown<String>(
                      items: ['Chennai', 'Bangalore'],
                      hintText: 'Branch',
                      //  isRequired: true,
                      selectedItem:
                      controller.branchController.text.isNotEmpty
                          ? controller.branchController.text.capitalizeFirst
                          : null,
                      onChanged: (value) {
                        Gender? selectedStatus = Gender.values.firstWhere(
                              (e) => e.name.toLowerCase() == value?.toLowerCase(),
                          orElse: () => Gender.male,
                        );
                        controller.branchController.text = selectedStatus.name;
                        print("Selected: $selectedStatus");
                        print("Selected: ${controller.branchController.text}");
                      },
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Please select branch';
                        }
                        return null;
                      },
                    ),



                    SizedBox(height: 30),
                    CommonButton(
                      text: "SEND OTP",
                      onPressed: () {
                        controller.sendOtp();

                      },
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Already have a account ?",
                          style: TextStyle(fontSize: 15),
                        ),
                        InkWell(
                          onTap: () {
                            Get.off(SignInScreen());
                          },
                          child: Text(
                            "Login Here",
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColor.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
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
