import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../core/model/news_list_response.dart';
import '../../../services/api_base_service.dart';
import '../../../services/request_method.dart';


class NewsController extends GetxController {
  final isLoading = false.obs;
  final newsList = <NewsData>[].obs;


  @override
  void onInit() {
    super.onInit();
    fetchNews();
  }

  Future<void> fetchNews() async {
    try {
      isLoading(true);

      final NewListResponse response =
      await ApiBaseService.request<NewListResponse>(
        'GetNewsHeadlines?AppID=31a0a9e2-28e6-f011-b836-126635fa33e6',
        method: RequestMethod.GET,
        authenticated: false,
      );

      newsList.assignAll(response.data ?? []);
    } catch (e) {
      debugPrint("❌ News API error: $e");
    } finally {
      isLoading(false);
    }
  }
}
