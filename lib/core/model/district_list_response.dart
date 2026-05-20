class DistrictListResponse {
  int? status;
  List<DistrictData>? data;

  DistrictListResponse({this.status, this.data});

  DistrictListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <DistrictData>[];
      json['data'].forEach((v) {
        data!.add(new DistrictData.fromJson(v));
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

class DistrictData {
  String? districtName;

  DistrictData({this.districtName});

  DistrictData.fromJson(Map<String, dynamic> json) {
    districtName = json['districtName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['districtName'] = this.districtName;
    return data;
  }
}