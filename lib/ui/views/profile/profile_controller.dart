import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kerala_association/ui/views/dashboard/dashboard_controller.dart';
import 'package:kerala_association/ui/views/dashboard/dashboard_screen.dart';

import '../../../common_widget/common_dialog.dart';
import '../../../services/api_base_service.dart';
import '../../../services/request_method.dart';
import '../../../services/secure_storage_service.dart';
import '../phone/phone_screen.dart';

class ProfileController extends GetxController {

  final SecureStorageService _storage = SecureStorageService();

  final RxBool isLoggedIn = false.obs;
  final RxString memberName = ''.obs;
  final RxString memberId = ''.obs;
  final RxString mobileNumber = ''.obs;

  final isLoading = false.obs;


  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final loggedIn = await _storage.read("is_logged_in");

    if (loggedIn == "true") {
      isLoggedIn.value = true;
      memberName.value = await _storage.read("member_name") ?? '';
      memberId.value = await _storage.read("member_id") ?? '';
      mobileNumber.value = await _storage.read("mobile_number") ?? '';
    } else {
      isLoggedIn.value = false;
    }
  }

  void logout() {
    CommonDialog.showConfirmDialog(
      title: 'Logout',
      content: 'Are you sure you want to log out?',
      onConfirm: () async {
        Get.back();

        isLoggedIn.value = false;
        memberName.value = '';
        memberId.value = '';
        mobileNumber.value = '';



        await _storage.clear();
        /// Navigate to Login
        Get.find<DashboardController>().selectedIndex.value = 0;
        Get.offAll(() => DashboardScreen());
      },
    );
  }

  void deleteAccount() {
    CommonDialog.showConfirmDialog(
      title: 'Delete Account',
      confirmText: 'Yes',
      content: 'Are you sure you want to delete account ?',
      onConfirm: () async {
        Get.back();

        final success = await deleteAccountApi(memberId.value);

        if (!success) {
          Get.snackbar("Error", "Failed to delete account");
          return;
        }

        // ✅ Only clear AFTER successful API call
        isLoggedIn.value = false;
        memberName.value = '';
        memberId.value = '';
        mobileNumber.value = '';

        await _storage.clear();
        /// Navigate to Login
        Get.find<DashboardController>().selectedIndex.value = 0;
        Get.offAll(() => DashboardScreen());
      },
    );
  }


  Future<bool> deleteAccountApi(String memberId) async {
    try {
      isLoading.value = true;

      final Map<String, dynamic> response =
      await ApiBaseService.request<Map<String, dynamic>>(
        'DeleteUserAccount?MemberID=$memberId',
        method: RequestMethod.GET,
        authenticated: false,
      );

      final int status = response['status'] ?? 0;
      final String message = response['data'] ?? '';

      if (status == 200) {
        debugPrint("✅ $message");
        Fluttertoast.showToast(
          msg: message,
        );
        return true;
      } else {
        debugPrint("❌ Delete failed: $message");
        return false;
      }
    } catch (e, s) {
      debugPrint("❌ Delete API error: $e");
      debugPrintStack(stackTrace: s);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

}
