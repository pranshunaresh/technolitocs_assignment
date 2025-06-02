class PictureUpdateModel {
  final bool status;
  final int code;
  final String message;
  final String data; // This is the filename of the updated profile picture

  PictureUpdateModel({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });

  factory PictureUpdateModel.fromJson(Map<String, dynamic> json) {
    return PictureUpdateModel(
      status: json['status'] ?? false,
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'code': code, 'message': message, 'data': data};
  }
}
