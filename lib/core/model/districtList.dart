class DistrictList {
  int? status;
  List<DistrictData>? data;

  DistrictList({this.status, this.data});

  DistrictList.fromJson(Map<String, dynamic> json) {
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
  int? districtID;
  String? districtName;
  int? stateList;

  DistrictData({this.districtID, this.districtName, this.stateList});

  DistrictData.fromJson(Map<String, dynamic> json) {
    districtID = json['districtID'];
    districtName = json['districtName'];
    stateList = json['stateList'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['districtID'] = this.districtID;
    data['districtName'] = this.districtName;
    data['stateList'] = this.stateList;
    return data;
  }
}