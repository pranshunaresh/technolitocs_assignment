import 'directory_member_model.dart';

class DirectoryMemberProfileModel {
  bool status;
  int code;
  String message;
  Data data;

  DirectoryMemberProfileModel({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });

  factory DirectoryMemberProfileModel.fromJson(Map<String, dynamic> json) {
    return DirectoryMemberProfileModel(
      status: json['status'],
      code: json['code'],
      message: json['message'],
      data: Data.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'code': code,
    'message': message,
    'data': data.toJson(),
  };
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
  dynamic anniversaryDate;
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
  String aboutMember;
  String profilePicture;
  String platForm;
  int listingNo;
  bool deleteStatus;
  String defaultStatus;
  List<UserStatusTimeline> userStatusTimeline;
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
    required this.aboutMember,
    required this.profilePicture,
    required this.platForm,
    required this.listingNo,
    required this.deleteStatus,
    required this.defaultStatus,
    required this.userStatusTimeline,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['_id'],
      membershipChapter: json['membershipChapter'],
      membershipType: List<String>.from(json['membershipType']),
      tribeInstitutionId: json['tribeInstitutionId'],
      dateOfJoining: DateTime.parse(json['dateOfJoining']),
      rbChapterDesignationId: json['rbChapterDesignationId'],
      rbNationalDesignationId: json['rbNationalDesignationId'],
      rbValidity: DateTime.parse(json['rbValidity']),
      rbNumber: json['rbNumber'],
      rppNumber: json['rppNumber'],
      rppDesignationId: json['rppDesignationId'],
      rppValidity: DateTime.parse(json['rppValidity']),
      name: json['name'],
      gender: json['gender'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      bloodGroup: json['bloodGroup'],
      nationality: json['nationality'],
      adharNo: json['adharNo'],
      maritalStatus: json['maritalStatus'],
      anniversaryDate: json['anniversaryDate'],
      profession: json['profession'],
      industry: json['industry'],
      nameOfBusiness: json['nameOfBusiness'],
      primaryContactNo: json['primaryContactNo'],
      whatsappContactNo: json['whatsappContactNo'],
      emailId: json['emailId'],
      cityId: json['cityId'],
      residentialAddress: json['residentialAddress'],
      authorityLevel: json['authorityLevel'],
      chapter: List<String>.from(json['chapter']),
      centerandsubcenterIds: List<String>.from(json['centerandsubcenterIds']),
      authoritiesIds:
          (json['authoritiesIds'] as List)
              .map((e) => AuthoritiesId.fromJson(e))
              .toList(),
      aboutMember: json['aboutMember'],
      profilePicture: json['profilePicture'],
      platForm: json['platForm'],
      listingNo: json['listingNo'],
      deleteStatus: json['deleteStatus'],
      defaultStatus: json['defaultStatus'],
      userStatusTimeline:
          (json['userStatusTimeline'] as List)
              .map((e) => UserStatusTimeline.fromJson(e))
              .toList(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'membershipChapter': membershipChapter,
    'membershipType': membershipType,
    'tribeInstitutionId': tribeInstitutionId,
    'dateOfJoining': dateOfJoining.toIso8601String(),
    'rbChapterDesignationId': rbChapterDesignationId,
    'rbNationalDesignationId': rbNationalDesignationId,
    'rbValidity': rbValidity.toIso8601String(),
    'rbNumber': rbNumber,
    'rppNumber': rppNumber,
    'rppDesignationId': rppDesignationId,
    'rppValidity': rppValidity.toIso8601String(),
    'name': name,
    'gender': gender,
    'dateOfBirth': dateOfBirth.toIso8601String(),
    'bloodGroup': bloodGroup,
    'nationality': nationality,
    'adharNo': adharNo,
    'maritalStatus': maritalStatus,
    'anniversaryDate': anniversaryDate,
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
    'authoritiesIds': authoritiesIds.map((e) => e.toJson()).toList(),
    'aboutMember': aboutMember,
    'profilePicture': profilePicture,
    'platForm': platForm,
    'listingNo': listingNo,
    'deleteStatus': deleteStatus,
    'defaultStatus': defaultStatus,
    'userStatusTimeline': userStatusTimeline.map((e) => e.toJson()).toList(),
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    '__v': v,
  };
}

class AuthoritiesId {
  String id;
  String name;
  String description;
  String authorityLevel;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  AuthoritiesId({
    required this.id,
    required this.name,
    required this.description,
    required this.authorityLevel,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory AuthoritiesId.fromJson(Map<String, dynamic> json) {
    return AuthoritiesId(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      authorityLevel: json['authorityLevel'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'description': description,
    'authorityLevel': authorityLevel,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    '__v': v,
  };
}

class UserStatusTimeline {
  String status;
  String updatedBy;
  DateTime timestamp;

  UserStatusTimeline({
    required this.status,
    required this.updatedBy,
    required this.timestamp,
  });

  factory UserStatusTimeline.fromJson(Map<String, dynamic> json) {
    return UserStatusTimeline(
      status: json['status'],
      updatedBy: json['updatedBy'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'updatedBy': updatedBy,
    'timestamp': timestamp.toIso8601String(),
  };
}
