import 'dart:convert';

class DirectoryProfile {
  final String name;
  final String profilePicture;
  final String defaultStatus;
  final String? rbNationalDesignationId;
  final String? rbChapterDesignationId;
  final String? cityId;
  final bool isPioneerMember;

  var companyName;

  DirectoryProfile({
    required this.name,
    required this.profilePicture,
    required this.defaultStatus,
    this.rbNationalDesignationId,
    this.rbChapterDesignationId,
    this.cityId,
    required this.isPioneerMember,
  });

  factory DirectoryProfile.fromJson(Map<String, dynamic> json) {
    bool x = json['membershipType'].contains("PIONEER_PATRON_MEMBER");

    return DirectoryProfile(
      name: json['name'] ?? '',
      profilePicture: json['profilePicture'] ?? '',
      defaultStatus: json['defaultStatus'] ?? '',
      rbNationalDesignationId: json['rbNationalDesignationId'],
      rbChapterDesignationId: json['rbChapterDesignationId'],
      cityId: json['cityId'],
      isPioneerMember: x,
    );
  }

  get email => null;

  get phone => null;

  get stateId => null;

  get countryId => null;

  get companyWebsite => null;

  get businessType => null;

  get companyAddress => null;

  get createdAt => null;

  get updatedAt => null;

  get quote => null;
  get profession => null;

  get id => null;
}

List<DirectoryProfile> directoryScreenModelFromJson(String responseBody) {
  final parsed = json.decode(responseBody);
  return List<DirectoryProfile>.from(
    parsed["data"].map((x) => DirectoryProfile.fromJson(x)),
  );
}
