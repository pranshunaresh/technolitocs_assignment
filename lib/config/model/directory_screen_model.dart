// import 'dart:convert';
//
// class DirectoryProfile {
//   final String name;
//   final String profilePicture;
//   final String defaultStatus;
//   final String? rbNationalDesignationId;
//   final String? rbChapterDesignationId;
//   final String? cityId;
//   final bool isPioneerMember;
//
//   var companyName;
//
//   DirectoryProfile({
//     required this.name,
//     required this.profilePicture,
//     required this.defaultStatus,
//     this.rbNationalDesignationId,
//     this.rbChapterDesignationId,
//     this.cityId,
//     required this.isPioneerMember,
//   });
//
//   factory DirectoryProfile.fromJson(Map<String, dynamic> json) {
//     bool x = json['membershipType'].contains("PIONEER_PATRON_MEMBER");
//
//     return DirectoryProfile(
//       name: json['name'] ?? '',
//       profilePicture: json['profilePicture'] ?? '',
//       defaultStatus: json['defaultStatus'] ?? '',
//       rbNationalDesignationId: json['rbNationalDesignationId'],
//       rbChapterDesignationId: json['rbChapterDesignationId'],
//       cityId: json['cityId'],
//       isPioneerMember: x,
//     );
//   }
//
//   get email => null;
//
//   get phone => null;
//
//   get stateId => null;
//
//   get countryId => null;
//
//   get companyWebsite => null;
//
//   get businessType => null;
//
//   get companyAddress => null;
//
//   get createdAt => null;
//
//   get updatedAt => null;
//
//   get quote => null;
//   get profession => null;
//
//   get id => null;
// }
//

import 'dart:convert';

List<DirectoryProfile2> directoryScreenModelFromJson(String responseBody) {
  final parsed = json.decode(responseBody);
  return List<DirectoryProfile2>.from(
    parsed["data"].map((x) => DirectoryProfile2.fromJson(x)),
  );
}

class DirectoryProfile2 {
  bool? isPioneerMember;
  String? id;
  String? membershipChapter;
  List<String>? membershipType;
  String? tribeInstitutionId;
  DateTime? dateOfJoining;
  String? rbChapterDesignationId;
  String? rbNationalDesignationId;
  DateTime? rbValidity;
  String? rbNumber;
  String? rppNumber;
  String? rppDesignationId;
  DateTime? rppValidity;
  String? name;
  String? gender;
  DateTime? dateOfBirth;
  String? bloodGroup;
  String? nationality;
  String? adharNo;
  String? maritalStatus;
  DateTime? anniversaryDate;
  String? profession;
  String? industry;
  String? nameOfBusiness;
  String? primaryContactNo;
  String? whatsappContactNo;
  String? emailId;
  String? cityId;
  String? residentialAddress;
  String? authorityLevel;
  List<String>? chapter;
  List<String>? centerandsubcenterIds;
  List<Authority>? authoritiesIds;
  String? aboutMember;
  String? profilePicture;
  String? platForm;
  int? listingNo;
  bool? deleteStatus;
  String? defaultStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  List<CenterAndSubcenter>? centerandsubcenters;
  List<Chapter>? chapters;
  List<Designation>? rbChapterDesignationArray;
  List<Designation>? rbNationalDesignationArray;
  List<Designation>? rppDesignationArray;
  List<dynamic>? membershipCenterArray;
  String? rbChapterDesignationName;
  String? rbNationalDesignationName;
  String? rppDesignationName;

