import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kerala_association/common_widget/common_button.dart';
import 'package:kerala_association/common_widget/common_dropdown.dart';
import 'package:kerala_association/common_widget/common_text_field.dart';
import 'package:kerala_association/common_widget/tap_outside_unfocus.dart';
import 'package:kerala_association/core/res/colors.dart';
import 'package:kerala_association/ui/widgets/common_file_picker_box.dart';
import 'package:kerala_association/ui/widgets/file_preview_widget.dart';
import 'create_account_controller.dart';

class CreateAccountScreen extends StatelessWidget {
  CreateAccountScreen({super.key});

  final CreateAccountController controller =
      Get.find<CreateAccountController>();

  Widget _buildField({required String label, required Widget field}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 18, color: Color(0xff875C00)),
          ),
          const SizedBox(height: 6),
          field,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.background,
        elevation: 0,
        title: Obx(
          () => Text(
            !controller.isEditMode.value ? "Create Account" : "Update User",
          ),
        ),
      ),
      body: TapOutsideUnFocus(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Form(
            key: controller.formSignUp,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Header Section ---
                Center(
                  child: Column(
                    children: [
                      SvgPicture.asset("assets/account.svg", height: 54),
                      const SizedBox(height: 8),
                      Text(
                        !controller.isEditMode.value
                            ? "Create Account"
                            : "Update User",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Join us today and get started",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColor.textDisable,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                _buildLabeledText("Upload Profile Image"),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonFilePickerBox(
                              label: "Upload Profile Image",
                              fileKey: "photoCopy",
                              isLoading: controller.isUploadLoading,
                              uploadingKey: controller.uploadingFileKey,
                              onPick: controller.handleFileUpload,
                              errorText: controller.profilePhotoError.value,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),

                    /// 🔥 SAME PREVIEW WIDGET
                    FilePreviewWidget(
                      filePath: controller.profilePhotoUrl,
                      fileName: controller.photoFileName,
                      errorText: ''.obs,
                      isLoading: controller.isUploadLoading,
                    ),
                  ],
                ),
                SizedBox(height: 2),
                const SizedBox(height: 14),

                _buildField(
                  label: "Full Name",
                  field: CommonTextField(
                    controller: controller.nameController,
                    focusNode: controller.nameFocusNode,
                    hintText: 'Enter your full name',
                    validator:
                        (val) =>
                            val == null || val.isEmpty
                                ? 'Please enter full name'
                                : null,
                  ),
                ),

                _buildField(
                  label: "Designation",
                  field: CommonTextField(
                    controller: controller.designationController,
                    focusNode: controller.designationFocusNode,
                    hintText: 'Enter your designation',
                    validator:
                        (val) =>
                            val == null || val.isEmpty
                                ? 'Please enter designation'
                                : null,
                  ),
                ),
                _buildField(
                  label: "Company Type",
                  field: Obx(() {
                    return CommonDropdown<int>(
                      items:
                          controller.companyTypeList
                              .map((e) => e.companyTypeID!)
                              .toList(),

                      hintText: 'Company Type*',

                      selectedItem: controller.selectedCompanyTypeId.value,
                      itemAsString: (id) {
                        final item = controller.companyTypeList
                            .firstWhereOrNull((e) => e.companyTypeID == id);

                        return item?.companyType ?? '';
                      },

                      onChanged: (value) {
                        controller.selectedCompanyTypeId.value = value;
                      },

                      validator:
                          (val) =>
                              val == null ? 'Please select company type' : null,
                    );
                  }),
                ),
                _buildField(
                  label: "Company",
                  field: CommonTextField(
                    controller: controller.companyController,
                    focusNode: controller.companyFocusNode,
                    hintText: 'Enter your company',
                    validator:
                        (val) =>
                            val == null || val.isEmpty
                                ? 'Please enter company'
                                : null,
                  ),
                ),
                _buildField(
                  label: "Address",
                  field: CommonTextField(
                    controller: controller.addressController,
                    focusNode: controller.addressFocusNode,
                    hintText: 'Enter your address',
                    validator:
                        (val) =>
                            val == null || val.isEmpty
                                ? 'Please enter address'
                                : null,
                  ),
                ),

                _buildField(
                  label: "Area",
                  field: CommonTextField(
                    controller: controller.areaController,
                    focusNode: controller.areaFocusNode,
                    hintText: 'Select your Area',
                    validator:
                        (val) =>
                            val == null || val.isEmpty
                                ? 'Please enter state'
                                : null,
                  ),
                ),

                _buildField(
                  label: "State",
                  field: Obx(() {
                    return CommonDropdown<int>(
                      items:
                          controller.stateList.map((e) => e.stateID!).toList(),

                      hintText: 'Select State*',

                      selectedItem: controller.selectedStateId.value,

                      itemAsString: (id) {
                        final state = controller.stateList.firstWhere(
                          (e) => e.stateID == id,
                        );
                        return state.stateName ?? '';
                      },

                      onChanged: (value) {
                        controller.selectedStateId.value = value;
                        print(
                          "Selected STATE ID : ${controller.selectedStateId.value}",
                        );
                      },

                      validator: (val) {
                        if (val == null) {
                          return 'Please select state';
                        }
                        return null;
                      },
                    );
                  }),
                ),

                _buildField(
                  label: "District",
                  field: Obx(() {
                    return CommonDropdown<int>(
                      items:
                          controller.districtList
                              .map((e) => e.districtID!)
                              .toList(),
                      hintText: 'Select District*',
                      selectedItem: controller.selectedDistrictId.value,

                      itemAsString: (id) {
                        final district = controller.districtList
                            .firstWhereOrNull((e) => e.districtID == id);

                        return district?.districtName ?? '';
                      },

                      onChanged: (value) {
                        controller.selectedDistrictId.value = value;
                      },

                      validator: (val) {
                        if (val == null) {
                          return 'Please select district';
                        }
                        return null;
                      },
                    );
                  }),
                ),

                _buildField(
                  label: "City",
                  field: CommonTextField(
                    controller: controller.cityController,
                    focusNode: controller.cityFocusNode,
                    hintText: 'Please enter city',
                    validator:
                        (val) =>
                            val == null || val.isEmpty
                                ? 'Please enter city'
                                : null,
                  ),
                ),

                _buildField(
                  label: "Pin Code",
                  field: CommonTextField(
                    controller: controller.pinCodeController,
                    focusNode: controller.pinCodeFocusNode,
                    keyboardType: TextInputType.number,
                    hintText: 'Enter your pincode',
                    maxLength: 6,

                    validator:
                        (val) =>
                            val == null || val.isEmpty
                                ? 'Please enter pincode'
                                : null,
                  ),
                ),

                _buildField(
                  label: "Phone Number",
                  field: Obx(() {
                    return CommonTextField(
                      controller: controller.phoneNumberController,
                      focusNode: controller.phoneNumberFocusNode,
                      enabled: controller.mobileNumber.value.isEmpty,
                      suffixIcon:
                          controller.mobileNumber.value.isNotEmpty
                              ? Icon(Icons.lock, size: 16)
                              : null,
                      keyboardType: TextInputType.phone,
                      hintText: 'Enter your phone number',
                      validator:
                          (val) =>
                              val == null || val.isEmpty
                                  ? 'Please enter phone number'
                                  : null,
                    );
                  }),
                ),

                _buildField(
                  label: "Email",
                  field: CommonTextField(
                    controller: controller.emailController,
                    focusNode: controller.emailFocusNode,
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'Enter your email',
                    validator:
                        (val) =>
                            val == null || val.isEmpty
                                ? 'Please enter email'
                                : null,
                  ),
                ),

                _buildField(
                  label: "Company Profile",
                  field: Obx(() {
                    return CommonDropdown<int>(
                      items:
                          controller.companyProfileList
                              .map((e) => e.profileID!)
                              .toList(),

                      hintText: 'Company Profile*',

                      selectedItem: controller.selectedCompanyProfileId.value,

                      itemAsString: (id) {
                        final item = controller.companyProfileList
                            .firstWhereOrNull((e) => e.profileID == id);
                        return item?.profile ?? '';
                      },

                      onChanged: (value) {
                        controller.selectedCompanyProfileId.value = value;
                        print(
                          "selectedCompanyProfileId ${controller.selectedCompanyProfileId.value}",
                        );
                      },

                      validator:
                          (val) =>
                              val == null
                                  ? 'Please select company profile'
                                  : null,
                    );
                  }),
                ),

                _buildField(
                  label: "Company PAN",
                  field: CommonTextField(
                    controller: controller.companyPanController,
                    focusNode: controller.companyPanFocusNode,
                    hintText: 'Enter your company PAN',
                    validator:
                        (val) =>
                            val == null || val.isEmpty
                                ? 'Please enter company PAN'
                                : null,
                  ),
                ),

                _buildLabeledText("Upload Company PAN"),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonFilePickerBox(
                              label: "Upload Company PAN",
                              fileKey: "panCopy",
                              isLoading: controller.isUploadLoading,
                              uploadingKey: controller.uploadingFileKey,
                              onPick: controller.handleFileUpload,
                              errorText:
                                  controller.panError.value, // ✅ add this
                            ),

                            /// 🔥 USE YOUR REUSABLE PREVIEW
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),
                    FilePreviewWidget(
                      filePath: controller.panUrl,
                      fileName: controller.panFileName,
                      errorText: ''.obs, // avoid duplicate error
                      isLoading: controller.isUploadLoading,
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                _buildField(
                  label: "GST",
                  field: CommonTextField(
                    controller: controller.gstController,
                    focusNode: controller.gstFocusNode,
                    hintText: 'Enter your GST',
                    validator:
                        (val) =>
                            val == null || val.isEmpty
                                ? 'Please enter GST'
                                : null,
                  ),
                ),

                const SizedBox(height: 8),

                _buildLabeledText("Upload GST"),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonFilePickerBox(
                              label: "Upload GST",
                              // or "Upload GST (Optional)"
                              fileKey: "gstCopy",
                              isLoading: controller.isUploadLoading,
                              uploadingKey: controller.uploadingFileKey,
                              onPick: controller.handleFileUpload,
                              errorText:
                                  controller.gstError.value, // ✅ add this
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    /// 🔥 SAME PREVIEW WIDGET
                    FilePreviewWidget(
                      filePath: controller.gstUrl,
                      fileName: controller.gstFileName,
                      errorText: ''.obs, // avoid duplicate error
                      isLoading: controller.isUploadLoading,
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                _buildField(
                  label: "ID Type",
                  field: Obx(() {
                    return CommonDropdown<int>(
                      items:
                          controller.proofTypeList
                              .map((e) => e.proofTypeID!)
                              .toList(),

                      hintText: 'ID-Type',

                      selectedItem: controller.selectedProofTypeId.value,

                      itemAsString: (id) {
                        final item = controller.proofTypeList.firstWhere(
                          (e) => e.proofTypeID == id,
                        );
                        return item.proofType ?? '';
                      },

                      onChanged: (value) {
                        controller.selectedProofTypeId.value = value;
                      },

                      validator: (val) {
                        if (val == null) {
                          return 'Please select ID-Type';
                        }
                        return null;
                      },
                    );
                  }),
                ),

                _buildField(
                  label: "ID number",
                  field: CommonTextField(
                    controller: controller.idNumberController,
                    focusNode: controller.idNumberFocusNode,
                    hintText: 'Enter ID number*',
                    keyboardType: TextInputType.number,
                    maxLength: 20,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please enter ID number';
                      }
                      return null;
                    },
                  ),
                ),

                _buildLabeledText("Upload ID-Proof"),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonFilePickerBox(
                              label: "Upload Id-Proof",
                              fileKey: "idProof",
                              isLoading: controller.isUploadLoading,
                              uploadingKey: controller.uploadingFileKey,
                              onPick: controller.handleFileUpload,
                              errorText:
                                  controller.idProofError.value, // ✅ add this
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    /// 🔥 SAME PREVIEW WIDGET
                    FilePreviewWidget(
                      filePath: controller.idProofUrl,
                      fileName: controller.idProofFileName,
                      errorText: ''.obs, // avoid duplicate error
                      isLoading: controller.isUploadLoading,
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Obx(() {
                  if (controller.businessTypeError.value.isEmpty) {
                    return const SizedBox();
                  }

                  return Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        controller.businessTypeError.value,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 30),
                // --- Submit Button ---
                Obx(() {
                  return CommonButton(
                    isLoading: controller.isLoading.value,
                    onPressed: controller.createAccount,
                    text:
                        controller.isLoading.value
                            ? "Please wait..."
                            : "Create Account",
                    borderRadius: BorderRadius.circular(40),
                    suffixIcon: SvgPicture.asset(
                      "assets/arrow_outward.svg",
                      color: Colors.white,
                    ),
                  );
                }),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showImagePreview(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(16),
          child: Stack(
            children: [
              InteractiveViewer(
                minScale: 0.8,
                maxScale: 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.contain,
                    placeholder:
                        (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                  ),
                ),
              ),

              /// Close Button
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 28),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget _buildLabeledText(String text) => Padding(
  padding: const EdgeInsets.only(bottom: 4),
  child: Text(
    text,
    style: const TextStyle(fontSize: 18, color: Color(0xff875C00)),
  ),
);
