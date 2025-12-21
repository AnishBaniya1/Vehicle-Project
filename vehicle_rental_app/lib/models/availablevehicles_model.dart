class AvailableVehicleModel {
  AvailableVehicleModel({
    required this.success,
    required this.count,
    required this.data,
  });

  final bool? success;
  final int? count;
  final List<Datum> data;

  factory AvailableVehicleModel.fromJson(Map<String, dynamic> json) {
    return AvailableVehicleModel(
      success: json["success"],
      count: json["count"],
      data: json["data"] == null
          ? []
          : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "count": count,
    "data": data.map((x) => x?.toJson()).toList(),
  };
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.brand,
    required this.type,
    required this.fuelType,
    required this.seats,
    required this.pricePerDay,
    required this.status,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? name;
  final String? brand;
  final String? type;
  final String? fuelType;
  final int? seats;
  final int? pricePerDay;
  final String? status;
  final List<String> imageUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json["id"],
      name: json["name"],
      brand: json["brand"],
      type: json["type"],
      fuelType: json["fuelType"],
      seats: json["seats"],
      pricePerDay: json["pricePerDay"],
      status: json["status"],
      imageUrl: json["imageUrl"] == null
          ? []
          : List<String>.from(json["imageUrl"]!.map((x) => x)),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "brand": brand,
    "type": type,
    "fuelType": fuelType,
    "seats": seats,
    "pricePerDay": pricePerDay,
    "status": status,
    "imageUrl": imageUrl.map((x) => x).toList(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
