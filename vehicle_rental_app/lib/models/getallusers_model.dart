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
  Data({required this.users, required this.pagination});

  final List<User> users;
  final Pagination? pagination;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      users: json["users"] == null
          ? []
          : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
      pagination: json["pagination"] == null
          ? null
          : Pagination.fromJson(json["pagination"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "users": users.map((x) => x?.toJson()).toList(),
    "pagination": pagination?.toJson(),
  };
}

class Pagination {
  Pagination({
    required this.total,
    required this.page,
    required this.pageSize,
    required this.totalPages,
  });

  final int? total;
  final int? page;
  final int? pageSize;
  final int? totalPages;

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      total: json["total"],
      page: json["page"],
      pageSize: json["pageSize"],
      totalPages: json["totalPages"],
    );
  }

  Map<String, dynamic> toJson() => {
    "total": total,
    "page": page,
    "pageSize": pageSize,
    "totalPages": totalPages,
  };
}

class User {
  User({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
    required this.createdAt,
  });

  final String? id;
  final String? username;
  final String? email;
  final String? role;
  final DateTime? createdAt;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      username: json["username"],
      email: json["email"],
      role: json["role"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "role": role,
    "createdAt": createdAt?.toIso8601String(),
  };
}
