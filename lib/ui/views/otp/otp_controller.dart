import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kerala_association/ui/views/create_account/create_account_screen.dart';
import '../../../services/api_base_service.dart';
import '../../../services/request_method.dart';
import '../../../services/secure_storage_service.dart';
import '../dashboard/dashboard_screen.dart';
import '../members/member_controller.dart';
import '../profile/profile_controller.dart';

class OtpController extends GetxController {
  final TextEditingController otpController = TextEditingController();
  final FocusNode otpFocusNode = FocusNode();

  final formKey = GlobalKey<FormState>();

  OtpController({required this.mobileNumber, required this.otpId, required this.sentOtp});

  /// --- Reactive State ---
  final RxString formattedPhoneNumber = ''.obs;
  final RxString resendTimerText = 'Resend OTP'.obs;
  final RxInt _timerCountdown = 60.obs;
  final RxBool canResend = false.obs;
  final RxBool isLoading = false.obs;

  Timer? _timer;

  late String mobileNumber;
  late int otpId;
  late int sentOtp;


  final storage = Get.find<SecureStorageService>();

  @override
  void onInit() {
    super.onInit();

    formattedPhoneNumber.value =
    '+91 ******${mobileNumber.substring(mobileNumber.length - 4)}';

    // otpController.text = sentOtp.toString();  -- Use to set Prefill OTP - for Testing

    startTimer();
  }

  @override
  void onReady() {
    super.onReady();

    // Delay ensures keyboard opens consistently on Android & iOS
    Future.delayed(const Duration(milliseconds: 300), () {
      if (!otpFocusNode.hasFocus) {
        otpFocusNode.requestFocus();
      }
    });
  }

  @override
  void onClose() {
    otpController.dispose();
    otpFocusNode.dispose();
    _timer?.cancel();
    super.onClose();
  }

  // ---------------- TIMER ----------------

  void startTimer() {
    canResend.value = false;
    _timerCountdown.value = 59;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerCountdown.value > 0) {
        resendTimerText.value =
            "Resend OTP in 00:${_timerCountdown.value.toString().padLeft(2, '0')}";
        _timerCountdown.value--;
      } else {
        resendTimerText.value = "Resend OTP";
        canResend.value = true;
        timer.cancel();
      }
    });
  }

  // Future<void> verifyOtp() async {
  //   if (!formKey.currentState!.validate()) {
  //     return;
  //   }
  //
  //   final enteredOTP = otpController.text;
  //
  //   if (otpController.text.length != 4) {
  //     Get.snackbar(
  //       'Invalid OTP',
  //       'Please enter a valid OTP',
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //     return;
  //   }
  //
  //   try {
  //     isLoading.value = true;
  //
  //     final Map<String, dynamic> response =
  //     await ApiBaseService.request<Map<String, dynamic>>(
  //       'OTP/VerifyOTP?otpId=$otpId&enteredOtp=${otpController.text}',
  //       method: RequestMethod.GET,
  //       authenticated: false,
  //     );
  //
  //     // ✅ API-level status check
  //     if (response['status'] != 200) {
  //       throw Exception(response['message'] ?? 'OTP verification failed');
  //     }
  //
  //     final Map<String, dynamic>? data =
  //     response['data'] as Map<String, dynamic>?;
  //
  //     final String? memberId = data?['memberID'];
  //     final String? memberName = data?['memberName'];
  //     final String? mobile = data?['mobileNumber'];
  //
  //     /// 🔐 Save common values
  //     if (mobile != null && mobile.isNotEmpty) {
  //       await storage.write('mobile_number', mobile);
  //     }
  //
  //     /// ✅ Existing member
  //     if (memberId != null && memberId.isNotEmpty) {
  //       await storage.write('member_id', memberId);
  //       await storage.write('member_name', memberName ?? '');
  //       await storage.write('is_logged_in', 'true');
  //
  //       // 🔥 FORCE PROFILE REFRESH
  //       final profileController = Get.find<ProfileController>();
  //       await profileController.loadProfile();
  //
  //       final memberController = Get.find<MemberController>();
  //       await memberController.loadProfile();
  //
  //       Get.offAll(() => DashboardScreen());
  //       return;
  //     }
  //
  //     /// 🆕 New user
  //     Get.off(() => CreateAccountScreen());
  //   } catch (e) {
  //     Get.snackbar(
  //       'Verification Failed',
  //       e is Exception ? e.toString().replaceFirst('Exception: ', '') : 'Something went wrong',
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  Future<void> verifyOtp() async {
    if (!formKey.currentState!.validate()) return;

    if (otpController.text.length != 4) {
      Get.snackbar(
        'Invalid OTP',
        'Please enter a valid OTP',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isLoading.value = true;

      final response = await ApiBaseService.request<Map<String, dynamic>>(
        'OTP/VerifyOTP?otpId=$otpId&enteredOtp=${otpController.text}',
        method: RequestMethod.GET,
        authenticated: false,
      );

      if (response['status'] != 200) {
        throw Exception(response['message'] ?? 'OTP verification failed');
      }

      final data = response['data'] as Map<String, dynamic>?;

      final String memberId = data?['memberID'] ?? "";
      final String memberName = data?['memberName'] ?? "";
      final String mobile = data?['mobileNumber'] ?? "";
      final int isNewData = data?['isNewData'] ?? 1;
      final int approvalStatus = data?['approvalStatus'] ?? 0;

      /// ✅ STORE EVERYTHING CONSISTENTLY
      await storage.write('mobile_number', mobile);
      await storage.write('member_id', memberId);
      await storage.write('member_name', memberName);
      await storage.write('is_data_new', isNewData.toString());
      await storage.write('approval_status', approvalStatus.toString());

      /// 🆕 NEW USER
      if (isNewData == 1) {
        Get.off(() => CreateAccountScreen());
        return;
      }

      /// 👤 EXISTING USER
      await storage.write('is_logged_in', 'true');

      /// ⚠️ APPROVAL CHECK
      if (approvalStatus == 0) {
        Get.snackbar(
          'Approval Pending',
          'Your account is under review',
          snackPosition: SnackPosition.BOTTOM,
        );

        Get.offAll(() => CreateAccountScreen());
        return;
      }

      /// ✅ APPROVED USER
      await Get.find<ProfileController>().loadProfile();
      await Get.find<MemberController>().loadProfile();

      Get.offAll(() => CreateAccountScreen());

    } catch (e) {
      Get.snackbar(
        'Verification Failed',
        e is Exception
            ? e.toString().replaceFirst('Exception: ', '')
            : 'Something went wrong',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }


  // ---------------- RESEND OTP ----------------

  void resendOtp() {
    if (!canResend.value) return;

    // Call resend API here if needed
    startTimer();

    Get.snackbar(
      "OTP Sent",
      "A new OTP has been sent to your phone number.",
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
