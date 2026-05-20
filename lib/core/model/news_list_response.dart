class NewListResponse {
  String? status;
  List<NewsData>? data;

  NewListResponse({this.status, this.data});

  NewListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <NewsData>[];
      json['data'].forEach((v) {
        data!.add(new NewsData.fromJson(v));
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

class NewsData {
  int? newsID;
  String? thumbViewImageURL;
  String? storyPreview;
  String? source;
  String? publishedOn;

  NewsData(
      {this.newsID,
        this.thumbViewImageURL,
        this.storyPreview,
        this.source,
        this.publishedOn});

  NewsData.fromJson(Map<String, dynamic> json) {
    newsID = json['newsID'];
    thumbViewImageURL = json['thumbViewImageURL'];
    storyPreview = json['storyPreview'];
    source = json['source'];
    publishedOn = json['publishedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['newsID'] = this.newsID;
    data['thumbViewImageURL'] = this.thumbViewImageURL;
    data['storyPreview'] = this.storyPreview;
    data['source'] = this.source;
    data['publishedOn'] = this.publishedOn;
    return data;
  }
}