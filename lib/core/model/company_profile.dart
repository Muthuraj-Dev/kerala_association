class CompanyProfile {
  int? status;
  List<CompanyProfileData>? data;

  CompanyProfile({this.status, this.data});

  CompanyProfile.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <CompanyProfileData>[];
      json['data'].forEach((v) {
        data!.add(new CompanyProfileData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CompanyProfileData {
  int? profileID;
  String? profile;

  CompanyProfileData({this.profileID, this.profile});

  CompanyProfileData.fromJson(Map<String, dynamic> json) {
    profileID = json['profileID'];
    profile = json['profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profileID'] = this.profileID;
    data['profile'] = this.profile;
    return data;
  }
}