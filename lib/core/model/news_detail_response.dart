class NewsDetailResponse {
  String? status;
  NewsDetailData? data;

  NewsDetailResponse({this.status, this.data});

  NewsDetailResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new NewsDetailData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class NewsDetailData {
  int? newsID;
  String? storyImageURL;
  String? storyPreviewContent;
  String? storyFullContent;
  String? source;
  String? publishedOn;

  NewsDetailData(
      {this.newsID,
        this.storyImageURL,
        this.storyPreviewContent,
        this.storyFullContent,
        this.source,
        this.publishedOn});

  NewsDetailData.fromJson(Map<String, dynamic> json) {
    newsID = json['newsID'];
    storyImageURL = json['storyImageURL'];
    storyPreviewContent = json['storyPreviewContent'];
    storyFullContent = json['storyFullContent'];
    source = json['source'];
    publishedOn = json['publishedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['newsID'] = newsID;
    data['storyImageURL'] = storyImageURL;
    data['storyPreviewContent'] = storyPreviewContent;
    data['storyFullContent'] = storyFullContent;
    data['source'] = source;
    data['publishedOn'] = publishedOn;
    return data;
  }
}