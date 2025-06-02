// lib/models/news_blog_event_model.dart
import 'dart:convert';

NewsBlogEventModel newsBlogEventModelFromJson(String str) =>
    NewsBlogEventModel.fromJson(json.decode(str));

class NewsBlogEventModel {
  bool status;
  int code;
  int count;
  String message;
  List<NewsBlogEventResponses> data;

  NewsBlogEventModel({
    required this.status,
    required this.code,
    required this.count,
    required this.message,
    required this.data,
  });

  factory NewsBlogEventModel.fromJson(Map<String, dynamic> json) =>
      NewsBlogEventModel(
        status: json["status"],
        code: json["code"],
        count: json["count"],
        message: json["message"],
        data: List<NewsBlogEventResponses>.from(
          json["data"].map((x) => NewsBlogEventResponses.fromJson(x)),
        ),
      );
}

class NewsBlogEventResponses {
  String id;
  String title;
  String description;
  String bannerType;
  String postCategory;
  DateTime postDate;
  List<dynamic> centerandsubcenterIds;
  String authorityLevel;
  List<String> userType;
  List<dynamic> selectedUserCategory;
  String bannerImage;
  String bannerVideo;
  String seoTitle;
  String seoSlug;
  String seoMetaDescription;
  List<String> seoTags;
  List<MoreDescription> moreDescriptions;
  String createdById;
  String defaultStatus;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  NewsBlogEventResponses({
    required this.id,
    required this.title,
    required this.description,
    required this.bannerType,
    required this.postCategory,
    required this.postDate,
    required this.centerandsubcenterIds,
    required this.authorityLevel,
    required this.userType,
    required this.selectedUserCategory,
    required this.bannerImage,
    required this.bannerVideo,
    required this.seoTitle,
    required this.seoSlug,
    required this.seoMetaDescription,
    required this.seoTags,
    required this.moreDescriptions,
    required this.createdById,
    required this.defaultStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory NewsBlogEventResponses.fromJson(Map<String, dynamic> json) =>
      NewsBlogEventResponses(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        bannerType: json["bannerType"],
        postCategory: json["postCategory"],
        postDate: DateTime.parse(json["postDate"]),
        centerandsubcenterIds: json["centerandsubcenterIds"],
        authorityLevel: json["authorityLevel"],
        userType: List<String>.from(json["userType"].map((x) => x)),
        selectedUserCategory: json["selectedUserCategory"],
        bannerImage: json["bannerImage"],
        bannerVideo: json["bannerVideo"],
        seoTitle: json["seoTitle"],
        seoSlug: json["seoSlug"],
        seoMetaDescription: json["seoMetaDescription"],
        seoTags: List<String>.from(json["seoTags"].map((x) => x)),
        moreDescriptions: List<MoreDescription>.from(
          json["moreDescriptions"].map((x) => MoreDescription.fromJson(x)),
        ),
        createdById: json["createdById"],
        defaultStatus: json["defaultStatus"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );
}

class MoreDescription {
  List<String> multipleImages;
  String singleImage;
  String description;
  String attachmentLink;
  String youtube;
  String facebook;
  String instagram;
  String twitter;
  String buttonTitle;
  String buttonLink;
  String id;

  MoreDescription({
    required this.multipleImages,
    required this.singleImage,
    required this.description,
    required this.attachmentLink,
    required this.youtube,
    required this.facebook,
    required this.instagram,
    required this.twitter,
    required this.buttonTitle,
    required this.buttonLink,
    required this.id,
  });

  factory MoreDescription.fromJson(Map<String, dynamic> json) =>
      MoreDescription(
        multipleImages: List<String>.from(json["multipleImages"].map((x) => x)),
        singleImage: json["singleImage"],
        description: json["description"],
        attachmentLink: json["attachmentLink"],
        youtube: json["youtube"],
        facebook: json["facebook"],
        instagram: json["instagram"],
        twitter: json["twitter"],
        buttonTitle: json["buttonTitle"],
        buttonLink: json["buttonLink"],
        id: json["_id"],
      );
}
