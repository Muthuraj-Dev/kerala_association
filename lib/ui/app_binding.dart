import 'package:get/get.dart';
import 'package:kerala_association/ui/views/events/event_controller.dart';
import 'package:kerala_association/ui/views/members/member_controller.dart';
import 'package:kerala_association/ui/views/news/news_controller.dart';
import 'package:kerala_association/ui/views/newsDetail/newsDetail_controller.dart';
import 'package:kerala_association/ui/views/phone/phone_controller.dart';
import 'package:kerala_association/ui/views/profile/profile_controller.dart';

import '../controllers/master_data_controller.dart';
import '../services/secure_storage_service.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    // ✅ Core services
    Get.put(SecureStorageService(), permanent: true);

    // ✅ Master data (GLOBAL + SHARED)
    Get.put(MasterDataController(), permanent: true,);

// ✅ Feature controllers (lazy)
    Get.lazyPut(() => NewsController(), fenix: true);
    // What fenix: true does
    // If controller is not found → recreate it automatically
    Get.lazyPut(() => EventController());
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => MemberController());
    Get.lazyPut(() => NewsDetailController(), fenix: true);
    Get.put(PhoneController(), permanent: true);

    // Better approach (lazyPut) (recommended)
    // ✔ Created only when needed
    // ✔ Cleaner lifecycle
  }
}

// Get.put(EventController(), permanent: true);
// This means:
// Created immediately at app start
// Never removed from memory
// Lives for entire app lifecycle

//⚠️ When this is GOOD
//
// Use permanent: true - only for core/global services
//
// ✅ Good use cases
// Auth / User session
// App settings
// Secure storage
// Theme / language
// App-wide config
//
// Example (correct):
//
// Get.put(SecureStorageService(), permanent: true);
// ⚠️ When this is BAD (your case)
//
// Using it for:
//
// Get.put(EventController(), permanent: true); ❌
// Get.put(ProfileController(), permanent: true); ❌
// Get.put(MemberController(), permanent: true); ❌
//
// 👉 Problems:
// Memory never freed
// Data becomes stale
// Controllers keep old state forever
// Hard to refresh properly
// 🧠 Think like this
// Controller type	Should it be permanent?
// App service	✅ YES
// API data (list/detail)	❌ NO
// Screen-specific logic	❌ NO