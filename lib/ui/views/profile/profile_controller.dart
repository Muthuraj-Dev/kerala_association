import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kerala_association/ui/views/dashboard/dashboard_controller.dart';
import 'package:kerala_association/ui/views/dashboard/dashboard_screen.dart';

import '../../../common_widget/common_dialog.dart';
import '../../../services/api_base_service.dart';
import '../../../services/request_method.dart';
import '../../../services/secure_storage_service.dart';
import '../create_account/create_account_controller.dart';
import '../phone/phone_controller.dart';
import '../phone/phone_screen.dart';

class ProfileController extends GetxController {

  final SecureStorageService _storage = SecureStorageService();

  final RxString memberName = ''.obs;
  final RxString memberId = ''.obs;
  final RxString mobileNumber = ''.obs;

  final isLoading = false.obs;

  Rxn<Map<String, dynamic>> userData = Rxn<Map<String, dynamic>>();

  final RxBool hasPan = false.obs;

  @override
  void onInit() {
    super.onInit();
    // loadProfile();
    // loadUserData();

    initProfile();
  }

  Future<void> initProfile() async {
    print("LOAD GET MEMBER DATA");
    await loadUserDataFromPan();
  }

  Future<void> loadUserDataFromPan() async {
    try {
      isLoading.value = true;

      final storedPan = await _storage.read('panNumber');

      if (storedPan == null || storedPan.isEmpty) {
        print("Pan is Empty Now");
        hasPan.value = false;
        return;
      }

      hasPan.value = true;

      final response =
      await ApiBaseService.request<Map<String, dynamic>>(
        'UserData/GetMemberData?PANNumber=$storedPan',
        method: RequestMethod.GET,
        authenticated: false,
      );

      if (response['status'] != 200) {
        hasPan.value = false;
        return;
      }

      final data = response['data'];

      if (data != null && data is Map<String, dynamic>) {
        userData.value = data;

        memberName.value = data['memberName'] ?? '';
        memberId.value = data['memberID'] ?? '';
        mobileNumber.value = data['mobileNumber'] ?? '';

        hasPan.value = (data['panNumber'] ?? '').toString().isNotEmpty;
      }

    } catch (e) {
      hasPan.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    CommonDialog.showConfirmDialog(
      title: 'Logout',
      content: 'Are you sure you want to log out?',
      onConfirm: () async {
        Get.back();

        hasPan.value = false; // 🔥 IMPORTANT FIX
        memberName.value = '';
        memberId.value = '';
        mobileNumber.value = '';

        Get.find<PhoneController>().clearPhone();
        await _storage.clear();

        /// Navigate to Dashboard → Home
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

        hasPan.value = false; // 🔥 IMPORTANT FIX
        memberName.value = '';
        memberId.value = '';
        mobileNumber.value = '';

        Get.find<PhoneController>().clearPhone();
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
