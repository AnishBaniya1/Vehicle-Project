class LoginResponseModel {
  LoginResponseModel({
    required this.message,
    required this.token,
    required this.user,
  });

  final String? message;
  final String? token;
  final User? user;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      message: json["message"],
      token: json["token"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "message": message,
    "token": token,
    "user": user?.toJson(),
  };
}

class User {
  User({required this.id, required this.email, required this.role});

  final String? id;
  final String? email;
  final String? role;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json["id"], email: json["email"], role: json["role"]);
  }

  Map<String, dynamic> toJson() => {"id": id, "email": email, "role": role};
}
