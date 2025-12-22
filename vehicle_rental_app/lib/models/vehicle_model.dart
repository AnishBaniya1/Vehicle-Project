class VehicleModel {
  VehicleModel({
    required this.success,
    required this.message,
    required this.pagination,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Pagination? pagination;
  final List<Datum> data;

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      success: json["success"],
      message: json["message"],
      pagination: json["pagination"] == null
          ? null
          : Pagination.fromJson(json["pagination"]),
      data: json["data"] == null
          ? []
          : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "pagination": pagination?.toJson(),
    "data": data.map((x) => x.toJson()).toList(),
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
    required this.images,
  });

  final String? id;
  final String? name;
  final String? brand;
  final String? type;
  final String? fuelType;
  final int? seats;
  final int? pricePerDay;
  final String? status;
  final String? imageUrl;
  final DateTime? createdAt;
  final List<String> images;

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
      imageUrl: json["imageUrl"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      images: json["images"] == null
          ? []
          : List<String>.from(json["images"]!.map((x) => x)),
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
    "imageUrl": imageUrl,
    "createdAt": createdAt?.toIso8601String(),
    "images": images.map((x) => x).toList(),
  };
}

class Pagination {
  Pagination({
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  final int? total;
  final int? page;
  final int? limit;
  final int? totalPages;

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      total: json["total"],
      page: json["page"],
      limit: json["limit"],
      totalPages: json["totalPages"],
    );
  }

  Map<String, dynamic> toJson() => {
    "total": total,
    "page": page,
    "limit": limit,
    "totalPages": totalPages,
  };
}