  DirectoryProfile2({
    this.isPioneerMember,
    this.id,
    this.membershipChapter,
    this.membershipType,
    this.tribeInstitutionId,
    this.dateOfJoining,
    this.rbChapterDesignationId,
    this.rbNationalDesignationId,
    this.rbValidity,
    this.rbNumber,
    this.rppNumber,
    this.rppDesignationId,
    this.rppValidity,
    this.name,
    this.gender,
    this.dateOfBirth,
    this.bloodGroup,
    this.nationality,
    this.adharNo,
    this.maritalStatus,
    this.anniversaryDate,
    this.profession,
    this.industry,
    this.nameOfBusiness,
    this.primaryContactNo,
    this.whatsappContactNo,
    this.emailId,
    this.cityId,
    this.residentialAddress,
    this.authorityLevel,
    this.chapter,
    this.centerandsubcenterIds,
    this.authoritiesIds,
    this.aboutMember,
    this.profilePicture,
    this.platForm,
    this.listingNo,
    this.deleteStatus,
    this.defaultStatus,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.centerandsubcenters,
    this.chapters,
    this.rbChapterDesignationArray,
    this.rbNationalDesignationArray,
    this.rppDesignationArray,
    this.membershipCenterArray,
    this.rbChapterDesignationName,
    this.rbNationalDesignationName,
    this.rppDesignationName,
  });

