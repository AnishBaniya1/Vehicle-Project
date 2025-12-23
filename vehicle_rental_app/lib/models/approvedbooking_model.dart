class ApprovedBookingModel {
  ApprovedBookingModel({
    required this.success,
    required this.totalApprovedBookings,
    required this.data,
  });

  final bool? success;
  final int? totalApprovedBookings;
  final List<Datum> data;

  factory ApprovedBookingModel.fromJson(Map<String, dynamic> json) {
    return ApprovedBookingModel(
      success: json["success"],
      totalApprovedBookings: json["totalApprovedBookings"],
      data: json["data"] == null
          ? []
          : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "totalApprovedBookings": totalApprovedBookings,
    "data": data.map((x) => x?.toJson()).toList(),
  };
}

class Datum {
  Datum({required this.booking, required this.user, required this.vehicle});

  final Booking? booking;
  final User? user;
  final Vehicle? vehicle;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      booking: json["booking"] == null
          ? null
          : Booking.fromJson(json["booking"]),
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      vehicle: json["vehicle"] == null
          ? null
          : Vehicle.fromJson(json["vehicle"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "booking": booking?.toJson(),
    "user": user?.toJson(),
    "vehicle": vehicle?.toJson(),
  };
}

class Booking {
  Booking({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.bookedAt,
  });

  final int? id;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? bookedAt;

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json["id"],
      startDate: DateTime.tryParse(json["startDate"] ?? ""),
      endDate: DateTime.tryParse(json["endDate"] ?? ""),
      bookedAt: DateTime.tryParse(json["bookedAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "startDate": startDate?.toIso8601String(),
    "endDate": endDate?.toIso8601String(),
    "bookedAt": bookedAt?.toIso8601String(),
  };
}

class User {
  User({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
  });

  final String? id;
  final String? username;
  final String? email;
  final dynamic phone;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      username: json["username"],
      email: json["email"],
      phone: json["phone"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "phone": phone,
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
