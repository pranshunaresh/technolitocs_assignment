class BlogDetailsModel {
  final bool status;
  final int code;
  final String message;
  final BlogData data;

  BlogDetailsModel({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });

  factory BlogDetailsModel.fromJson(Map<String, dynamic> json) {
    return BlogDetailsModel(
      status: json['status'],
      code: json['code'],
      message: json['message'],
      data: BlogData.fromJson(json['data']),
    );
  }
}

class BlogData {
  final String title;
  final String description;
  final String bannerImage;
  final String postDate;

  BlogData({
    required this.title,
    required this.description,
    required this.bannerImage,
    required this.postDate,
  });

  factory BlogData.fromJson(Map<String, dynamic> json) {
    return BlogData(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      bannerImage: json['bannerImage'] ?? '',
      postDate: json['postDate'] ?? '',
    );
  }
}
