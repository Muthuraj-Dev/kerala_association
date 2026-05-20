class CompanyType {
  int? status;
  List<CompanyTypeData>? data;

  CompanyType({this.status, this.data});

  CompanyType.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <CompanyTypeData>[];
      json['data'].forEach((v) {
        data!.add(new CompanyTypeData.fromJson(v));
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

class CompanyTypeData {
  int? companyTypeID;
  String? companyType;

  CompanyTypeData({this.companyTypeID, this.companyType});

  CompanyTypeData.fromJson(Map<String, dynamic> json) {
    companyTypeID = json['companyTypeID'];
    companyType = json['companyType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['companyTypeID'] = this.companyTypeID;
    data['companyType'] = this.companyType;
    return data;
  }
}