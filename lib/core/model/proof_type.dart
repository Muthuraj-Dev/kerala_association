class ProofType {
  int? status;
  List<ProofTypeData>? data;

  ProofType({this.status, this.data});

  ProofType.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <ProofTypeData>[];
      json['data'].forEach((v) {
        data!.add(new ProofTypeData.fromJson(v));
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

class ProofTypeData {
  int? proofTypeID;
  String? proofType;

  ProofTypeData({this.proofTypeID, this.proofType});

  ProofTypeData.fromJson(Map<String, dynamic> json) {
    proofTypeID = json['proofTypeID'];
    proofType = json['proofType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['proofTypeID'] = this.proofTypeID;
    data['proofType'] = this.proofType;
    return data;
  }
}