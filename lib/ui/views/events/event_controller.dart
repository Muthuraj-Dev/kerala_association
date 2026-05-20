import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/model/event_list_response.dart';
import '../../../services/api_base_service.dart';
import '../../../services/request_method.dart';

class EventController extends GetxController {
  final isLoading = false.obs;
  final events = <EventData>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    try {
      isLoading(true);

      final EventListResponse response =
      await ApiBaseService.request<EventListResponse>(
        'GetEventList?AppID=31a0a9e2-28e6-f011-b836-126635fa33e6',
        method: RequestMethod.GET,
        authenticated: false,
      );

      events.assignAll(response.data ?? []);
    } catch (e) {
      debugPrint("❌ Event API error: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> launchUrlSafe(String? url) async {
    if (url == null || url.isEmpty) return;

    final uri = Uri.tryParse(url);
    if (uri == null) return;

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint("❌ Could not open $url");
    }
  }

}
