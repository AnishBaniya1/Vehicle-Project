class AllBookingsModel {
  AllBookingsModel({
    required this.success,
    required this.totalvehicles,
    required this.totalBookings,
    required this.data,
  });

  final bool? success;
  final int? totalvehicles;
  final int? totalBookings;
  final List<Datum> data;

  factory AllBookingsModel.fromJson(Map<String, dynamic> json) {
    return AllBookingsModel(
      success: json["success"],
      totalvehicles: json["totalvehicles"],
      totalBookings: json["totalBookings"],
      data: json["data"] == null
          ? []
          : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "totalvehicles": totalvehicles,
    "totalBookings": totalBookings,
    "data": data.map((x) => x?.toJson()).toList(),
  };
}

class Datum {
  Datum({required this.car, required this.bookings});

  final Car? car;
  final List<BookingElement> bookings;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      car: json["car"] == null ? null : Car.fromJson(json["car"]),
      bookings: json["bookings"] == null
          ? []
          : List<BookingElement>.from(
              json["bookings"]!.map((x) => BookingElement.fromJson(x)),
            ),
    );
  }

  Map<String, dynamic> toJson() => {
    "car": car?.toJson(),
    "bookings": bookings.map((x) => x?.toJson()).toList(),
  };
}

class BookingElement {
  BookingElement({required this.booking, required this.user});

  final BookingBooking? booking;
  final User? user;

  factory BookingElement.fromJson(Map<String, dynamic> json) {
    return BookingElement(
      booking: json["booking"] == null
          ? null
          : BookingBooking.fromJson(json["booking"]),
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "booking": booking?.toJson(),
    "user": user?.toJson(),
  };
}

class BookingBooking {
  BookingBooking({
    required this.id,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
  });

  final int? id;
  final String? status;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? createdAt;

  factory BookingBooking.fromJson(Map<String, dynamic> json) {
    return BookingBooking(
      id: json["id"],
      status: json["status"],
      startDate: DateTime.tryParse(json["startDate"] ?? ""),
      endDate: DateTime.tryParse(json["endDate"] ?? ""),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "startDate": startDate?.toIso8601String(),
    "endDate": endDate?.toIso8601String(),
    "createdAt": createdAt?.toIso8601String(),
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

class Car {
  Car({
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

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
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
