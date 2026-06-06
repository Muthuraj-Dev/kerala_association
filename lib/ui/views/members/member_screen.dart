import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kerala_association/common_widget/common_button.dart';
import 'package:kerala_association/common_widget/common_dialog.dart';
import 'package:kerala_association/common_widget/common_text_field.dart';
import 'package:kerala_association/core/res/colors.dart';
import '../../../core/model/member_list_response.dart';
import '../phone/phone_screen.dart';
import 'member_controller.dart';
import 'member_detail.dart';

class MemberScreen extends StatelessWidget {
  const MemberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MemberController>();

    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10, top: 16,),
              child: Text(
                "Network with members",
                style: TextStyle(fontSize: 24),
              ),
            ),

            Obx(
              () => IgnorePointer(
                ignoring: !controller.isPremiumUnlocked.value,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: CommonTextField(
                          controller: controller.searchController,
                          focusNode: controller.searchFocusNode,
                          fillColor: const Color(0xffDEDEDE),
                          borderColor: Colors.transparent,
                          hintText: 'Search Members',
                          prefixIcon: const Icon(Icons.search),
                          onChanged: (value) {
                            controller.searchQuery.value = value;
                            controller.applyLocalSearch(value);
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      _FilterButton(controller),
                    ],
                  ),
                ),
              ),
            ),

            /// 🏷 Filter Chips
            Obx(
              () => IgnorePointer(
                ignoring: !controller.isPremiumUnlocked.value,
                child: _buildFilterChips(controller),
              ),
            ),

            const SizedBox(height: 8),

            /// 👥 MEMBER LIST WITH PREMIUM LOCK
            Expanded(
              child: Obx(
                () => Stack(
                  children: [
                    /// MEMBER LIST
                    IgnorePointer(
                      ignoring: !controller.isPremiumUnlocked.value,
                      child: RefreshIndicator(
                        onRefresh: controller.refreshMembers,
                        displacement: 60,
                        edgeOffset: 20,
                        child: _buildMemberList(controller),
                      ),
                    ),

                    /// 🔒 PREMIUM OVERLAY
                    if (!controller.isPremiumUnlocked.value)
                      Positioned(
                        left: 0,
                        right: 0,
                        top: -30,
                        child: Image.asset("assets/bgColor.png"),
                      ),
                    if (!controller.isPremiumUnlocked.value)
                      Positioned(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset("assets/premium.svg"),
                                const SizedBox(height: 8),
                                Text(
                                  "Unlock Premium",
                                  style: TextStyle(fontSize: 24),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "Get access to all premium features and take your experience to the next level",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColor.textDisable,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                CommonButton(
                                  text: "Login to Access", // "Get Premium",
                                  onPressed: () {
                                    Get.to(() => PhoneScreen());
                                  },
                                  borderRadius: BorderRadius.circular(50),
                                  fillColor: AppColor.secondary,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildFilterChips(MemberController controller) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Obx(() {
              final isAnySelected =
                  controller.selectedFilter.value != 'All' ||
                  controller.selectedDistrict.value != null ||
                  controller.selectedCity.value != null;

              if (!isAnySelected) return const SizedBox.shrink();

              return GestureDetector(
                onTap: () async {
                  controller.selectedFilter.value = 'All';
                  controller.selectedDistrict.value = null;
                  controller.selectedCity.value = null;
                  //    controller.applyFilters();
                  controller.items.clear();
                  await controller.fetchMembers();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    border: Border.all(color: AppColor.primary),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "Clear",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              );
            }),
            SizedBox(width: 10),
            ...controller.filters.map((filter) {
              return Obx(() {
                final isSelected = controller.selectedFilter.value == filter;
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: _FilterChip(
                    label: filter,
                    isSelected: isSelected,
                    onTap: () => controller.updateFilter(filter),
                  ),
                );
              });
            }).toList(),
          ],
        ),
        SizedBox(height: 10),

        Obx(() {
          final city = controller.selectedCity.value;

          if (city == null || city.isEmpty) {
            return const SizedBox.shrink();
          }

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  city,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 6),

                /// ❌ Clear icon
                GestureDetector(
                  onTap: () async {
                    controller.selectedCity.value = null;
                    controller.selectedDistrict.value = null;

                    controller.applyFilters();
                    await controller.fetchMembers();
                  },
                  child: const Icon(
                    Icons.close,
                    size: 16,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    ),
  );
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.secondary : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isSelected ? AppColor.secondary : AppColor.subTitle,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(color: isSelected ? AppColor.white : AppColor.black),
        ),
      ),
    );
  }
}

Widget _buildMemberList(MemberController controller) {
  return Obx(() {
    if (controller.isLoading.value) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.only(top: 10),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (controller.filteredMembers.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.only(top: 40),
          child: Text(
            "No members found",
            style: TextStyle(color: AppColor.textDisable),
          ),
        ),
      );
    }

    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      itemCount: controller.filteredMembers.length,
      separatorBuilder: (_, __) => const Divider(height: 12, indent: 102),
      itemBuilder: (context, index) {
        final member = controller.filteredMembers[index];

        return _MemberListItem(
          member: member,
          isPremiumUnlocked: controller.isPremiumUnlocked.value,
          onTap: () {
            if (!controller.isPremiumUnlocked.value) {
              Get.snackbar(
                "Premium Required",
                "Upgrade to view full member details",
                snackPosition: SnackPosition.BOTTOM,
              );
              return;
            }

            Get.to(() => MemberDetail(member: member));
          },
        );
      },
    );
  });
}

