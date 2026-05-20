//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:kerala_association/common_widget/common_button.dart';
// import 'package:kerala_association/common_widget/tap_outside_unfocus.dart';
// import 'package:kerala_association/core/res/colors.dart';
// import 'package:kerala_association/ui/views/create_account/create_account_screen.dart';
// import 'package:pinput/pinput.dart';
//
// import '../../../common_widget/common_text_field.dart';
// import '../setForgetPassword/setForgetPassword_screen.dart';
// import 'otp_controller.dart';
//
// class OtpScreen extends StatefulWidget {
//   const OtpScreen({super.key});
//
//   @override
//   State<OtpScreen> createState() => _OtpScreenState();
// }
//
// class _OtpScreenState extends State<OtpScreen> {
//   final OtpController controller = Get.put(OtpController());
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: AppColor.background,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         title: Text(
//           "OTP Verification",
//           style: TextStyle(color: AppColor.black),
//         ),
//       ),
//       body: TapOutsideUnFocus(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Column(
//             children: [
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       SizedBox(height: 10),
//                       SvgPicture.asset("assets/message.svg"),
//                       SizedBox(height: 6),
//                       Text(
//                         "Enter Verification Code",
//                         style: TextStyle(fontSize: 24),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 85),
//                         child: Text(
//                           "We've sent a 6-digit code to +91 123 456 7890",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w500,
//                             color: AppColor.textDisable,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                       SizedBox(height: 50),
//                       Pinput(
//                         length: 6,
//                         controller: controller.otpController,
//                         focusNode: controller.otpFocusNode,
//                         defaultPinTheme: PinTheme(
//                           width: size.width * 0.6,
//                           height: size.height / 15,
//                           textStyle: const TextStyle(
//                             fontSize: 24,
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           decoration: BoxDecoration(
//                             color: Colors.transparent,
//                             borderRadius: BorderRadius.circular(12),
//                             border: Border.all(color: AppColor.textDisable),
//                           ),
//                         ),
//                         focusedPinTheme: PinTheme(
//                           width: size.width * 0.6,
//                           height: size.height / 15,
//                           textStyle: const TextStyle(
//                             fontSize: 24,
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           decoration: BoxDecoration(
//                             color: Colors.transparent,
//                             borderRadius: BorderRadius.circular(12),
//                             border: Border.all(color: AppColor.textDisable),
//                           ),
//                         ),
//                         submittedPinTheme: PinTheme(
//                           width: size.width * 0.6,
//                           height: size.height / 15,
//                           textStyle: const TextStyle(
//                             fontSize: 24,
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           decoration: BoxDecoration(
//                             color: Colors.transparent,
//                             borderRadius: BorderRadius.circular(12),
//                             border: Border.all(color: AppColor.textDisable),
//                           ),
//                         ),
//                         separatorBuilder: (index) => const SizedBox(width: 8),
//                         keyboardType: TextInputType.number,
//                         onChanged: (value) {},
//                       ),
//                       SizedBox(height: 10),
//                       Text(
//                         "Didn't receive OTP ?  Resend OTP in 00:56",
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                           color: AppColor.black,
//                         ),
//                       ),
//                       SizedBox(height: 60),
//                       CommonButton(
//                         text: "Verify Code",
//                         onPressed: () {
//                           print("Print");
//                           Get.to(CreateAccountScreen());
//                         },
//                      //   isDisabled: controller.otpController.text.isEmpty ? true : false,
//                         borderRadius: BorderRadius.circular(40),
//                         suffixIcon: SvgPicture.asset(
//                           "assets/arrow_outward.svg",
//                           color: Colors.white,
//                         ),
//                       ),
//                       SizedBox(height: 26),
//                       Text(
//                         "Change Phone Number",
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                           color: AppColor.black,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 16),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SvgPicture.asset("assets/security.svg"),
//                     SizedBox(width: 4),
//                     Text(
//                       "Your information is secure and encrypted",
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: AppColor.textDisable,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kerala_association/common_widget/common_button.dart';
import 'package:kerala_association/common_widget/tap_outside_unfocus.dart';
import 'package:kerala_association/core/res/colors.dart';
import 'package:kerala_association/ui/views/create_account/create_account_screen.dart';
import 'package:pinput/pinput.dart';

import 'otp_controller.dart';

// 1. Converted to a GetView for cleaner controller access.
class OtpScreen extends GetView<OtpController> {
  final String mobileNumber;
  final int otpId;
  final int sentOtp;

  const OtpScreen({
    super.key,
    required this.mobileNumber,
    required this.otpId,
    required this.sentOtp,
  });

  @override
  Widget build(BuildContext context) {
    // Controller is injected via Get.to() or bindings, but Get.put() is a safe fallback.
    final controller = Get.put(
      OtpController(
        mobileNumber: mobileNumber,
        otpId: otpId,
        sentOtp: sentOtp,
      ),
    );

    // 2. Defined the PinTheme once to be reused.
    final defaultPinTheme = PinTheme(
      width: 56, // Fixed width is generally better than percentage-based
      height: 60,
      textStyle: const TextStyle(
        fontSize: 24,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.textDisable),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "OTP Verification",
          style: TextStyle(color: AppColor.black),
        ),
      ),
      body: TapOutsideUnFocus(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Form (
                    key: controller.formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        SvgPicture.asset("assets/message.svg"),
                        const SizedBox(height: 6),
                        const Text(
                          "Enter Verification Code",
                          style: TextStyle(fontSize: 24),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          // 4. TODO: Replace hardcoded text with data from controller
                          child: Obx(
                            () => Text(
                              // This text should come from your controller
                              "We've sent a 4-digit code to ${controller.formattedPhoneNumber.value}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColor.textDisable,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                        Pinput(
                          length: 4,
                          controller: controller.otpController,
                          focusNode: controller.otpFocusNode,
                          // Reusing the same theme definition
                          defaultPinTheme: defaultPinTheme,
                          validator: (value) {
                            if (value == null || value.length != 4) {
                              return 'Enter valid 4-digit OTP';
                            }
                            return null; // Valid
                          },
                          errorTextStyle: TextStyle(color: Colors.red),

                          focusedPinTheme: defaultPinTheme.copyWith(
                            decoration: defaultPinTheme.decoration!.copyWith(
                              border: Border.all(
                                color: AppColor.primary,
                              ), // Example of slight change
                            ),
                          ),
                          submittedPinTheme: defaultPinTheme,
                          separatorBuilder: (index) => const SizedBox(width: 8),
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 20),
                        // 4. TODO: This text should be reactive from the controller
                        Obx(
                          () => Text(
                            controller.resendTimerText.value,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColor.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 60),
                        Obx(() {
                          return CommonButton(
                            text:
                                controller.isLoading.value
                                    ? "Verifying..."
                                    : "Verify Code",
                            onPressed: () {
                              controller.isLoading.value
                                  ? null
                                  : controller.verifyOtp();
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

                        const SizedBox(height: 26),
                        GestureDetector(
                          // Allow tapping to go back
                          onTap: () => Get.back(),
                          child: const Text(
                            "Change Phone Number",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColor.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // 5. Extracted footer into its own widget
              const _SecureInfoFooter(),
            ],
          ),
        ),
      ),
    );
  }
}

// Helper widget for the footer to keep the build method clean
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
