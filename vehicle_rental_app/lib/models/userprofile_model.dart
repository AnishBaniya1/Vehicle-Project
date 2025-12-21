class UserProfileModel {
  UserProfileModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  Data({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
    required this.isVerified,
    required this.role,
    required this.createdAt,
  });

  final String? id;
  final String? username;
  final String? email;
  final dynamic phone;
  final int? isVerified;
  final String? role;
  final DateTime? createdAt;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json["id"],
      username: json["username"],
      email: json["email"],
      phone: json["phone"],
      isVerified: json["isVerified"],
      role: json["role"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "phone": phone,
    "isVerified": isVerified,
    "role": role,
    "createdAt": createdAt?.toIso8601String(),
  };
}
