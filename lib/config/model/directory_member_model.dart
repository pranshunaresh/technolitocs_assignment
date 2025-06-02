// directory_member_model.dart

class DirectoryMemberModel {
  bool status;
  int code;
  String message;
  Data data;

  DirectoryMemberModel({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });

  factory DirectoryMemberModel.fromJson(Map<String, dynamic> json) =>
      DirectoryMemberModel(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  String id;
  String membershipChapter;
  List<String> membershipType;
  dynamic tribeInstitutionId;
  DateTime dateOfJoining;
  String rbChapterDesignationId;
  String rbNationalDesignationId;
  DateTime rbValidity;
  String rbNumber;
  String rppNumber;
  String rppDesignationId;
  DateTime rppValidity;
  String name;
  String gender;
  DateTime dateOfBirth;
  String bloodGroup;
  String nationality;
  String adharNo;
  String maritalStatus;
  DateTime anniversaryDate;
  String profession;
  String industry;
  String nameOfBusiness;
  String primaryContactNo;
  String whatsappContactNo;
  String emailId;
  String cityId;
  String residentialAddress;
  String authorityLevel;
  List<String> chapter;
  List<String> centerandsubcenterIds;
  List<AuthoritiesId> authoritiesIds;
  String password;
  String aboutMember;
  String profilePicture;
  String platForm;
  int listingNo;
  bool deleteStatus;
  String defaultStatus;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Data({
    required this.id,
    required this.membershipChapter,
    required this.membershipType,
    required this.tribeInstitutionId,
    required this.dateOfJoining,
    required this.rbChapterDesignationId,
    required this.rbNationalDesignationId,
    required this.rbValidity,
    required this.rbNumber,
    required this.rppNumber,
    required this.rppDesignationId,
    required this.rppValidity,
    required this.name,
    required this.gender,
    required this.dateOfBirth,
    required this.bloodGroup,
    required this.nationality,
    required this.adharNo,
    required this.maritalStatus,
    required this.anniversaryDate,
    required this.profession,
    required this.industry,
    required this.nameOfBusiness,
    required this.primaryContactNo,
    required this.whatsappContactNo,
    required this.emailId,
    required this.cityId,
    required this.residentialAddress,
    required this.authorityLevel,
    required this.chapter,
    required this.centerandsubcenterIds,
    required this.authoritiesIds,
    required this.password,
    required this.aboutMember,
    required this.profilePicture,
    required this.platForm,
    required this.listingNo,
    required this.deleteStatus,
    required this.defaultStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    membershipChapter: json["membershipChapter"],
    membershipType: List<String>.from(json["membershipType"]),
    tribeInstitutionId: json["tribeInstitutionId"],
    dateOfJoining: DateTime.parse(json["dateOfJoining"]),
    rbChapterDesignationId: json["rbChapterDesignationId"],
    rbNationalDesignationId: json["rbNationalDesignationId"],
    rbValidity: DateTime.parse(json["rbValidity"]),
    rbNumber: json["rbNumber"],
    rppNumber: json["rppNumber"],
    rppDesignationId: json["rppDesignationId"],
    rppValidity: DateTime.parse(json["rppValidity"]),
    name: json["name"],
    gender: json["gender"],
    dateOfBirth: DateTime.parse(json["dateOfBirth"]),
    bloodGroup: json["bloodGroup"],
    nationality: json["nationality"],
    adharNo: json["adharNo"],
    maritalStatus: json["maritalStatus"],
    anniversaryDate: DateTime.parse(json["anniversaryDate"]),
    profession: json["profession"],
    industry: json["industry"],
    nameOfBusiness: json["nameOfBusiness"],
    primaryContactNo: json["primaryContactNo"],
    whatsappContactNo: json["whatsappContactNo"],
    emailId: json["emailId"],
    cityId: json["cityId"],
    residentialAddress: json["residentialAddress"],
    authorityLevel: json["authorityLevel"],
    chapter: List<String>.from(json["chapter"]),
    centerandsubcenterIds: List<String>.from(json["centerandsubcenterIds"]),
    authoritiesIds: List<AuthoritiesId>.from(
      json["authoritiesIds"].map((x) => AuthoritiesId.fromJson(x)),
    ),
    password: json["password"],
    aboutMember: json["aboutMember"],
    profilePicture: json["profilePicture"],
    platForm: json["platForm"],
    listingNo: json["listingNo"],
    deleteStatus: json["deleteStatus"],
    defaultStatus: json["defaultStatus"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );
}

class AuthoritiesId {
  String id;
  String name;
  bool dashboardRights;
  bool loginRights;
  StaffRights staffRights;
  EnquiryRights enquiryRights;
  bool holidayCalendarRights;
  bool clienteleRights;
  bool postsRights;
  bool bannerRights;
  GalleryRights galleryRights;
  bool testimonialRights;
  bool feedbackRights;
  bool subscriptionRights;
  bool vendorRights;
  bool dynamicMenuRights;
  bool membershiptypeRights;
  bool designationinassociationRights;
  bool vendortypeRights;
  bool emagazineRights;
  String defaultStatus;
  int listingNo;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  bool chepterCenterRights;
  bool cityRights;
  bool institutionRights;
  bool newsletterRights;
  bool pollRights;

  AuthoritiesId({
    required this.id,
    required this.name,
    required this.dashboardRights,
    required this.loginRights,
    required this.staffRights,
    required this.enquiryRights,
    required this.holidayCalendarRights,
    required this.clienteleRights,
    required this.postsRights,
    required this.bannerRights,
    required this.galleryRights,
    required this.testimonialRights,
    required this.feedbackRights,
    required this.subscriptionRights,
    required this.vendorRights,
    required this.dynamicMenuRights,
    required this.membershiptypeRights,
    required this.designationinassociationRights,
    required this.vendortypeRights,
    required this.emagazineRights,
    required this.defaultStatus,
    required this.listingNo,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.chepterCenterRights,
    required this.cityRights,
    required this.institutionRights,
    required this.newsletterRights,
    required this.pollRights,
  });

  factory AuthoritiesId.fromJson(Map<String, dynamic> json) => AuthoritiesId(
    id: json["_id"],
    name: json["name"],
    dashboardRights: json["dashboardRights"],
    loginRights: json["loginRights"],
    staffRights: StaffRights.fromJson(json["staffRights"]),
    enquiryRights: EnquiryRights.fromJson(json["enquiryRights"]),
    holidayCalendarRights: json["holidayCalendarRights"],
    clienteleRights: json["clienteleRights"],
    postsRights: json["postsRights"],
    bannerRights: json["bannerRights"],
    galleryRights: GalleryRights.fromJson(json["galleryRights"]),
    testimonialRights: json["testimonialRights"],
    feedbackRights: json["feedbackRights"],
    subscriptionRights: json["subscriptionRights"],
    vendorRights: json["vendorRights"],
    dynamicMenuRights: json["dynamicMenuRights"],
    membershiptypeRights: json["membershiptypeRights"],
    designationinassociationRights: json["designationinassociationRights"],
    vendortypeRights: json["vendortypeRights"],
    emagazineRights: json["emagazineRights"],
    defaultStatus: json["defaultStatus"],
    listingNo: json["listingNo"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    chepterCenterRights: json["chepterCenterRights"],
    cityRights: json["cityRights"],
    institutionRights: json["institutionRights"],
    newsletterRights: json["newsletterRights"],
    pollRights: json["pollRights"],
  );

  Map<String, dynamic> toJson() => {
    // Add JSON mapping logic here as needed
  };
}

class StaffRights {
  bool staffManagementRights;
  bool groupManagementRights;
  bool designationRights;
  bool designationManagementRights;
  String id;

  StaffRights({
    required this.staffManagementRights,
    required this.groupManagementRights,
    required this.designationRights,
    required this.designationManagementRights,
    required this.id,
  });

  factory StaffRights.fromJson(Map<String, dynamic> json) => StaffRights(
    staffManagementRights: json["staffManagementRights"],
    groupManagementRights: json["groupManagementRights"],
    designationRights: json["designationRights"],
    designationManagementRights: json["designationManagementRights"],
    id: json["_id"],
  );
}

class EnquiryRights {
  bool contactEnquiryRights;
  bool membershipEnquiryRights;
  bool sponsershipEnquiryRights;
  bool vendorshipEnquiryRights;
  String id;

  EnquiryRights({
    required this.contactEnquiryRights,
    required this.membershipEnquiryRights,
    required this.sponsershipEnquiryRights,
    required this.vendorshipEnquiryRights,
    required this.id,
  });

  factory EnquiryRights.fromJson(Map<String, dynamic> json) => EnquiryRights(
    contactEnquiryRights: json["contactEnquiryRights"],
    membershipEnquiryRights: json["membershipEnquiryRights"],
    sponsershipEnquiryRights: json["sponsershipEnquiryRights"],
    vendorshipEnquiryRights: json["vendorshipEnquiryRights"],
    id: json["_id"],
  );
}

class GalleryRights {
  bool imagesRights;
  bool videosRights;
  String id;

  GalleryRights({
    required this.imagesRights,
    required this.videosRights,
    required this.id,
  });

  factory GalleryRights.fromJson(Map<String, dynamic> json) => GalleryRights(
    imagesRights: json["imagesRights"],
    videosRights: json["videosRights"],
    id: json["_id"],
  );
}
