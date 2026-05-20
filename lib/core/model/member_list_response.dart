class MemberListResponse {
  int? status;
  List<MemberListData>? data;

  MemberListResponse({this.status, this.data});

  MemberListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <MemberListData>[];
      json['data'].forEach((v) {
        data!.add(new MemberListData.fromJson(v));
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

class MemberListData {
  String? memberID;
  String? memberName;
  String? designation;
  String? companyName;
  String? address;
  String? city;
  String? pincode;
  String? district;
  String? emailID;
  String? mobileNumber;
  String? maskedMobileNumber;
  String? profile;
  String? memberPhotoURL;

  MemberListData(
      {this.memberID,
        this.memberName,
        this.designation,
        this.companyName,
        this.address,
        this.city,
        this.pincode,
        this.district,
        this.emailID,
        this.mobileNumber,
        this.maskedMobileNumber,
        this.profile,
        this.memberPhotoURL});

  MemberListData.fromJson(Map<String, dynamic> json) {
    memberID = json['memberID'];
    memberName = json['memberName'];
    designation = json['designation'];
    companyName = json['companyName'];
    address = json['address'];
    city = json['city'];
    pincode = json['pincode'];
    district = json['district'];
    emailID = json['emailID'];
    mobileNumber = json['mobileNumber'];
    maskedMobileNumber = json['maskedMobileNumber'];
    profile = json['profile'];
    memberPhotoURL = json['memberPhotoURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['memberID'] = this.memberID;
    data['memberName'] = this.memberName;
    data['designation'] = this.designation;
    data['companyName'] = this.companyName;
    data['address'] = this.address;
    data['city'] = this.city;
    data['pincode'] = this.pincode;
    data['district'] = this.district;
    data['emailID'] = this.emailID;
    data['mobileNumber'] = this.mobileNumber;
    data['maskedMobileNumber'] = this.maskedMobileNumber;
    data['profile'] = this.profile;
    data['memberPhotoURL'] = this.memberPhotoURL;
    return data;
  }
}