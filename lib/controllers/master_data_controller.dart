import 'package:get/get.dart';

import '../core/model/company_profile.dart';
import '../core/model/company_type.dart';
import '../core/model/proof_type.dart';
import '../core/model/stateList.dart';
import '../services/api_base_service.dart';
import '../services/request_method.dart';

class MasterDataController extends GetxController {
  RxList<StateData> states = <StateData>[].obs;
  RxList<CompanyTypeData> companyTypes = <CompanyTypeData>[].obs;
  RxList<CompanyProfileData> companyProfiles = <CompanyProfileData>[].obs;
  RxList<ProofTypeData> proofTypes = <ProofTypeData>[].obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadInitialData();
  }


  Future<void> loadInitialData() async {
    print("loadInitialData CALLED");
    try {
      isLoading(true);

      final results = await Future.wait([
        fetchStates(),
        fetchCompanyType(),
        fetchCompanyProfile(),
        fetchProofType(),
      ]);

      states.assignAll(results[0] as List<StateData>);
      companyTypes.assignAll(results[1] as List<CompanyTypeData>);
      companyProfiles.assignAll(results[2] as List<CompanyProfileData>);
      proofTypes.assignAll(results[3] as List<ProofTypeData>);

      print("RX LIST LENGTH: ${companyTypes.length}");

    } catch (e) {
      print("Error loading master data: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<List<CompanyTypeData>> fetchCompanyType() async {
    print("fetchCompanyType");
    try {
      CompanyType response = await ApiBaseService.request(
        'GetCompanyTypeList',
        method: RequestMethod.GET,
        authenticated: false,
      );
      if (response.status == 200 && response.data != null) {
        return response.data!;
      } else {
        return [];
      }
    } catch (e) {
      print('Error fetching company types: $e');
      return [];
    }
  }

  Future<List<CompanyProfileData>> fetchCompanyProfile() async {
    print("fetchCompanyProfile");

    try {
      CompanyProfile response = await ApiBaseService.request(
        'GetCompanyProfileList',
        method: RequestMethod.GET,
        authenticated: false,
      );

      if (response.status == 200 && response.data != null) {
        return response.data!;
      } else {
        return [];
      }
    } catch (e) {
      print('Error fetching company profile: $e');
      return [];
    }
  }

  Future<List<ProofTypeData>> fetchProofType() async {
    print("fetchProofType");

    try {
      ProofType response = await ApiBaseService.request(
        'GetProofIDList',
        method: RequestMethod.GET,
        authenticated: false,
      );

      if (response.status == 200 && response.data != null) {
        return response.data!;
      } else {
        return [];
      }
    } catch (e) {
      print('Error fetching proof types: $e');
      return [];
    }
  }

  Future<List<StateData>> fetchStates() async {
    print("fetchStates");

    try {
      StateList response = await ApiBaseService.request(
        'GetStateList',
        method: RequestMethod.GET,
        authenticated: false,
      );

      if (response.status == 200 && response.data != null) {
        return response.data!;
      } else {
        return [];
      }
    } catch (e) {
      print('Error fetching states: $e');
      return [];
    }
  }
}


// Fetch State List
// Future<List<StateData>> fetchStateList() async {
//   try {
//     StateList response = await ApiBaseService.request<StateList>(
//       'SQ/GetStateList',
//       method: RequestMethod.GET,
//       authenticated: false,
//     );
//
//     if (response.response?.status == "200" && response.stateData != null) {
//       return response.stateData!;
//     } else {
//       return [];
//     }
//   } catch (e) {
//     print('Error fetching state list: $e');
//     return [];
//   }
// }


// Call this once at app start
// Future<void> loadInitialData() async {
//   print("loadInitialData CALLED");
//   try {
//     isLoading(true);
//     final results = await Future.wait([
//       fetchStateList(),
//     ]);
//     states.assignAll(results[1]);
//   } catch (e) {
//     print("Error loading master data: $e");
//   } finally {
//     isLoading(false);
//   }
// }