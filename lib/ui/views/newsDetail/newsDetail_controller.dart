import 'package:get/get.dart';

import 'package:flutter/foundation.dart';

import 'package:intl/intl.dart';
import '../../../core/model/news_detail_response.dart';
import '../../../services/api_base_service.dart';
import '../../../services/request_method.dart';

// class NewsDetailController extends GetxController {
//   final isLoading = false.obs;
//   final detail = Rxn<NewsDetailData>();
//
//   Future<void> fetchNewsDetail(int newsId) async {
//     try {
//       isLoading(true);
//
//       final NewsDetailResponse response =
//       await ApiBaseService.request<NewsDetailResponse>(
//         'GetNewsStory?NewsID=$newsId',
//         method: RequestMethod.GET,
//         authenticated: false,
//       );
//
//       detail.value = response.data;
//     } catch (e) {
//       debugPrint("❌ News detail API error: $e");
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   String formatNewsDetailDate(String? date) {
//     if (date == null || date.isEmpty) return '';
//
//     try {
//       final parsed =
//       DateFormat('dd-MM-yyyy HH:mm:ss').parse(date);
//       return DateFormat('dd MMM yyyy • hh:mm a').format(parsed);
//     } catch (_) {
//       return date;
//     }
//   }
//
// }

class NewsDetailController extends GetxController {
  final isLoading = false.obs;

  /// 🔥 GLOBAL CACHE (shared across app)
  static final Map<int, NewsDetailData> _cache = {};

  final detail = Rxn<NewsDetailData>();
  int? _currentNewsId;

  Future<void> fetchNewsDetail(int newsId) async {
    /// prevent same API call again
    if (_currentNewsId == newsId && detail.value != null) {
      return;
    }

    /// serve from cache
    if (_cache.containsKey(newsId)) {
      _currentNewsId = newsId;
      detail.value = _cache[newsId];
      return;
    }

    try {
      _currentNewsId = newsId;
      isLoading(true);

      final NewsDetailResponse response =
      await ApiBaseService.request<NewsDetailResponse>(
        'GetNewsStory?NewsID=$newsId',
        method: RequestMethod.GET,
        authenticated: false,
      );

      if (response.data != null) {
        _cache[newsId] = response.data!;
        detail.value = response.data;
      }
    } catch (e) {
      debugPrint("❌ News detail API error: $e");
    } finally {
      isLoading(false);
    }
  }

  String formatNewsDetailDate(String? date) {
    if (date == null || date.isEmpty) return '';
    try {
      final parsed =
      DateFormat('dd-MM-yyyy HH:mm:ss').parse(date);
      return DateFormat('dd MMM yyyy • hh:mm a').format(parsed);
    } catch (_) {
      return date;
    }
  }
}

