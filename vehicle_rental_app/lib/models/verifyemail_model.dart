class VerifyEmailModel {
  VerifyEmailModel({required this.message, required this.info});

  final String? message;
  final Info? info;

  factory VerifyEmailModel.fromJson(Map<String, dynamic> json) {
    return VerifyEmailModel(
      message: json["message"],
      info: json["info"] == null ? null : Info.fromJson(json["info"]),
    );
  }

  Map<String, dynamic> toJson() => {"message": message, "info": info?.toJson()};
}

class Info {
  Info({required this.isVerified, required this.email});

  final int? isVerified;
  final String? email;

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(isVerified: json["isVerified"], email: json["email"]);
  }

  Map<String, dynamic> toJson() => {"isVerified": isVerified, "email": email};
}