  factory DirectoryProfile2.fromJson(Map<String, dynamic> json) {
    bool x = json['membershipType'].contains("PIONEER_PATRON_MEMBER");
    return DirectoryProfile2(
      isPioneerMember: x,
      id: json['_id'],
      membershipChapter: json['membershipChapter'],
      membershipType:
          json['membershipType'] != null
              ? List<String>.from(json['membershipType'])
              : null,
      tribeInstitutionId: json['tribeInstitutionId'],
      dateOfJoining:
          json['dateOfJoining'] != null
              ? DateTime.tryParse(json['dateOfJoining'])
              : null,
      rbChapterDesignationId: json['rbChapterDesignationId'],
      rbNationalDesignationId: json['rbNationalDesignationId'],
      rbValidity:
          json['rbValidity'] != null
              ? DateTime.tryParse(json['rbValidity'])
              : null,
      rbNumber: json['rbNumber'],
      rppNumber: json['rppNumber'],
      rppDesignationId: json['rppDesignationId'],
      rppValidity:
          json['rppValidity'] != null
              ? DateTime.tryParse(json['rppValidity'])
              : null,
      name: json['name'],
      gender: json['gender'],
      dateOfBirth:
          json['dateOfBirth'] != null
              ? DateTime.tryParse(json['dateOfBirth'])
              : null,
      bloodGroup: json['bloodGroup'],
      nationality: json['nationality'],
      adharNo: json['adharNo'],
      maritalStatus: json['maritalStatus'],
      anniversaryDate:
          json['anniversaryDate'] != null
              ? DateTime.tryParse(json['anniversaryDate'])
              : null,
      profession: json['profession'],
      industry: json['industry'],
      nameOfBusiness: json['nameOfBusiness'],
      primaryContactNo: json['primaryContactNo'],
      whatsappContactNo: json['whatsappContactNo'],
      emailId: json['emailId'],
      cityId: json['cityId'],
      residentialAddress: json['residentialAddress'],
      authorityLevel: json['authorityLevel'],
      chapter:
          json['chapter'] != null ? List<String>.from(json['chapter']) : null,
      centerandsubcenterIds:
          json['centerandsubcenterIds'] != null
              ? List<String>.from(json['centerandsubcenterIds'])
              : null,
      authoritiesIds:
          json['authoritiesIds'] != null
              ? (json['authoritiesIds'] as List)
                  .map((e) => Authority.fromJson(e))
                  .toList()
              : null,
      aboutMember: json['aboutMember'],
      profilePicture: json['profilePicture'],
      platForm: json['platForm'],
      listingNo: json['listingNo'],
      deleteStatus: json['deleteStatus'],
      defaultStatus: json['defaultStatus'],
      createdAt:
          json['createdAt'] != null
              ? DateTime.tryParse(json['createdAt'])
              : null,
      updatedAt:
          json['updatedAt'] != null
              ? DateTime.tryParse(json['updatedAt'])
              : null,
      v: json['__v'],
      centerandsubcenters:
          json['centerandsubcenters'] != null
              ? (json['centerandsubcenters'] as List)
                  .map((e) => CenterAndSubcenter.fromJson(e))
                  .toList()
              : null,
      chapters:
          json['chapters'] != null
              ? (json['chapters'] as List)
                  .map((e) => Chapter.fromJson(e))
                  .toList()
              : null,
      rbChapterDesignationArray:
          json['rbChapterDesignationArray'] != null
              ? (json['rbChapterDesignationArray'] as List)
                  .map((e) => Designation.fromJson(e))
                  .toList()
              : null,
      rbNationalDesignationArray:
          json['rbNationalDesignationArray'] != null
              ? (json['rbNationalDesignationArray'] as List)
                  .map((e) => Designation.fromJson(e))
                  .toList()
              : null,
      rppDesignationArray:
          json['rppDesignationArray'] != null
              ? (json['rppDesignationArray'] as List)
                  .map((e) => Designation.fromJson(e))
                  .toList()
              : null,
      membershipCenterArray: json['membershipCenterArray'],
      rbChapterDesignationName: json['rbChapterDesignationName'],
      rbNationalDesignationName: json['rbNationalDesignationName'],
      rppDesignationName: json['rppDesignationName'],
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'membershipChapter': membershipChapter,
    'membershipType': membershipType,
    'tribeInstitutionId': tribeInstitutionId,
    'dateOfJoining': dateOfJoining?.toIso8601String(),
    'rbChapterDesignationId': rbChapterDesignationId,
    'rbNationalDesignationId': rbNationalDesignationId,
    'rbValidity': rbValidity?.toIso8601String(),
    'rbNumber': rbNumber,
    'rppNumber': rppNumber,
    'rppDesignationId': rppDesignationId,
    'rppValidity': rppValidity?.toIso8601String(),
    'name': name,
    'gender': gender,
    'dateOfBirth': dateOfBirth?.toIso8601String(),
    'bloodGroup': bloodGroup,
    'nationality': nationality,
    'adharNo': adharNo,
    'maritalStatus': maritalStatus,
    'anniversaryDate': anniversaryDate?.toIso8601String(),
    'profession': profession,
    'industry': industry,
    'nameOfBusiness': nameOfBusiness,
    'primaryContactNo': primaryContactNo,
    'whatsappContactNo': whatsappContactNo,
    'emailId': emailId,
    'cityId': cityId,
    'residentialAddress': residentialAddress,
    'authorityLevel': authorityLevel,
    'chapter': chapter,
    'centerandsubcenterIds': centerandsubcenterIds,
    'authoritiesIds': authoritiesIds?.map((e) => e.toJson()).toList(),
    'aboutMember': aboutMember,
    'profilePicture': profilePicture,
    'platForm': platForm,
    'listingNo': listingNo,
    'deleteStatus': deleteStatus,
    'defaultStatus': defaultStatus,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    '__v': v,
    'centerandsubcenters': centerandsubcenters?.map((e) => e.toJson()).toList(),
    'chapters': chapters?.map((e) => e.toJson()).toList(),
    'rbChapterDesignationArray':
        rbChapterDesignationArray?.map((e) => e.toJson()).toList(),
    'rbNationalDesignationArray':
        rbNationalDesignationArray?.map((e) => e.toJson()).toList(),
    'rppDesignationArray': rppDesignationArray?.map((e) => e.toJson()).toList(),
    'membershipCenterArray': membershipCenterArray,
    'rbChapterDesignationName': rbChapterDesignationName,
    'rbNationalDesignationName': rbNationalDesignationName,
    'rppDesignationName': rppDesignationName,
  };
}

// Supporting classes (all fields nullable, with fromJson and toJson)

class Authority {
  String? id;
  String? name;
  bool? dashboardRights;
  bool? loginRights;
  StaffRights? staffRights;
  EnquiryRights? enquiryRights;
  bool? holidayCalendarRights;
  bool? clienteleRights;
  bool? postsRights;
  bool? bannerRights;
  GalleryRights? galleryRights;
  bool? testimonialRights;
  bool? feedbackRights;
  bool? subscriptionRights;
  bool? vendorRights;
  bool? dynamicMenuRights;
  bool? membershiptypeRights;
  bool? designationinassociationRights;
  bool? vendortypeRights;
  bool? emagazineRights;
  String? defaultStatus;
  int? listingNo;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  bool? chepterCenterRights;
  bool? cityRights;
  bool? institutionRights;
  bool? newsletterRights;
  bool? pollRights;

