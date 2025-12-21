class UserBookingHistoryModel {
  UserBookingHistoryModel({
    required this.success,
    required this.totalBookings,
    required this.data,
  });

  final bool? success;
  final int? totalBookings;
  final List<Datum> data;

  factory UserBookingHistoryModel.fromJson(Map<String, dynamic> json) {
    return UserBookingHistoryModel(
      success: json["success"],
      totalBookings: json["totalBookings"],
      data: json["data"] == null
          ? []
          : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "totalBookings": totalBookings,
    "data": data.map((x) => x?.toJson()).toList(),
  };
}

class Datum {
  Datum({required this.booking, required this.vehicle});

  final Booking? booking;
  final Vehicle? vehicle;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      booking: json["booking"] == null
          ? null
          : Booking.fromJson(json["booking"]),
      vehicle: json["vehicle"] == null
          ? null
          : Vehicle.fromJson(json["vehicle"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "booking": booking?.toJson(),
    "vehicle": vehicle?.toJson(),
  };
}

class Booking {
  Booking({
    required this.id,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.totalPrice,
  });

  final int? id;
  final String? status;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? createdAt;
  final int? totalPrice;

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json["id"],
      status: json["status"],
      startDate: DateTime.tryParse(json["startDate"] ?? ""),
      endDate: DateTime.tryParse(json["endDate"] ?? ""),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      totalPrice: json["totalPrice"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "startDate": startDate?.toIso8601String(),
    "endDate": endDate?.toIso8601String(),
    "createdAt": createdAt?.toIso8601String(),
    "totalPrice": totalPrice,
  };
}

class Vehicle {
  Vehicle({
    required this.id,
    required this.name,
    required this.brand,
    required this.type,
    required this.fuelType,
    required this.seats,
    required this.pricePerDay,
    required this.images,
  });

  final String? id;
  final String? name;
  final String? brand;
  final String? type;
  final String? fuelType;
  final int? seats;
  final int? pricePerDay;
  final List<String> images;

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json["id"],
      name: json["name"],
      brand: json["brand"],
      type: json["type"],
      fuelType: json["fuelType"],
      seats: json["seats"],
      pricePerDay: json["pricePerDay"],
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
    "images": images.map((x) => x).toList(),
  };
}
