import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:vehicle_rental_app/core/services/vehicle_service.dart';
import 'package:vehicle_rental_app/models/availablevehicles_model.dart';
import 'package:vehicle_rental_app/models/bookvehicle_model.dart';
import 'package:vehicle_rental_app/models/userbookinghistory_model.dart'
    as history;

class VehicleProvider extends ChangeNotifier {
  final VehicleService _vehicleService = VehicleService();
  List<Datum> _vehicles = [];
  List<history.Datum> _bookings = [];

  bool _isLoading = false;
  String? _errorMessage;

  List<Datum> get vehicles => _vehicles;
  List<history.Datum> get bookings => _bookings;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> availablevehicle() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final response = await _vehicleService.availablevehicle();

      AvailableVehicleModel aVModel = AvailableVehicleModel.fromJson(response);
      _vehicles = aVModel.data;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<BookvehicleModel?> bookvehicle({
    required String vehicleId,
    required String startDate,
    required String endDate,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final body = jsonEncode({
        'vehicleId': vehicleId,
        'startDate': startDate,
        'endDate': endDate,
      });

      final response = await _vehicleService.bookvehicle(body: body);
      BookvehicleModel bookModel = BookvehicleModel.fromJson(response);

      _isLoading = false;
      notifyListeners();
      return bookModel;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> userbookinghistory() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final response = await _vehicleService.userbookinghistory();

      history.UserBookingHistoryModel historyModel =
          history.UserBookingHistoryModel.fromJson(response);

      _bookings = historyModel.data;

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      notifyListeners();
      rethrow;
    }
  }
}
