import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kerala_association/common_widget/common_button.dart';
import 'package:kerala_association/common_widget/common_text_field.dart';
import 'package:kerala_association/common_widget/tap_outside_unfocus.dart';
import 'package:kerala_association/core/res/colors.dart';
import 'package:kerala_association/ui/views/phone/phone_controller.dart';

import '../../../helper/update_checker.dart';

class PhoneScreen extends GetView<PhoneController> {
  const PhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PhoneController>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Phone Verification",
          style: TextStyle(color: AppColor.black),
        ),
      ),
      body: TapOutsideUnFocus(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: controller.formSignUp,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        SvgPicture.asset("assets/phone.svg"),
                        const SizedBox(height: 6),
                        const Text(
                          "Verify Your Phone",
                          style: TextStyle(fontSize: 24),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            "We'll send you a verification code to confirm your phone number",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColor.textDisable,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 50),
                        const Text(
                          "Enter your mobile number",
                          style: TextStyle(fontSize: 18, color: AppColor.black),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(18.0),
                                child: Text(
                                  "+91",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: CommonTextField.phone(
                                controller: controller.phoneController,
                                focusNode: controller.phoneFocusNode,
                                fillColor: AppColor.background,
                                borderColor: AppColor.textDisable,
                                hintText: 'Enter phone number',
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'Please enter phone number';
                                  }
                                  RegExp phoneRegExp = RegExp(r'^[0-9]{10}$');
                                  if (!phoneRegExp.hasMatch(val)) {
                                    return 'Please enter a valid phone number';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const _VerificationInfoBox(),
                        const SizedBox(height: 50),
                        Obx(() {
                          return CommonButton(
                            text:
                                controller.isLoading.value
                                    ? "Sending..."
                                    : "Send Verification Code",
                            onPressed: () {
                              controller.isLoading.value
                                  ? null
                                  : controller.submit();
                            },
                            borderRadius: BorderRadius.circular(40),
                            suffixIcon:
                                controller.isLoading.value
                                    ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                    : SvgPicture.asset(
                                      "assets/arrow_outward.svg",
                                      color: Colors.white,
                                    ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
                // 4. Extracted the footer as well.
                const _SecureInfoFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Private helper widget for the verification info box
class _VerificationInfoBox extends StatelessWidget {
  const _VerificationInfoBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AppColor.white,
        border: Border.all(color: AppColor.primary),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, size: 30, color: AppColor.primary),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              "We'll send you a 4-digit verification code.",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}

// Private helper widget for the secure info footer
class _SecureInfoFooter extends StatelessWidget {
  const _SecureInfoFooter();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/security.svg"),
          const SizedBox(width: 4),
          const Text(
            "Your information is secure and encrypted",
            style: TextStyle(fontSize: 14, color: AppColor.textDisable),
          ),
        ],
      ),
    );
  }
}
