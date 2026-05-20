import 'package:kerala_association/core/model/city_list_response.dart';
import 'package:kerala_association/core/model/company_profile.dart';
import 'package:kerala_association/core/model/company_type.dart';
import 'package:kerala_association/core/model/districtList.dart';
import 'package:kerala_association/core/model/otp_response.dart';
import 'package:kerala_association/core/model/proof_type.dart';
import 'package:kerala_association/core/model/stateList.dart';

import '../core/model/district_list_response.dart';
import '../core/model/event_list_response.dart';
import '../core/model/home_page_response.dart';
import '../core/model/member_list_response.dart';
import '../core/model/news_detail_response.dart';
import '../core/model/news_list_response.dart';
import '../core/model/product_all.dart';

class JsonParsers {
  static T fromJson<T>(Map<String, dynamic> json) {
    if (T == ProductAll) {
      return ProductAll.fromJson(json) as T;
    } else if (T == Category) {
      return Category.fromJson(json) as T;
    } else if (T == HomePageResponse) {
      return HomePageResponse.fromJson(json) as T;
    } else if (T == NewListResponse) {
      return NewListResponse.fromJson(json) as T;
    } else if (T == NewsDetailResponse) {
      return NewsDetailResponse.fromJson(json) as T;
    } else if (T == EventListResponse) {
      return EventListResponse.fromJson(json) as T;
    } else if (T == OtpResponse) {
      return OtpResponse.fromJson(json) as T;
    } else if (T == MemberListResponse) {
      return MemberListResponse.fromJson(json) as T;
    } else if (T == DistrictListResponse) {
      return DistrictListResponse.fromJson(json) as T;
    } else if (T == CityListResponse) {
      return CityListResponse.fromJson(json) as T;
    } else if (T == Map<String, dynamic>) {
      return json as T;
    } else if (T == CompanyType) {
      return CompanyType.fromJson(json) as T;
    } else if (T == CompanyProfile) {
      return CompanyProfile.fromJson(json) as T;
    } else if (T == ProofType) {
      return ProofType.fromJson(json) as T;
    } else if (T == StateList) {
      return StateList.fromJson(json) as T;
    } else if (T == DistrictList) {
      return DistrictList.fromJson(json) as T;
    }
    else {
      throw Exception('Unsupported type $T');
    }
  }
}
