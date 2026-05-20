class EventListResponse {
  String? status;
  List<EventData>? data;

  EventListResponse({this.status, this.data});

  EventListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <EventData>[];
      json['data'].forEach((v) {
        data!.add(new EventData.fromJson(v));
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

class EventData {
  int? eventID;
  String? eventFullName;
  String? eventDate;
  String? venue;
  String? city;
  String? stallEnquiryURL;
  String? visitorRegistrationURL;
  String? eventLogo;

  EventData(
      {this.eventID,
        this.eventFullName,
        this.eventDate,
        this.venue,
        this.city,
        this.stallEnquiryURL,
        this.visitorRegistrationURL,
        this.eventLogo});

  EventData.fromJson(Map<String, dynamic> json) {
    eventID = json['eventID'];
    eventFullName = json['eventFullName'];
    eventDate = json['eventDate'];
    venue = json['venue'];
    city = json['city'];
    stallEnquiryURL = json['stallEnquiryURL'];
    visitorRegistrationURL = json['visitorRegistrationURL'];
    eventLogo = json['eventLogo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventID'] = this.eventID;
    data['eventFullName'] = this.eventFullName;
    data['eventDate'] = this.eventDate;
    data['venue'] = this.venue;
    data['city'] = this.city;
    data['stallEnquiryURL'] = this.stallEnquiryURL;
    data['visitorRegistrationURL'] = this.visitorRegistrationURL;
    data['eventLogo'] = this.eventLogo;
    return data;
  }
}