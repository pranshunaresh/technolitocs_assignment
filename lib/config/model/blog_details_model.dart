import 'package:assihnment_technolitocs/config/model/news_blog_event_model.dart';

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
  final String bannerVideo;
  final String bannerType;
  final List<MoreDescription> moreDescription;

  BlogData({
    required this.title,
    required this.description,
    required this.bannerImage,
    required this.postDate,
    required this.bannerType,
    required this.bannerVideo,
    required this.moreDescription,
  });

  factory BlogData.fromJson(Map<String, dynamic> json) {
    return BlogData(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      bannerImage: json['bannerImage'] ?? '',
      postDate: json['postDate'] ?? '',
      bannerVideo: json['bannerVideo'] ?? '',
      bannerType: json['bannerType'] ?? '',
      moreDescription: json['moreDescriptions'] ?? '',
    );
  }
}