  Authority({
    this.id,
    this.name,
    this.dashboardRights,
    this.loginRights,
    this.staffRights,
    this.enquiryRights,
    this.holidayCalendarRights,
    this.clienteleRights,
    this.postsRights,
    this.bannerRights,
    this.galleryRights,
    this.testimonialRights,
    this.feedbackRights,
    this.subscriptionRights,
    this.vendorRights,
    this.dynamicMenuRights,
    this.membershiptypeRights,
    this.designationinassociationRights,
    this.vendortypeRights,
    this.emagazineRights,
    this.defaultStatus,
    this.listingNo,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.chepterCenterRights,
    this.cityRights,
    this.institutionRights,
    this.newsletterRights,
    this.pollRights,
  });

  factory Authority.fromJson(Map<String, dynamic> json) => Authority(
    id: json['_id'],
    name: json['name'],
    dashboardRights: json['dashboardRights'],
    loginRights: json['loginRights'],
    staffRights:
        json['staffRights'] != null
            ? StaffRights.fromJson(json['staffRights'])
            : null,
    enquiryRights:
        json['enquiryRights'] != null
            ? EnquiryRights.fromJson(json['enquiryRights'])
            : null,
    holidayCalendarRights: json['holidayCalendarRights'],
    clienteleRights: json['clienteleRights'],
    postsRights: json['postsRights'],
    bannerRights: json['bannerRights'],
    galleryRights:
        json['galleryRights'] != null
            ? GalleryRights.fromJson(json['galleryRights'])
            : null,
    testimonialRights: json['testimonialRights'],
    feedbackRights: json['feedbackRights'],
    subscriptionRights: json['subscriptionRights'],
    vendorRights: json['vendorRights'],
    dynamicMenuRights: json['dynamicMenuRights'],
    membershiptypeRights: json['membershiptypeRights'],
    designationinassociationRights: json['designationinassociationRights'],
    vendortypeRights: json['vendortypeRights'],
    emagazineRights: json['emagazineRights'],
    defaultStatus: json['defaultStatus'],
    listingNo: json['listingNo'],
    createdAt:
        json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
    updatedAt:
        json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null,
    v: json['__v'],
    chepterCenterRights: json['chepterCenterRights'],
    cityRights: json['cityRights'],
    institutionRights: json['institutionRights'],
    newsletterRights: json['newsletterRights'],
    pollRights: json['pollRights'],
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'dashboardRights': dashboardRights,
    'loginRights': loginRights,
    'staffRights': staffRights?.toJson(),
    'enquiryRights': enquiryRights?.toJson(),
    'holidayCalendarRights': holidayCalendarRights,
    'clienteleRights': clienteleRights,
    'postsRights': postsRights,
    'bannerRights': bannerRights,
    'galleryRights': galleryRights?.toJson(),
    'testimonialRights': testimonialRights,
    'feedbackRights': feedbackRights,
    'subscriptionRights': subscriptionRights,
    'vendorRights': vendorRights,
    'dynamicMenuRights': dynamicMenuRights,
    'membershiptypeRights': membershiptypeRights,
    'designationinassociationRights': designationinassociationRights,
    'vendortypeRights': vendortypeRights,
    'emagazineRights': emagazineRights,
    'defaultStatus': defaultStatus,
    'listingNo': listingNo,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    '__v': v,
    'chepterCenterRights': chepterCenterRights,
    'cityRights': cityRights,
    'institutionRights': institutionRights,
    'newsletterRights': newsletterRights,
    'pollRights': pollRights,
  };
}

class StaffRights {
  bool? staffManagementRights;
  bool? groupManagementRights;
  bool? designationRights;
  bool? designationManagementRights;
  String? id;

  StaffRights({
    this.staffManagementRights,
    this.groupManagementRights,
    this.designationRights,
    this.designationManagementRights,
    this.id,
  });

  factory StaffRights.fromJson(Map<String, dynamic> json) => StaffRights(
    staffManagementRights: json['staffManagementRights'],
    groupManagementRights: json['groupManagementRights'],
    designationRights: json['designationRights'],
    designationManagementRights: json['designationManagementRights'],
    id: json['_id'],
  );

