import 'package:get/get.dart';
import 'package:kerala_association/ui/views/create_account/create_account_controller.dart';
import 'package:kerala_association/ui/views/events/event_controller.dart';
import 'package:kerala_association/ui/views/members/member_controller.dart';
import 'package:kerala_association/ui/views/news/news_controller.dart';
import 'package:kerala_association/ui/views/newsDetail/newsDetail_controller.dart';
import 'package:kerala_association/ui/views/phone/phone_controller.dart';
import 'package:kerala_association/ui/views/profile/profile_controller.dart';

import '../controllers/master_data_controller.dart';
import '../services/secure_storage_service.dart';

// class AppBinding extends Bindings {
//   @override
//   void dependencies() {
//
//
//     // ✅ Master data (GLOBAL + SHARED)
//     Get.put(MasterDataController(), permanent: true,);
//
// // ✅ Feature controllers (lazy)
//     Get.lazyPut(() => NewsController(), fenix: true);
//     // What fenix: true does
//     // If controller is not found → recreate it automatically
//     Get.lazyPut(() => EventController());
//     Get.lazyPut(() => ProfileController(), fenix: true);
//     Get.lazyPut(() => MemberController());
//     Get.lazyPut(() => NewsDetailController(), fenix: true);
//     // Get.put(PhoneController(), permanent: true);
//     Get.put(PhoneController());
//
//     Get.lazyPut(() => CreateAccountController(), fenix: true);
//
//     // Better approach (lazyPut) (recommended)
//     // ✔ Created only when needed
//     // ✔ Cleaner lifecycle
//   }
// }

import 'package:kerala_association/services/appconfig_service.dart';
import 'package:kerala_association/services/network_service.dart';
import 'package:kerala_association/services/navigator_service.dart';
import 'package:kerala_association/services/token_manager.dart';
import 'package:kerala_association/helper/update_checker.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    // =========================
    // 🔥 CORE SERVICES (GLOBAL)
    // =========================

    Get.put(AppConfigService(), permanent: true);
    Get.put(NetworkService(), permanent: true);
    Get.put(NavigationService(), permanent: true);
    Get.put(TokenManager(), permanent: true);
    Get.put(SecureStorageService(), permanent: true);
    Get.put(UpdateChecker(), permanent: true);

    // =========================
    // 🔥 GLOBAL CONTROLLERS
    // =========================

    Get.put(MasterDataController(), permanent: true);

    // =========================
    // 🔥 FEATURE CONTROLLERS
    // =========================

    Get.lazyPut(() => NewsController(), fenix: true);
    Get.lazyPut(() => EventController());
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => MemberController(), fenix: true);
    Get.lazyPut(() => NewsDetailController(), fenix: true);
    Get.put(PhoneController());
    Get.lazyPut(() => CreateAccountController(), fenix: true);
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