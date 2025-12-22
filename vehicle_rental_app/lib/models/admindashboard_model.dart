class AdminDashboardModel {
  AdminDashboardModel({required this.success, required this.data});

  final bool? success;
  final Data? data;

  factory AdminDashboardModel.fromJson(Map<String, dynamic> json) {
    return AdminDashboardModel(
      success: json["success"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {"success": success, "data": data?.toJson()};
}

class Data {
  Data({
    required this.users,
    required this.vehicles,
    required this.pendingBookings,
    required this.confirmedBookings,
    required this.totalRevenue,
  });

  final int? users;
  final int? vehicles;
  final int? pendingBookings;
  final int? confirmedBookings;
  final int? totalRevenue;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      users: json["users"],
      vehicles: json["vehicles"],
      pendingBookings: json["pendingBookings"],
      confirmedBookings: json["confirmedBookings"],
      totalRevenue: json["totalRevenue"],
    );
  }

  Map<String, dynamic> toJson() => {
    "users": users,
    "vehicles": vehicles,
    "pendingBookings": pendingBookings,
    "confirmedBookings": confirmedBookings,
    "totalRevenue": totalRevenue,
  };
}
