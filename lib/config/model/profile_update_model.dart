class ProfileUpdateModel {
  String fullName;
  String dateOfBirth;
  String bloodGroup;
  String bio;
  String rolbolChapterDesignationName;
  String profession;
  String businessName;
  String rppDesignationName;
  String primaryContactNumber;
  String whatsappContactNumber;
  String emailId;
  String formalAddress;

  ProfileUpdateModel({
    required this.fullName,
    required this.dateOfBirth,
    required this.bloodGroup,
    required this.bio,
    required this.rolbolChapterDesignationName,
    required this.profession,
    required this.businessName,
    required this.rppDesignationName,
    required this.primaryContactNumber,
    required this.whatsappContactNumber,
    required this.emailId,
    required this.formalAddress,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'dateOfBirth': dateOfBirth,
      'bloodGroup': bloodGroup,
      'bio': bio,
      'rolbolChapterDesignationName': rolbolChapterDesignationName,
      'profession': profession,
      'businessName': businessName,
      'rppDesignationName': rppDesignationName,
      'primaryContactNumber': primaryContactNumber,
      'whatsappContactNumber': whatsappContactNumber,
      'emailId': emailId,
      'formalAddress': formalAddress,
    };
  }
}