class _MemberListItem extends StatelessWidget {
  final MemberListData member;
  final bool isPremiumUnlocked;
  final VoidCallback onTap;

  const _MemberListItem({
    required this.member,
    required this.isPremiumUnlocked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: member.memberPhotoURL ?? '',
                width: 92,
                height: 92,
                fit: BoxFit.cover,
                placeholder:
                    (_, __) => Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: const CircularProgressIndicator(strokeWidth: 2),
                    ),
                errorWidget: (_, __, ___) => Image.asset('assets/logo.png'),
              ),
            ),
            const SizedBox(width: 10),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.green,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      member.profile ?? '',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColor.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),

                  Text(
                    member.memberName ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  Text(
                    member.companyName ?? '',
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColor.secondary,
                    ),
                  ),

                  Text(
                    isPremiumUnlocked
                        ? member.mobileNumber ?? ''
                        : MemberController.maskMobile(
                          member.mobileNumber ?? '',
                        ),
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColor.textDisable,
                    ),
                  ),
                ],
              ),
            ),

            Icon(
              isPremiumUnlocked ? Icons.arrow_forward_ios : Icons.lock,
              size: 18,
              color: AppColor.textDisable,
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterButton extends StatelessWidget {
  final MemberController controller;

  const _FilterButton(this.controller);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.fetchDistricts();
        CommonDialog.showBottomSheetDialog(
          content: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SizedBox(
              height: MediaQuery.of(Get.context!).size.height * 0.7,
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                /// SECOND LIST
                if (controller.selectedDistrict.value != null) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: controller.reset,
                          ),
                          Text(
                            controller.selectedDistrict.value!,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: AppColor.green,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      Expanded(
                        child: ListView.separated(
                          itemCount: controller.cityList.length,
                          separatorBuilder: (_, __) => const Divider(),
                          itemBuilder: (_, index) {
                            final city = controller.cityList[index];
                            return InkWell(
                              onTap: () {
                                controller.selectCity(city.cityName ?? "");
                                controller.fetchMembers();

                                //   controller.reset();

                                Get.back();
                              },
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      city.cityName ?? "",
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  Radio<String>(
                                    value: city.cityName ?? "",
                                    groupValue: controller.selectedItem.value,
                                    onChanged: (value) {
                                      controller.selectedItem.value = value;
                                      controller.reset();
                                      Get.back();
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }

                /// DISTRICT LIST
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Districts",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: AppColor.green,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.separated(
                        itemCount: controller.districtList.length,
                        separatorBuilder: (_, __) => const Divider(),
                        itemBuilder: (_, index) {
                          final district = controller.districtList[index];
                          return InkWell(
                            onTap:
                                () => controller.selectDistrict(
                                  district.districtName!,
                                ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  SvgPicture.asset("assets/location.svg"),
                                  const SizedBox(width: 10),
                                  Text(
                                    district.districtName ?? "",
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  const Spacer(),
                                  const Icon(Icons.arrow_forward_ios, size: 18),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xffDEDEDE),
          borderRadius: BorderRadius.circular(100),
        ),
        padding: const EdgeInsets.all(16),
        child: SvgPicture.asset("assets/filter.svg"),
      ),
    );
  }
}
