class BookvehicleModel {
  BookvehicleModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory BookvehicleModel.fromJson(Map<String, dynamic> json) {
    return BookvehicleModel(
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
    required this.vehicleId,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.totalPrice,
  });

  final String? vehicleId;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? status;
  final int? totalPrice;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      vehicleId: json["vehicleId"],
      startDate: DateTime.tryParse(json["startDate"] ?? ""),
      endDate: DateTime.tryParse(json["endDate"] ?? ""),
      status: json["status"],
      totalPrice: json["totalPrice"],
    );
  }

  Map<String, dynamic> toJson() => {
    "vehicleId": vehicleId,
    "startDate": startDate?.toIso8601String(),
    "endDate": endDate?.toIso8601String(),
    "status": status,
    "totalPrice": totalPrice,
  };
}
