class GetAllUsersModel {
  GetAllUsersModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory GetAllUsersModel.fromJson(Map<String, dynamic> json) {
    return GetAllUsersModel(
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
  Data({required this.users});

  final List<User> users;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      users: json["users"] == null
          ? []
          : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "users": users.map((x) => x?.toJson()).toList(),
  };
}

class User {
  User({
    required this.id,
    required this.email,
    required this.role,
    required this.createdAt,
  });

  final String? id;
  final String? email;
  final String? role;
  final DateTime? createdAt;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      email: json["email"],
      role: json["role"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "role": role,
    "createdAt": createdAt?.toIso8601String(),
  };
}
