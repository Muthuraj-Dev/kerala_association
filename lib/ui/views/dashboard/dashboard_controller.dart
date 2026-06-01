// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
//
// import '../../../core/model/todo_model.dart';
// import '../../../core/model/user_model.dart';
// import '../../../core/model/user_response.dart';
// import '../../../services/api_base_service.dart';
//
// class DashboardController extends GetxController {
//   var isLoading = false.obs;  // Observable variable to track loading state
//   var user = UserModel().obs;  // Observable variable for user data
//   var todos = <TodoModel>[].obs;  // Observable list for todos
//
//   List<Data> userList = [];  // List to hold user data from API
//
//   @override
//   void onInit() {
//     super.onInit();
//     print("INIT CALLED");
//    // fetchInitialData(); // Fetch data when controller is initialized
//   }
//
//
//   final List<Map<String, dynamic>> items = [
//     {
//       "title": "Join New Plan",
//       "image": "assets/new_plan.png",
//     },
//     {
//       "title": "My Wallet",
//       "image": "assets/wallet.png",
//     },
//     {
//       "title": "Transactions",
//       "image": "assets/transactions.png",
//     },
//   ];
//
//
//   // Function to handle tab changes
//   // GetX automatically updates the UI based on these changes
//   var selectedIndex = 0.obs;
//
//   void onItemTapped(int index) {
//     print("ONNNNNN $index");
//     selectedIndex.value = index;  // Directly update the selected index (no setState needed)
//   }
//
//   // Function to fetch initial data
//   void fetchInitialData() async {
//     isLoading(true);  // Set loading to true
//     try {
//       UserResponse? response = await ApiBaseService.request<UserResponse>(
//         'users?page=2',
//         method: 'GET',
//         authenticated: true,
//       );
//
//       if (response.data!.isNotEmpty) {
//         userList = response.data!;  // Update user list with fetched data
//         print("======= $userList");
//       } else {
//         Fluttertoast.showToast(msg: 'No data found');
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: 'Error: $e');  // Show error toast
//     } finally {
//       isLoading(false);  // Set loading to false after fetching data
//     }
//   }
// }


import 'package:get/get.dart';

import '../../../helper/update_checker.dart';
import '../../../locator.dart';

class DashboardController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  /// 🔥 Add this
  String? pendingNewsId;

  void setPendingNews(String id) {
    pendingNewsId = id;
  }

  void clearPendingNews() {
    pendingNewsId = null;
  }

  void onItemTapped(int index) {
    if (selectedIndex.value == index) return;
    selectedIndex.value = index;
  }

  void goToTab(int index) {
    selectedIndex.value = index;
  }

  bool _hasCheckedUpdate = false;

  @override
  void onReady() {
    super.onReady();

    if (!_hasCheckedUpdate) {
      _hasCheckedUpdate = true;
      locator<UpdateChecker>().versionCheck();
    }
  }
}
