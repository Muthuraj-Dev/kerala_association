import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kerala_association/core/model/city_list_response.dart';
import 'package:kerala_association/ui/views/members/member_detail.dart';

import '../../../core/model/district_list_response.dart';
import '../../../core/model/member_list_response.dart';
import '../../../services/api_base_service.dart';
import '../../../services/request_method.dart';
import '../../../services/secure_storage_service.dart'; // Assuming Member is here

class MemberController extends GetxController {
  // --- UI Controllers ---
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  final _storage = SecureStorageService(); // or your existing wrapper

  // --- User State ---
  final RxBool isLoggedIn = false.obs;
  final RxString memberId = ''.obs;
  final RxString memberName = ''.obs;

  // final selectedDistrict = Rxn<String>();
  final RxnString selectedItem = RxnString();
  final RxBool isPremiumUnlocked = true.obs;

  // Reactive variable for the currently selected filter.
  final RxString selectedFilter = 'All'.obs;

  /// 🔥 Dynamic filters from API
  final RxList<String> filters = <String>[].obs;

  // 🔍 Search
  final RxString searchQuery = ''.obs;

  // 🧠 Data sources
  final RxList<MemberListData> allMembers = <MemberListData>[].obs;
  final RxList<MemberListData> filteredMembers = <MemberListData>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadProfile().then((_) {
      fetchMembers();
    });

