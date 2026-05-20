import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kerala_association/core/model/stateList.dart';

import '../../../controllers/master_data_controller.dart';
import '../../../core/model/company_profile.dart';
import '../../../core/model/company_type.dart';
import '../../../core/model/districtList.dart';
import '../../../core/model/proof_type.dart';
import '../../../helper/utils/upload_utils.dart';
import '../../../services/api_base_service.dart';
import '../../../services/request_method.dart';
import '../../../services/secure_storage_service.dart';
import '../dashboard/dashboard_screen.dart';


class CreateAccountController extends GetxController {
  // ---------------- Controllers ----------------
  final nameController = TextEditingController();
  final designationController = TextEditingController();
  final companyTypeController = TextEditingController();
  final companyController = TextEditingController();
  final addressController = TextEditingController();
  final stateController = TextEditingController();
  final districtController = TextEditingController();
  final areaController = TextEditingController();
  final cityController = TextEditingController();
  final pinCodeController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final companyPanController = TextEditingController();
  final gstController = TextEditingController();

  // ---------------- Focus ----------------
  final nameFocusNode = FocusNode();
  final designationFocusNode = FocusNode();
  final companyFocusNode = FocusNode();
  final addressFocusNode = FocusNode();
  final stateFocusNode = FocusNode();
  final districtFocusNode = FocusNode();
  final areaFocusNode = FocusNode();
  final cityFocusNode = FocusNode();
  final pinCodeFocusNode = FocusNode();
  final phoneNumberFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final companyPanFocusNode = FocusNode();
  final gstFocusNode = FocusNode();

  final TextEditingController idTypeController = TextEditingController();
  final FocusNode idTypeFocusNode = FocusNode();

  final TextEditingController idNumberController = TextEditingController();
  final FocusNode idNumberFocusNode = FocusNode();

  // ---------------- Form ----------------
  final formSignUp = GlobalKey<FormState>();

  final selectedType = RxnString();
  final businessTypeError = ''.obs;

  // ---------------- Uploads ----------------
  final isUploadLoading = false.obs;
  final uploadingFileKey = ''.obs;

  final profilePhotoUrl = ''.obs;
  final panUrl = ''.obs;
  final gstUrl = ''.obs;
  final idProofUrl = ''.obs;

  final profilePhotoError = ''.obs;
  final panError = ''.obs;
  final gstError = ''.obs;
  final idProofError = ''.obs;

  RxString photoFileName = ''.obs;
  RxString panFileName = ''.obs;
  RxString gstFileName = ''.obs;
  RxString idProofFileName = ''.obs;

  final isLoading = false.obs;

  final MasterDataController masterData = Get.find<MasterDataController>();

  var isEditMode = false.obs;

  RxList<CompanyTypeData> companyTypeList = <CompanyTypeData>[].obs;
  RxnInt selectedCompanyTypeId = RxnInt();

  RxList<CompanyProfileData> companyProfileList = <CompanyProfileData>[].obs;
  RxnInt selectedCompanyProfileId = RxnInt();

  RxList<ProofTypeData> proofTypeList = <ProofTypeData>[].obs;
  RxnInt selectedProofTypeId = RxnInt();

  RxList<StateData> stateList = <StateData>[].obs;
  RxnInt selectedStateId = RxnInt();

  RxList<DistrictData> districtList = <DistrictData>[].obs;
  RxnInt selectedDistrictId = RxnInt();

  RxString mobileNumber = ''.obs;

  RxInt isDataNew = 1.obs;
  String? memberId = "";

  RxBool isMetaLoaded = false.obs;

