class HomePageResponse {
  Response? response;
  List<SliderData>? sliderData;
  List<Management>? management;
  DailyMetalPrice? dailyMetalPrice;

  HomePageResponse(
      {this.response, this.sliderData, this.management, this.dailyMetalPrice});

  HomePageResponse.fromJson(Map<String, dynamic> json) {
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
    if (json['sliderData'] != null) {
      sliderData = <SliderData>[];
      json['sliderData'].forEach((v) {
        sliderData!.add(new SliderData.fromJson(v));
      });
    }
    if (json['management'] != null) {
      management = <Management>[];
      json['management'].forEach((v) {
        management!.add(new Management.fromJson(v));
      });
    }
    dailyMetalPrice = json['dailyMetalPrice'] != null
        ? new DailyMetalPrice.fromJson(json['dailyMetalPrice'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.response != null) {
      data['response'] = this.response!.toJson();
    }
    if (this.sliderData != null) {
      data['sliderData'] = this.sliderData!.map((v) => v.toJson()).toList();
    }
    if (this.management != null) {
      data['management'] = this.management!.map((v) => v.toJson()).toList();
    }
    if (this.dailyMetalPrice != null) {
      data['dailyMetalPrice'] = this.dailyMetalPrice!.toJson();
    }
    return data;
  }
}

class Response {
  String? status;
  String? message;

  Response({this.status, this.message});

  Response.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

class SliderData {
  String? sliderImageURL;
  String? sliderStoryURL;

  SliderData({this.sliderImageURL, this.sliderStoryURL});

  SliderData.fromJson(Map<String, dynamic> json) {
    sliderImageURL = json['sliderImageURL'];
    sliderStoryURL = json['sliderStoryURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sliderImageURL'] = this.sliderImageURL;
    data['sliderStoryURL'] = this.sliderStoryURL;
    return data;
  }
}

class Management {
  String? name;
  String? designation;
  String? photoURL;

  Management({this.name, this.designation, this.photoURL});

  Management.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    designation = json['designation'];
    photoURL = json['photoURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['designation'] = this.designation;
    data['photoURL'] = this.photoURL;
    return data;
  }
}

class DailyMetalPrice {
  String? title;
  String? rateDate;
  String? rateTime;
  List<Rates>? rates;

  DailyMetalPrice({this.title, this.rateDate, this.rateTime, this.rates});

  DailyMetalPrice.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    rateDate = json['rateDate'];
    rateTime = json['rateTime'];
    if (json['rates'] != null) {
      rates = <Rates>[];
      json['rates'].forEach((v) {
        rates!.add(new Rates.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['rateDate'] = this.rateDate;
    data['rateTime'] = this.rateTime;
    if (this.rates != null) {
      data['rates'] = this.rates!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rates {
  String? rateDate;
  String? rateTime;
  String? metalType;
  String? label;
  String? unit;
  int? ratePerUnit;
  int? flag;
  int? rateTrend;

  Rates(
      {this.rateDate,
        this.rateTime,
        this.metalType,
        this.label,
        this.unit,
        this.ratePerUnit,
        this.flag,
        this.rateTrend});

  Rates.fromJson(Map<String, dynamic> json) {
    rateDate = json['rateDate'];
    rateTime = json['rateTime'];
    metalType = json['metalType'];
    label = json['label'];
    unit = json['unit'];
    ratePerUnit = json['ratePerUnit'];
    flag = json['flag'];
    rateTrend = json['rateTrend'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rateDate'] = this.rateDate;
    data['rateTime'] = this.rateTime;
    data['metalType'] = this.metalType;
    data['label'] = this.label;
    data['unit'] = this.unit;
    data['ratePerUnit'] = this.ratePerUnit;
    data['flag'] = this.flag;
    data['rateTrend'] = this.rateTrend;
    return data;
  }
}