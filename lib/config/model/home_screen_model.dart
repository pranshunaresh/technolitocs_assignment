import 'dart:convert';

class HomeScreenModel {
  bool status;
  int code;
  String message;
  Data data;

  HomeScreenModel({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });

  factory HomeScreenModel.fromJson(Map<String, dynamic> json) =>
      HomeScreenModel(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  List<PostDatum> postData;
  List<GalleryDatum> galleryData;
  List<MagazineDatum> magazineData;

  Data({
    required this.postData,
    required this.galleryData,
    required this.magazineData,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    postData: List<PostDatum>.from(
      json["postData"].map((x) => PostDatum.fromJson(x)),
    ),
    galleryData: List<GalleryDatum>.from(
      json["galleryData"].map((x) => GalleryDatum.fromJson(x)),
    ),
    magazineData: List<MagazineDatum>.from(
      json["magazineData"].map((x) => MagazineDatum.fromJson(x)),
    ),
  );
}

class GalleryDatum {
  String id;
  String title;
  String description;
  List<String> images;
  List<GalleryDatumMoreDescription> moreDescriptions;
  String albumType;
  String videoLink;
  String backLink;
  String type;
  List<UserType> userType;
  List<dynamic> selectedUserCategory;
  List<dynamic> centerandsubcenterIds;
  String authorityLevel;
  DefaultStatus defaultStatus;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  GalleryDatum({
    required this.id,
    required this.title,
    required this.description,
    required this.images,
    required this.moreDescriptions,
    required this.albumType,
    required this.videoLink,
    required this.backLink,
    required this.type,
    required this.userType,
    required this.selectedUserCategory,
    required this.centerandsubcenterIds,
    required this.authorityLevel,
    required this.defaultStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory GalleryDatum.fromJson(Map<String, dynamic> json) => GalleryDatum(
    id: json["_id"],
    title: json["title"],
    description: json["description"],
    images: List<String>.from(json["images"].map((x) => x)),
    moreDescriptions: List<GalleryDatumMoreDescription>.from(
      json["moreDescriptions"].map(
        (x) => GalleryDatumMoreDescription.fromJson(x),
      ),
    ),
    albumType: json["albumType"],
    videoLink: json["videoLink"],
    backLink: json["backLink"],
    type: json["type"],
    userType: List<UserType>.from(
      json["userType"].map((x) => userTypeValues.map[x]!),
    ),
    selectedUserCategory: List<dynamic>.from(json["selectedUserCategory"]),
    centerandsubcenterIds: List<dynamic>.from(json["centerandsubcenterIds"]),
    authorityLevel: json["authorityLevel"],
    defaultStatus: defaultStatusValues.map[json["defaultStatus"]]!,
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );
}

class GalleryDatumMoreDescription {
  String singleImage;
  String title;

  GalleryDatumMoreDescription({required this.singleImage, required this.title});

  factory GalleryDatumMoreDescription.fromJson(Map<String, dynamic> json) =>
      GalleryDatumMoreDescription(
        singleImage: json["singleImage"],
        title: json["title"],
      );
}

class MagazineDatum {
  String id;
  String title;
  String description;
  String coverImage;
  String file;
  DefaultStatus defaultStatus;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  MagazineDatum({
    required this.id,
    required this.title,
    required this.description,
    required this.coverImage,
    required this.file,
    required this.defaultStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory MagazineDatum.fromJson(Map<String, dynamic> json) => MagazineDatum(
    id: json["_id"],
    title: json["title"],
    description: json["description"],
    coverImage: json["coverImage"],
    file: json["file"],
    defaultStatus: defaultStatusValues.map[json["defaultStatus"]]!,
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );
}

class PostDatum {
  String id;
  String title;
  String description;
  BannerType bannerType;
  String postCategory;
  DateTime postDate;
  List<dynamic> centerandsubcenterIds;
  String authorityLevel;
  List<UserType> userType;
  List<dynamic> selectedUserCategory;
  String bannerImage;
  String bannerVideo;
  String seoTitle;
  String seoSlug;
  String seoMetaDescription;
  List<SeoTag> seoTags;
  List<PostDatumMoreDescription> moreDescriptions;
  CreatedById createdById;
  DefaultStatus defaultStatus;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  PostDatum({
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

  factory PostDatum.fromJson(Map<String, dynamic> json) => PostDatum(
    id: json["_id"],
    title: json["title"],
    description: json["description"],
    bannerType: bannerTypeValues.map[json["bannerType"]]!,
    postCategory: json["postCategory"],
    postDate: DateTime.parse(json["postDate"]),
    centerandsubcenterIds: List<dynamic>.from(json["centerandsubcenterIds"]),
    authorityLevel: json["authorityLevel"],
    userType: List<UserType>.from(
      json["userType"].map((x) => userTypeValues.map[x]!),
    ),
    selectedUserCategory: List<dynamic>.from(json["selectedUserCategory"]),
    bannerImage: json["bannerImage"],
    bannerVideo: json["bannerVideo"],
    seoTitle: json["seoTitle"],
    seoSlug: json["seoSlug"],
    seoMetaDescription: json["seoMetaDescription"],
    seoTags: List<SeoTag>.from(
      json["seoTags"].map((x) => seoTagValues.map[x]!),
    ),
    moreDescriptions: List<PostDatumMoreDescription>.from(
      json["moreDescriptions"].map((x) => PostDatumMoreDescription.fromJson(x)),
    ),
    createdById: createdByIdValues.map[json["createdById"]]!,
    defaultStatus: defaultStatusValues.map[json["defaultStatus"]]!,
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );
}

class PostDatumMoreDescription {
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

  PostDatumMoreDescription({
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

  factory PostDatumMoreDescription.fromJson(Map<String, dynamic> json) =>
      PostDatumMoreDescription(
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

// ENUMS + MAPPERS

enum DefaultStatus { ACTIVE }

final defaultStatusValues = EnumValues({"ACTIVE": DefaultStatus.ACTIVE});

enum UserType { EVERYONE }

final userTypeValues = EnumValues({"EVERYONE": UserType.EVERYONE});

enum BannerType { IMAGE }

final bannerTypeValues = EnumValues({"IMAGE": BannerType.IMAGE});

enum CreatedById { THE_681346_AB0417_F623_F278_C16_C }

final createdByIdValues = EnumValues({
  "681346ab0417f623f278c16c": CreatedById.THE_681346_AB0417_F623_F278_C16_C,
});

enum SeoTag { ROLBOL }

final seoTagValues = EnumValues({"rolbol": SeoTag.ROLBOL});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}