  @override
  void onInit() {
    super.onInit();

    loadPhoneNumber();
    loadUserMeta(); // 👈 ADD THIS

    final args = Get.arguments;

    if (args != null && args["isEdit"] == true) {
      isEditMode.value = true;
    }

    // ✅ States
    stateList.assignAll(masterData.states);
    ever(masterData.states, (_) {
      stateList.assignAll(masterData.states);
    });

    // ✅ Company Types
    companyTypeList.assignAll(masterData.companyTypes);
    ever(masterData.companyTypes, (_) {
      companyTypeList.assignAll(masterData.companyTypes);
    });

    // ✅ Company Profiles
    companyProfileList.assignAll(masterData.companyProfiles);
    ever(masterData.companyProfiles, (_) {
      companyProfileList.assignAll(masterData.companyProfiles);
    });

    // ✅ Proof Types
    proofTypeList.assignAll(masterData.proofTypes);
    ever(masterData.proofTypes, (_) {
      proofTypeList.assignAll(masterData.proofTypes);
    });

    // District
    ever(selectedStateId, (stateId) async {
      if (stateId != null) {

        final districts = await fetchDistricts(stateId);

        districtList.assignAll(districts);

        // reset district when state changes
        selectedDistrictId.value = null;
      } else {
        districtList.clear();
        selectedDistrictId.value = null;
      }
    });
  }

  Future<void> loadPhoneNumber() async {
    final number = await storage.read("mobile_number") ?? '';

    print("📦 Stored mobile number: $number");

    mobileNumber.value = number;

    if (number.isNotEmpty) {
      phoneNumberController.text = number;
    }
  }

  Future<void> loadUserMeta() async {
    final storedIsNew = await storage.read('is_data_new');
    final storedMemberId = await storage.read('member_id');

    print("📦 isDataNew from storage: $storedIsNew");
    print("📦 memberId from storage: $storedMemberId");

    isDataNew.value = int.tryParse(storedIsNew ?? '1') ?? 1;
    memberId = storedMemberId ?? "";

    isMetaLoaded.value = true; // ✅ VERY IMPORTANT
  }

  Future<List<DistrictData>> fetchDistricts(int stateId) async {
    print("fetchDistricts for stateId: $stateId");

    try {
      DistrictList response = await ApiBaseService.request(
        'GetDistrictList?StateID=$stateId',
        method: RequestMethod.GET,
        authenticated: false,
      );
      return response.data ?? [];
    } catch (e) {
      print('Error fetching districts: $e');
      return [];
    }
  }

  // ---------------- Validators ----------------
  String? requiredValidator(String? val, String msg) {
    if (val == null || val.trim().isEmpty) return msg;
    return null;
  }

  String? emailValidator(String? val) {
    if (val == null || val.isEmpty) return 'Please enter email';
    if (!GetUtils.isEmail(val)) return 'Invalid email';
    return null;
  }

  String? phoneValidator(String? val) {
    if (val == null || val.isEmpty) return 'Enter phone number';
    if (val.length < 10) return 'Invalid phone number';
    return null;
  }

  // final SecureStorageService _secureStorage = SecureStorageService();
  final storage = Get.find<SecureStorageService>();