    searchController.addListener(() {
      applyFilters();
    });
  }

  Future<void> loadProfile() async {
    final loggedIn = await _storage.read("is_logged_in");

    if (loggedIn == "true") {
      isLoggedIn.value = true;
      memberId.value = await _storage.read("member_id") ?? '';
      memberName.value = await _storage.read("member_name") ?? '';
      isPremiumUnlocked.value = true;
    } else {
      isLoggedIn.value = false;
      memberId.value = '';
      memberName.value = '';
      isPremiumUnlocked.value = false;
    }
  }

  Future<void> fetchMembers() async {
    try {
      isLoading(true);

      final cityParam = selectedCity.value ?? '';

      final MemberListResponse response =
          await ApiBaseService.request<MemberListResponse>(
            'GetMemberList?city=$cityParam',
            method: RequestMethod.GET,
            authenticated: false,
          );

      if (response.data == null) {
        allMembers.clear();
        filteredMembers.clear();
        filters.clear();
        return;
      }

      allMembers.assignAll(response.data!);

      /// 🔥 EXTRACT UNIQUE PROFILES
      final uniqueProfiles = response.data!
          .map((m) => m.profile!.trim())
          .where((p) => p.isNotEmpty)
          .toSet()
          .toList()
        ..sort();

      filters
        ..clear()
        ..add('All')
        ..addAll(uniqueProfiles);

      /// Default filter
      selectedFilter.value = 'All';

      applyFilters();
    } catch (e, s) {
      debugPrint("❌ Member list API error: $e");
      debugPrintStack(stackTrace: s);
      allMembers.clear();
      filteredMembers.clear();
      filters.clear();
    } finally {
      isLoading(false);
    }
  }

  Future<void> refreshMembers() async {
    // Reset UI state
    searchController.clear();
    searchQuery.value = '';
    selectedFilter.value = 'All';
    selectedCity.value = null;
    selectedDistrict.value = null;

    await fetchMembers();
  }


  void applyLocalSearch(String query) {
    if (query.trim().isEmpty) {
      filteredMembers.assignAll(allMembers);
      return;
    }

    final q = query.toLowerCase();

    filteredMembers.assignAll(
      allMembers.where((m) {
        return (m.memberName ?? '').toLowerCase().contains(q) ||
            (m.mobileNumber ?? '').contains(query) ||
            (m.companyName ?? '').toLowerCase().contains(q);
      }),
    );
  }

  void applyFilters() {
    final query = searchController.text.trim().toLowerCase();
    final filter = selectedFilter.value;
    final city = selectedCity.value;

    filteredMembers.assignAll(
      allMembers.where((m) {
        final matchesCategory =
            filter == 'All'
                ? true
                : (m.profile ?? '').toLowerCase() == filter.toLowerCase();

        final matchesSearch =
            query.isEmpty
                ? true
                : (m.memberName ?? '').toLowerCase().contains(query) ||
                    (m.companyName ?? '').toLowerCase().contains(query) ||
                    (m.mobileNumber ?? '').contains(query);

        final matchesCity =
            city == null
                ? true
                : (m.city ?? '').toLowerCase() == city.toLowerCase();

        return matchesCategory && matchesSearch && matchesCity;
      }),
    );
  }

  /// Updates the selected filter and can trigger a data refetch.
  void updateFilter(String newFilter) {
    selectedFilter.value = newFilter;
    applyFilters(); // 🔥 THIS WAS MISSING
  }


  /// A static helper method for masking. Can be moved to a utility class.
  static String maskMobile(String mobile) {
    // Extract country code if present
    String countryCode = '';
    String number = mobile;

    if (mobile.startsWith('+')) {
      final match = RegExp(r'^(\+\d{1,3})(\d+)$').firstMatch(mobile);
      if (match != null) {
        countryCode = match.group(1)!;
        number = match.group(2)!;
      }
    }

    if (number.length <= 4) return mobile;

    final start = number.substring(0, 1);
    final end = number.substring(number.length - 2);
    final masked = "$start${'x' * (number.length - 4)}$end";

    return countryCode.isNotEmpty ? "$countryCode$masked" : masked;
  }

  final isLoading = false.obs;



  //
  // final districts = List.generate(10, (i) => "District $i").obs;
  final items = <String>[].obs;

  // 📍 Location filters
  final RxList<String> districts = <String>[].obs;

  void selectDistrict(String district) async {
    selectedDistrict.value = district;
    selectedCity.value = null;
    await fetchCities(district);
  }

  void selectCity(String city) {
    selectedCity.value = city;
    applyFilters();

    print("selectedCity ${selectedCity.value}");
  }

  // Reactive list of DistrictData
  final RxList<DistrictData> districtList = <DistrictData>[].obs;
  final RxList<CityData> cityList = <CityData>[].obs;

  final RxBool isDistrictLoaded = false.obs;
  final RxBool isCityLoading = false.obs;

  final RxnString selectedDistrict = RxnString();
  final RxnString selectedCity = RxnString();

  Future<void> fetchDistricts({bool force = false}) async {
    if (isDistrictLoaded.value && !force) return;
    try {
      isLoading.value = true;

      // Call API without generic
      final DistrictListResponse response =
          await ApiBaseService.request<DistrictListResponse>(
            'GetDistrictList',
            method: RequestMethod.GET,
            authenticated: false,
          );

      if (response.status == 200 && response.data != null) {
        districtList.assignAll(response.data!);
        debugPrint(
          "✅ Districts fetched: ${districtList.map((e) => e.districtName).join(', ')}",
        );
        isDistrictLoaded.value = true;
      } else {
        debugPrint("❌ District API returned invalid status");
        districtList.clear();
      }
    } catch (e, s) {
      debugPrint("❌ District API error: $e");
      debugPrintStack(stackTrace: s);
      districtList.clear();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCities(String district) async {
    // Prevent re-fetch if same district already loaded
    if (selectedDistrict.value == district && cityList.isNotEmpty) return;

    try {
      isCityLoading.value = true;
      isLoading.value = true;

      // Call API without generic
      final CityListResponse response =
      await ApiBaseService.request<CityListResponse>(
        'GetCityListByDistrict?District=${selectedDistrict.value}',
        method: RequestMethod.GET,
        authenticated: false,
      );

      if (response.status == 200 && response.data != null) {
        cityList.assignAll(response.data!);
      } else {
        debugPrint("❌ District API returned invalid status");
        cityList.clear();
      }
    } catch (e, s) {
      debugPrint("❌ City API error: $e");
      debugPrintStack(stackTrace: s);
      cityList.clear();
    } finally {
      isLoading.value = false;
      isCityLoading.value = false;
    }
  }

  void reset() {
    print("EMPTY IT");
    selectedDistrict.value = null;
    selectedCity.value = null;
    items.clear();
  }

  @override
  void onClose() {
    scrollController.dispose();
    searchController.dispose();
    super.onClose();
  }

}
