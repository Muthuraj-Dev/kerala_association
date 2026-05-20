import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kerala_association/core/model/otp_response.dart';
import 'package:kerala_association/ui/views/otp/otp_screen.dart';

import '../../../services/api_base_service.dart';
import '../../../services/request_method.dart';
import '../../../services/secure_storage_service.dart';

class PhoneController extends GetxController {
  final TextEditingController phoneController = TextEditingController();
  final FocusNode phoneFocusNode = FocusNode();
  final formSignUp = GlobalKey<FormState>();

  final isLoading = false.obs;

  final storage = Get.find<SecureStorageService>();

  @override
  void onReady() {
    super.onReady();

    // Delay ensures keyboard opens consistently on Android & iOS
    Future.delayed(const Duration(milliseconds: 300), () {
      if (!phoneFocusNode.hasFocus) {
        phoneFocusNode.requestFocus();
      }
    });
  }


  /// store otp session info
  int? otpId;

  /// SEND OTP API
  Future<void> submit() async {
    if (formSignUp.currentState?.validate() != true) {
      return;
    }

    final phone = phoneController.text.trim();

    try {
      isLoading(true);

      final OtpResponse response =
      await ApiBaseService.request<OtpResponse>(
        'OTP/SentOTP?mobileNumber=$phone',
        method: RequestMethod.GET,
        authenticated: false,
      );

      if (response.status == "200" && response.data != null) {
        otpId = response.data!.otpId;

        await storage.write('mobile_number', phone);

        /// Navigate only after success
        Get.to(() => OtpScreen(
          mobileNumber: phone,
          otpId: otpId!,
          sentOtp: response.data!.sentOtp!,
        ));
      } else {
        Get.snackbar(
          "Error",
          response.message ?? "Failed to send OTP",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      debugPrint("❌ OTP API error: $e");
      Get.snackbar(
        "Network Error",
        "Please try again",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {
    phoneController.dispose();
    phoneFocusNode.dispose();
    super.onClose();
  }
}
