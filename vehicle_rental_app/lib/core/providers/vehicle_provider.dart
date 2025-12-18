import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vehicle_rental_app/core/services/secure_storage.dart';
import 'package:vehicle_rental_app/core/services/vehicle_service.dart';
import 'package:vehicle_rental_app/models/availablevehicles_model.dart';
import 'package:vehicle_rental_app/models/bookvehicle_model.dart';

class VehicleProvider extends ChangeNotifier {
  final VehicleService _vehicleService = VehicleService();
  final SecureStorageService _storageService = SecureStorageService();

  List<Datum> _vehicles = [];

  bool _isLoading = false;
  String? _errorMessage;

  List<Datum> get vehicles => _vehicles;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> availablevehicle() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final response = await _vehicleService.availablevehicle();

      AvailableVehiclesModel aVModel = AvailableVehiclesModel.fromJson(
        response,
      );
      _vehicles = aVModel.data;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
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
      final data = bookModel.data;
      if (data != null) {
        await _storageService.setValue('booking_status', data.status ?? '');
        await _storageService.setValue(
          'booking_start_date',
          data.startDate?.toIso8601String() ?? '',
        );
        await _storageService.setValue(
          'booking_end_date',
          data.endDate?.toIso8601String() ?? '',
        );
      }

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
}
