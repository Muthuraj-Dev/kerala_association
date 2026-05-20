class StateList {
  int? status;
  List<StateData>? data;

  StateList({this.status, this.data});

  StateList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <StateData>[];
      json['data'].forEach((v) {
        data!.add(new StateData.fromJson(v));
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

class StateData {
  int? stateID;
  String? stateName;

  StateData({this.stateID, this.stateName});

  StateData.fromJson(Map<String, dynamic> json) {
    stateID = json['stateID'];
    stateName = json['stateName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stateID'] = this.stateID;
    data['stateName'] = this.stateName;
    return data;
  }
}