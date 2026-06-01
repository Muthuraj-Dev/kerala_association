import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kerala_association/common_widget/common_button.dart';
import 'package:kerala_association/common_widget/common_dialog.dart';
import 'package:kerala_association/core/model/stateList.dart';
import 'package:kerala_association/core/res/colors.dart';

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
import '../profile/profile_controller.dart';

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

  final profileUpdatedStatusID = 0.obs;
  final panUpdatedStatusID = 0.obs;
  final gstUpdatedStatusID = 0.obs;
  final idProofUpdatedStatusID = 0.obs;

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

  int? pendingDistrictId;
  int? pendingCompanyProfileId;
  int? pendingCompanyTypeId;
  int? pendingIDProofTypeId;

  @override
  void onInit() {
    super.onInit();

    loadPhoneNumber();
    loadUserMeta();

    // ✅ States
    stateList.assignAll(masterData.states);
    ever(masterData.states, (_) {
      stateList.assignAll(masterData.states);
    });

    // ✅ Company Types
    companyTypeList.assignAll(masterData.companyTypes);
    ever(masterData.companyTypes, (_) {
      companyTypeList.assignAll(masterData.companyTypes);
      applyCompanyTypeSelection();
    });

    // ✅ Company Profiles
    companyProfileList.assignAll(masterData.companyProfiles);
    ever(masterData.companyProfiles, (_) {
      companyProfileList.assignAll(masterData.companyProfiles);
      applyCompanyProfileSelection();
    });

    // ✅ Proof Types
    proofTypeList.assignAll(masterData.proofTypes);
    ever(masterData.proofTypes, (_) {
      proofTypeList.assignAll(masterData.proofTypes);
      applyIDProofSelection();
    });

    ever(selectedStateId, (stateId) async {
      if (stateId != null) {
        final districts = await fetchDistricts(stateId);

        districtList.assignAll(districts);

        // ✅ NOW safe to restore selected district
        if (isEditMode.value && pendingDistrictId != null) {
          selectedDistrictId.value = pendingDistrictId;
          pendingDistrictId = null;
        }
      } else {
        districtList.clear();
        selectedDistrictId.value = null;
      }
    });

    final args = Get.arguments;

    if (args != null) {
      isEditMode.value = args["isEdit"] == true;

      print("isEditMode ${isEditMode.value}");

      if (isEditMode.value && args["data"] != null) {
        prefillData(args["data"]);
      }
      applyCompanyTypeSelection();
      applyCompanyProfileSelection();
      applyIDProofSelection();
    }
  }

  void applyCompanyTypeSelection() {
    if (pendingCompanyTypeId != null && companyTypeList.isNotEmpty) {
      selectedCompanyTypeId.value = pendingCompanyTypeId;
      pendingCompanyTypeId = null;
    }
  }

  void applyCompanyProfileSelection() {
    if (pendingCompanyProfileId != null && companyProfileList.isNotEmpty) {
      selectedCompanyProfileId.value = pendingCompanyProfileId;
      pendingCompanyProfileId = null;
    }
  }

  void applyIDProofSelection() {
    if (pendingIDProofTypeId != null && proofTypeList.isNotEmpty) {
      selectedProofTypeId.value = pendingIDProofTypeId;
      pendingIDProofTypeId = null;
    }
  }

  Future<void> loadPhoneNumber() async {
    final number = await storage.read("mobile_number") ?? '';

    print("📦 Stored mobile number: $number");

    mobileNumber.value = number;

    if (number.isNotEmpty) {
      phoneNumberController.text = number;
    }

    update(); // 👈 IMPORTANT (if using GetBuilder)
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

  final storage = Get.find<SecureStorageService>();

  Future<void> createAccount() async {
    bool isValid = formSignUp.currentState?.validate() ?? false;

    if (!isMetaLoaded.value) {
      print("⛔ Meta not loaded yet");
      return;
    }

    if (!validateAllDocuments()) isValid = false;

    if (!isValid) return;

    try {
      isLoading.value = true;

      final bool isNew = isDataNew.value == 1;

      final body = {
        "memberID": isNew ? "" : memberId,
        //     "isDataNew": isNew && isEditMode.value ? 1 : 0,
        "isDataNew": isEditMode.value ? 0 : 1,

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
        "isPhotoUpdated": profileUpdatedStatusID.value,
        // profilePhotoUrl.value.isNotEmpty ? 1 : 0,  // - 0

        // ✅ PAN
        "panNumber": companyPanController.text.trim(),
        "panFileName": panFileName.value,
        "isPANUpdated": panUpdatedStatusID.value,
        // - 0

        // ✅ GST
        "gstNumber": gstController.text.trim(),
        "gstFileName": gstFileName.value,
        "isGSTUpdated": gstUpdatedStatusID.value,
        // gstController.text.trim().isNotEmpty ? 1 : 0,

        // ✅ ID PROOF
        "idProofType": selectedProofTypeId.value ?? 0,
        "idProofNumber": idNumberController.text.trim(),
        "idProofFileName": idProofFileName.value,
        "isIDProofUpdated": idProofUpdatedStatusID.value,
      };

      print("BODY DATA - $body");

      final response = await ApiBaseService.request<Map<String, dynamic>>(
        'UserData/SaveMemberData',
        method: RequestMethod.POST,
        body: body,
        authenticated: false,
      );

      print("RESPONSE DATA : $response");

      if (response['status'] != 200) {
        throw Exception(response['message'] ?? 'Failed to save account');
      }

      final String message = response['data'] ?? 'Account saved successfully';

      await storage.write('panNumber', companyPanController.text);

      // ✅ Show success message
      // Get.snackbar('Success', message, snackPosition: SnackPosition.BOTTOM);
      // CommonDialog.showCustomDialog(content: )

      CommonDialog.showCustomDialog(
        content: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 60),
              const SizedBox(height: 16),
              Text(
                "Success",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(message, textAlign: TextAlign.center),
              const SizedBox(height: 20),
              IntrinsicWidth(
                child: CommonButton(
                  text: "Done",
                  fillColor: AppColor.green,
                  onPressed: () async {
                    Get.back();
                    Get.offAll(() => DashboardScreen());
                  },
                ),
              )
            ],
          ),
        ),
      );

      await Get.find<ProfileController>().initProfile();

    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString().replaceFirst('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
      );
      print("EEE $e");
    } finally {
      isLoading.value = false;
    }
  }

  void prefillData(Map<String, dynamic> data) {
    nameController.text = data['memberName'] ?? '';
    designationController.text = data['designation'] ?? '';
    companyController.text = data['companyName'] ?? '';
    addressController.text = data['address'] ?? '';
    cityController.text = data['city'] ?? '';
    areaController.text = data['area'] ?? '';
    pinCodeController.text = data['pincode'] ?? '';
    phoneNumberController.text = data['mobileNumber'] ?? '';
    emailController.text = data['emailID'] ?? '';
    companyPanController.text = data['panNumber'] ?? '';
    gstController.text = data['gstNumber'] ?? '';

    idNumberController.text = data['idProofNumber'] ?? '';
    pendingIDProofTypeId = int.tryParse(data['idProofType']?.toString() ?? '');

    // ✅ Dropdown IDs
    selectedStateId.value = data['stateID'];
    pendingDistrictId = data['districtID'];
    pendingCompanyTypeId = data['companyTypeID'];
    pendingCompanyProfileId = data['companyProfileID'];

    // ✅ File URL
    profilePhotoUrl.value = data['memberPhotoURL'] ?? '';
    panUrl.value = data['panFileURL'] ?? '';
    gstUrl.value = data['gstFileURL'] ?? '';
    idProofUrl.value = data['idProofFileURL'] ?? '';

    // ✅ File names
    photoFileName.value = data['photoFileName'] ?? '';
    panFileName.value = data['panFileName'] ?? '';
    gstFileName.value = data['gstFileName'] ?? '';
    idProofFileName.value = data['idProofFileName'] ?? '';

    // ✅ Status flags
    profileUpdatedStatusID.value = data['isPhotoUpdated'] ?? 0;
    panUpdatedStatusID.value = data['isPANUpdated'] ?? 0;
    gstUpdatedStatusID.value = data['isGSTUpdated'] ?? 0;
    idProofUpdatedStatusID.value = data['isIDProofUpdated'] ?? 0;

    // ✅ Meta
    isDataNew.value = data['isDataNew'] ?? 0;
    memberId = data['memberID'];

    print("----- DEBUG COMPANY PROFILE -----");
    print("Pending: $pendingCompanyProfileId");
    print("Selected: ${selectedCompanyProfileId.value}");
    print("List: ${companyProfileList.map((e) => e.profileID).toList()}");
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

  Function(String, String, int)? getUploadHandler(String key) {
    switch (key) {
      case 'photoCopy':
        return (fileName, url, updatedStatus) {
          profilePhotoUrl.value = url;
          photoFileName.value = fileName;
          profilePhotoError.value = '';
          profileUpdatedStatusID.value = updatedStatus;

          print("✅ PHOTO FILE NAME: $fileName");
          print("✅ PHOTO URL SET: $url");
          print("✅ UPDATED STATUS: $updatedStatus");
        };

      case 'panCopy':
        return (fileName, url, updatedStatus) {
          panUrl.value = url;
          panFileName.value = fileName;
          panError.value = '';
          panUpdatedStatusID.value = updatedStatus;
        };

      case 'gstCopy':
        return (fileName, url, updatedStatus) {
          gstUrl.value = url;
          gstFileName.value = fileName;
          gstError.value = '';
          gstUpdatedStatusID.value = updatedStatus;
        };

      case 'idProof':
        return (fileName, url, updatedStatus) {
          idProofFileName.value = fileName;
          idProofUrl.value = url;
          idProofError.value = '';
          idProofUpdatedStatusID.value = updatedStatus;
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


// 0 - false,
// 1 - true

// for image update flow :
// for updated - defualt should be 0 and if values comes from upload api means - assign it to save api
