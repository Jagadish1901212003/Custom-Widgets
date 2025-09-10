class PostResponseModel {
  PostResponseResult? d;

  PostResponseModel({this.d});

  PostResponseModel.fromJson(Map<String, dynamic> json) {
    d = json['d'] != null ? PostResponseResult.fromJson(json['d']) : null;
  }
}

class PostResponseResult {
  final Map<String, dynamic> data;
  PostResponseResult(this.data);
  factory PostResponseResult.fromJson(Map<String, dynamic> json) {
    return PostResponseResult(json);
  }
}