  // Future<void> createAccount() async {
  //   bool isValid = formSignUp.currentState?.validate() ?? false;
  //
  //   if (!isMetaLoaded.value) {
  //     print("⛔ Meta not loaded yet");
  //     return;
  //   }
  //
  //   if (!validateAllDocuments()) {
  //     isValid = false;
  //   }
  //
  //   final businessValid = validateBusinessType();
  //   if (!businessValid) isValid = false;
  //
  //   if (!isValid) return;
  //
  //   try {
  //     isLoading.value = true;
  //
  //     final body = {
  //       "memberID": isDataNew.value == 1 ? "" : memberId,
  //
  //       "memberName": nameController.text.trim(),
  //       "designation": designationController.text.trim(),
  //       "companyName": companyController.text.trim(),
  //
  //       "address": addressController.text.trim(),
  //       "city": cityController.text.trim(),
  //
  //       "pincode": pinCodeController.text.trim(),
  //
  //       "district": "", // optional (API uses districtID)
  //       "state": "",
  //
  //       "emailID": emailController.text.trim(),
  //
  //       "mobileNumber": phoneNumberController.text.trim(),
  //       "maskedMobileNumber": "",
  //
  //       // ---------------- DROPDOWN IDS ----------------
  //       "companyTypeID": selectedCompanyTypeId.value ?? 0,
  //       "companyProfileID": selectedCompanyProfileId.value ?? 0,
  //       "stateID": selectedStateId.value ?? 0,
  //       "districtID": selectedDistrictId.value ?? 0,
  //
  //       // ---------------- PROFILE ----------------
  //       "profile": "", // if needed, else keep empty
  //
  //       // ---------------- APP ----------------
  //       "appID": "31a0a9e2-28e6-f011-b836-126635fa33e6",
  //
  //       "area": areaController.text.trim(),
  //
  //       // ---------------- PHOTO ----------------
  //       "memberPhotoURL": "",
  //       "photoFileName": photoFileName.value,
  //       "isPhotoUpdated": profilePhotoUrl.value.isNotEmpty ? 1 : 0,
  //
  //       // ---------------- PAN ----------------
  //       "panNumber": companyPanController.text.trim(),
  //       "panFileName": panFileName.value,
  //       "isPANUpdated": panFileName.value.isNotEmpty ? 1 : 0,
  //
  //       // ---------------- GST ----------------
  //       "gstNumber": gstController.text.trim(),
  //       "gstFileName": gstFileName.value,
  //       "isGSTUpdated": gstController.text.trim().isNotEmpty ? 1 : 0,
  //
  //       // ---------------- ID PROOF ----------------
  //       "idProofType": selectedProofTypeId.value?.toString() ?? "",
  //       "idProofNumber": idNumberController.text.trim(),
  //       "idProofFileName": idProofFileName.value,
  //       "isIDProofUpdated": idProofFileName.value.isNotEmpty ? 1 : 0,
  //
  //       // ---------------- FLAG ----------------
  //       "isDataNew":  isDataNew.value, // 🔥 VERY IMPORTANT
  //     };
  //
  //     print("BODY DATA - $body");
  //
  //     final response = await ApiBaseService.request<Map<String, dynamic>>(
  //       'MemberData/SaveUserData',
  //       method: RequestMethod.POST,
  //       body: body,
  //       authenticated: false,
  //     );
  //
  //     if (response['status'] != 200) {
  //       throw Exception(response['message'] ?? 'Failed to create account');
  //     }
  //
  //     final data = response['data'];
  //     final memberId = data?['memberID'];
  //
  //     if (memberId != null) {
  //       await storage.write('member_id', memberId.toString());
  //       await storage.write('is_logged_in', 'true');
  //     }
  //
  //     Get.snackbar(
  //       'Success',
  //       response['message'] ?? 'Account created successfully',
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //
  //     Get.offAll(() => DashboardScreen());
  //
  //   } catch (e) {
  //     Get.snackbar(
  //       'Error',
  //       e.toString().replaceFirst('Exception: ', ''),
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //     print(e);
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  Future<void> createAccount() async {
    bool isValid = formSignUp.currentState?.validate() ?? false;

    if (!isMetaLoaded.value) {
      print("⛔ Meta not loaded yet");
      return;
    }

    if (!validateAllDocuments()) isValid = false;
 // if (!validateBusinessType()) isValid = false;

    if (!isValid) return;

    try {
      isLoading.value = true;

      final bool isNew = isDataNew.value == 1;

      final body = {
        "memberID": isNew ? "" : memberId,
        "isDataNew": isNew ? 1 : 0,

        "memberName": nameController.text.trim(),
        "designation": designationController.text.trim(),
        "companyName": companyController.text.trim(),

        "address": addressController.text.trim(),
        "city": cityController.text.trim(),
        "pincode": pinCodeController.text.trim(),

        "district": "",
        "state": "",

        "emailID": emailController.text.trim(),

        "mobileNumber": phoneNumberController.text.trim(),
        "maskedMobileNumber": "",

        // ✅ DROPDOWNS
        "companyTypeID": selectedCompanyTypeId.value ?? 0,
        "companyProfileID": selectedCompanyProfileId.value ?? 0,
        "stateID": selectedStateId.value ?? 0,
        "districtID": selectedDistrictId.value ?? 0,

        "profile": "",
        "appID": "31a0a9e2-28e6-f011-b836-126635fa33e6",
        "area": areaController.text.trim(),

        // ✅ PHOTO
        "memberPhotoURL": "",
        "photoFileName": photoFileName.value,
        "isPhotoUpdated": profilePhotoUrl.value.isNotEmpty ? 1 : 0,

        // ✅ PAN
        "panNumber": companyPanController.text.trim(),
        "panFileName": panFileName.value,
        "isPANUpdated": panFileName.value.isNotEmpty ? 1 : 0,

        // ✅ GST
        "gstNumber": gstController.text.trim(),
        "gstFileName": gstFileName.value,
        "isGSTUpdated": gstController.text.trim().isNotEmpty ? 1 : 0,

        // ✅ ID PROOF
        "idProofType": selectedProofTypeId.value?.toString() ?? "",
        "idProofNumber": idNumberController.text.trim(),
        "idProofFileName": idProofFileName.value,
        "isIDProofUpdated": idProofFileName.value.isNotEmpty ? 1 : 0,
      };

      print("BODY DATA - $body");

      final response = await ApiBaseService.request<Map<String, dynamic>>(
        'MemberData/SaveUserData',
        method: RequestMethod.POST,
        body: body,
        authenticated: false,
      );

      print("RESPONSE DATA : $response");

      // if (response['status'] != 200) {
      //   throw Exception(response['message'] ?? 'Failed to save account');
      // }
      //
      // final data = response['data'];
      // final String newMemberId = data?['memberID'] ?? "";
      //
      // if (newMemberId.isNotEmpty) {
      //   await storage.write('member_id', newMemberId);
      //   await storage.write('is_logged_in', 'true');
      //   await storage.write('is_data_new', '0'); // 🔥 IMPORTANT after save
      // }

      Get.snackbar(
        'Success',
        'Account saved successfully',  // response['message'] ??
        snackPosition: SnackPosition.BOTTOM,
      );

  //    Get.offAll(() => DashboardScreen());

    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString().replaceFirst('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
      );
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  bool validateAllDocuments() {
    final photoValid = validateProfilePhoto();
    final panValid = validatePan();
    final gstValid = validateGst();
    final idProofValid = validateIdProof();

    return photoValid && panValid && gstValid && idProofValid;
  }

  bool validateProfilePhoto() {
    if (profilePhotoUrl.value.isEmpty || photoFileName.value.isEmpty) {
      profilePhotoError.value = 'Profile photo required';
      return false;
    }
    profilePhotoError.value = '';
    return true;
  }

  bool validatePan() {
    if (panUrl.value.isEmpty || panFileName.value.isEmpty) {
      panError.value = 'PAN copy required';
      return false;
    }
    panError.value = '';
    return true;
  }

  bool validateGst() {
    if (gstUrl.value.isEmpty || gstFileName.value.isEmpty) {
      gstError.value = 'GST copy required';
      return false;
    }
    gstError.value = '';
    return true;
  }

  bool validateIdProof() {
    if (idProofUrl.value.isEmpty || idProofFileName.value.isEmpty) {
      idProofError.value = 'Id-Proof copy required';
      return false;
    }
    idProofError.value = '';
    return true;
  }

  // bool validateBusinessType() {
  //   if (selectedType.value == null) {
  //     businessTypeError.value = 'Please select company profile';
  //     return false;
  //   }
  //
  //   businessTypeError.value = '';
  //   return true;
  // }

  String getSelectedStateName() {
    final state = stateList.firstWhere(
          (e) => e.stateID == selectedStateId.value,
    );
    return state.stateName ?? '';
  }

  // ---------------- Upload Handler ----------------
  Future<void> handleFileUpload(BuildContext context, String key) async {
    final onSuccess = getUploadHandler(key);
    if (onSuccess == null) return;

    final mobileNumber = await storage.read("mobile_number") ?? '';
    print("📦 Stored mobile number: $mobileNumber");

    UploadUtils.showUploadOptions(
      context: context,
      fileType: key,
      gstNumber: "",
      mobileNumber: mobileNumber,
      isUploadLoading: isUploadLoading,
      uploadingKey: uploadingFileKey,
      onSuccess: onSuccess,
    );
  }

  // Function(String, String)? getUploadHandler(String key) {
  //   switch (key) {
  //     case 'photoCopy':
  //       return (_, url) {
  //         profilePhotoUrl.value = url;
  //         profilePhotoError.value = '';
  //       };
  //     case 'panCopy':
  //       return (_, url) {
  //         panUrl.value = url;
  //         panError.value = '';
  //       };
  //     case 'gstCopy':
  //       return (_, url) {
  //         gstUrl.value = url;
  //         gstError.value = '';
  //       };
  //   }
  //   return null;
  // }

  Function(String, String)? getUploadHandler(String key) {
    switch (key) {
      case 'photoCopy':
        return (fileName, url) {
          profilePhotoUrl.value = url;
          photoFileName.value = fileName;
          profilePhotoError.value = '';

          print("✅ PHOTO FILE NAME: $fileName");
          print("✅ PHOTO URL SET: $url");

        };

      case 'panCopy':
        return (fileName, url) {
          panUrl.value = url;
          panFileName.value = fileName;
          panError.value = '';
        };

      case 'gstCopy':
        return (fileName, url) {
          gstUrl.value = url;
          gstFileName.value = fileName;
          gstError.value = '';
        };

      case 'idProof':
        return (fileName, url) {
          idProofFileName.value = fileName;
          idProofUrl.value = url;
          idProofError.value = '';
        };
    }
    return null;
  }

  @override
  void onClose() {
    nameController.dispose();
    designationController.dispose();
    super.onClose();
  }
}

/*
{
  "memberID": "FDD3433",
  "memberName": "Muthuraj Test 2",
  "designation": "1",                  - no change
  "companyName": "9SquareTech",
  "address": "XXXXX",
  "city": "XXX TEST",
  "pincode": "600052",
  "district": "1",
  "mobileNumber": "9499956224",
  "maskedMobileNumber": "9499956224",
  "profile": "Manufacturer",
  "memberPhotoURL": "https://kgsma.thejewelleryworld.com/tempImages/9499956224-5d2dbea8651b409-photoCopy.jpg", - no need to pass
  "photoFileName": "9499956224-5d2dbea8651b409-photoCopy.jpg",
  "isPhotoUpdated": 0,
  "appID": "31a0a9e2-28e6-f011-b836-126635fa33e6",
  "area": "Anna Street",
  "stateID": 1,
  "emailID": "muthuraj@gmail.com",
  "pan": "ABCDE1234Z",
  "panFileName": "9499956224-b1179e5b8c5c4e4-panCopy.jpg",
  "isPANUpdated": 0,
  "gst": "GH454534RTGRT54",
  "gstFileName": "9499956224-6d609ac98e94453-gstCopy.jpg",
  "isGSTUpdated": 0,
  "idProof": "",
  "idProofFileName": "",
  "isIDProofUpdated": 0,
  "saveFlag": 0,
  "isActive": 1
}
 */

/*

Future<void> loadUserData() async {
  try {
    isLoading.value = true;

    final memberId = await storage.read('member_id');

    final response = await ApiBaseService.request<Map<String, dynamic>>(
      'UserData/GetUserData',
      method: RequestMethod.GET,
      queryParams: {
        "memberID": memberId,
      },
      authenticated: false,
    );

    final data = response['data'];

    if (data == null) return;

    // 👇 Fill controllers
    nameController.text = data['memberName'] ?? '';
    designationController.text = data['designation'] ?? '';
    companyController.text = data['companyName'] ?? '';
    phoneNumberController.text = data['mobileNumber'] ?? '';
    emailController.text = data['emailID'] ?? '';
    pinCodeController.text = data['pincode'] ?? '';
    areaController.text = data['area'] ?? '';
    cityController.text = data['city'] ?? '';

    // 👇 Dropdowns (IMPORTANT)
    stateId.value = data['stateID']?.toString() ?? '';
    districtId.value = data['district']?.toString() ?? '';

    // 👇 Files
    profilePhotoUrl.value = data['memberPhotoURL'] ?? '';
    panUrl.value = data['pan'] ?? '';
    gstUrl.value = data['gst'] ?? '';

  } catch (e) {
    print("Error loading user data: $e");
  } finally {
    isLoading.value = false;
  }
}

 */