  Map<String, dynamic> toJson() => {
    'staffManagementRights': staffManagementRights,
    'groupManagementRights': groupManagementRights,
    'designationRights': designationRights,
    'designationManagementRights': designationManagementRights,
    '_id': id,
  };
}

class EnquiryRights {
  bool? contactEnquiryRights;
  bool? membershipEnquiryRights;
  bool? sponsershipEnquiryRights;
  bool? vendorshipEnquiryRights;
  String? id;

  EnquiryRights({
    this.contactEnquiryRights,
    this.membershipEnquiryRights,
    this.sponsershipEnquiryRights,
    this.vendorshipEnquiryRights,
    this.id,
  });

  factory EnquiryRights.fromJson(Map<String, dynamic> json) => EnquiryRights(
    contactEnquiryRights: json['contactEnquiryRights'],
    membershipEnquiryRights: json['membershipEnquiryRights'],
    sponsershipEnquiryRights: json['sponsershipEnquiryRights'],
    vendorshipEnquiryRights: json['vendorshipEnquiryRights'],
    id: json['_id'],
  );

  Map<String, dynamic> toJson() => {
    'contactEnquiryRights': contactEnquiryRights,
    'membershipEnquiryRights': membershipEnquiryRights,
    'sponsershipEnquiryRights': sponsershipEnquiryRights,
    'vendorshipEnquiryRights': vendorshipEnquiryRights,
    '_id': id,
  };
}

class GalleryRights {
  bool? imagesRights;
  bool? videosRights;
  String? id;

  GalleryRights({this.imagesRights, this.videosRights, this.id});

  factory GalleryRights.fromJson(Map<String, dynamic> json) => GalleryRights(
    imagesRights: json['imagesRights'],
    videosRights: json['videosRights'],
    id: json['_id'],
  );

  Map<String, dynamic> toJson() => {
    'imagesRights': imagesRights,
    'videosRights': videosRights,
    '_id': id,
  };
}

class CenterAndSubcenter {
  String? id;
  String? name;
  String? logo;
  String? cityId;
  String? type;
  String? createdById;
  String? defaultStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  CenterAndSubcenter({
    this.id,
    this.name,
    this.logo,
    this.cityId,
    this.type,
    this.createdById,
    this.defaultStatus,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory CenterAndSubcenter.fromJson(
    Map<String, dynamic> json,
  ) => CenterAndSubcenter(
    id: json['_id'],
    name: json['name'],
    logo: json['logo'],
    cityId: json['cityId'],
    type: json['type'],
    createdById: json['createdById'],
    defaultStatus: json['defaultStatus'],
    createdAt:
        json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
    updatedAt:
        json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null,
    v: json['__v'],
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'logo': logo,
    'cityId': cityId,
    'type': type,
    'createdById': createdById,
    'defaultStatus': defaultStatus,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    '__v': v,
  };
}

class Chapter {
  String? id;
  String? name;
  String? logo;
  String? cityId;
  String? type;
  String? createdById;
  String? defaultStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Chapter({
    this.id,
    this.name,
    this.logo,
    this.cityId,
    this.type,
    this.createdById,
    this.defaultStatus,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
    id: json['_id'],
    name: json['name'],
    logo: json['logo'],
    cityId: json['cityId'],
    type: json['type'],
    createdById: json['createdById'],
    defaultStatus: json['defaultStatus'],
    createdAt:
        json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
    updatedAt:
        json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null,
    v: json['__v'],
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'logo': logo,
    'cityId': cityId,
    'type': type,
    'createdById': createdById,
    'defaultStatus': defaultStatus,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    '__v': v,
  };
}

class Designation {
  String? id;
  String? name;
  String? type;
  String? defaultStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Designation({
    this.id,
    this.name,
    this.type,
    this.defaultStatus,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Designation.fromJson(Map<String, dynamic> json) => Designation(
    id: json['_id'],
    name: json['name'],
    type: json['type'],
    defaultStatus: json['defaultStatus'],
    createdAt:
        json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
    updatedAt:
        json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null,
    v: json['__v'],
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'type': type,
    'defaultStatus': defaultStatus,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    '__v': v,
  };
}
