import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kerala_association/core/model/home_page_response.dart';
import '../../../core/res/colors.dart';
import '../../../services/api_base_service.dart';
import '../../../services/request_method.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;

  Rx<HomePageResponse?> homeResponse = Rx<HomePageResponse?>(null);

  RxList<SliderData> sliders = <SliderData>[].obs;
  RxList<Management> leaders = <Management>[].obs;
  RxList<Rates> rates = <Rates>[].obs;

  RxString rateTitle = ''.obs;
  RxString rateDate = ''.obs;
  RxString rateTime = ''.obs;


  List<GroupedRate> groupedRates = [];

  void groupRates(List<Rates> rates) {
    final Map<String, List<Rates>> map = {};

    for (var r in rates) {
      String key = r.label!.replaceAll("Gold ", "").toLowerCase();
      // 22K, 18K...

      if (!map.containsKey(key)) {
        map[key] = [];
      }
      map[key]!.add(r);
    }

    groupedRates = map.entries.map((e) {
      return GroupedRate(
        title: e.key.replaceAll('k', 'kt'),
        items: e.value,
      );
    }).toList();
  }

  @override
  void onInit() {
    fetchHomePageData();
    super.onInit();
  }


  void setRateDate(String? apiDate) {
    if (apiDate == null || apiDate.isEmpty) {
      rateDate.value = '';
      return;
    }
    rateDate.value =
        DateFormat('EEE, MMM d, yyyy').format(DateTime.parse(apiDate));
  }


  void fetchHomePageData() async {
    try {
      isLoading(true);

      final HomePageResponse response =
      await ApiBaseService.request<HomePageResponse>(
        'GetHomeScreenData?AppID=31a0a9e2-28e6-f011-b836-126635fa33e6',
        method: RequestMethod.GET,
        authenticated: false,
      );

      homeResponse.value = response;

      // Slider
      sliders.assignAll(response.sliderData ?? []);

      // Management
      leaders.assignAll(response.management ?? []);

      // Rate card
      final daily = response.dailyMetalPrice;
      if (daily != null) {
        rateTitle.value = daily.title ?? '';
        setRateDate(response.dailyMetalPrice!.rateDate!);
        rateTime.value = daily.rateTime ?? '';
        rates.assignAll(daily.rates ?? []);

        /// ✅ IMPORTANT: CALL HERE
        groupRates(rates);
      }
    } catch (e) {
      debugPrint("Home API error: $e");
    } finally {
      isLoading(false);
    }
  }


  MetalTheme getMetalTheme(Rates rate) {
    final isSilver =
    (rate.metalType ?? rate.label ?? '').toLowerCase().contains('silver');

    if (isSilver) {
      return MetalTheme(
        gradient: [AppColor.gradient3, AppColor.gradient4],
        icon: 'assets/silver.svg',
      );
    }

    return MetalTheme(
      gradient: [AppColor.gradient2, AppColor.gradient1],
      icon: 'assets/gold.svg',
    );
  }
}

class GroupedRate {
  final String title; // 24kt, 18kt
  final List<Rates> items;

  GroupedRate({required this.title, required this.items});
}


class MetalTheme {
  final List<Color> gradient;
  final String icon;

  MetalTheme({
    required this.gradient,
    required this.icon,
  });
}







