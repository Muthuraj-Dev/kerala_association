class OtpResponse {
  String? status;
  String? message;
  OtpData? data;

  OtpResponse({this.status, this.message, this.data});

  OtpResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new OtpData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class OtpData {
  int? otpId;
  String? mobileNumber;
  int? enteredOtp;
  int? sentOtp;

  OtpData({this.otpId, this.mobileNumber, this.enteredOtp, this.sentOtp});

  OtpData.fromJson(Map<String, dynamic> json) {
    otpId = json['otpId'];
    mobileNumber = json['mobileNumber'];
    enteredOtp = json['enteredOtp'];
    sentOtp = json['sentOtp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['otpId'] = otpId;
    data['mobileNumber'] = mobileNumber;
    data['enteredOtp'] = enteredOtp;
    data['sentOtp'] = sentOtp;
    return data;
  }
}