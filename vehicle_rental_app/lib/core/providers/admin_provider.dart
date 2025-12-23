import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vehicle_rental_app/core/services/vehicle_service.dart';
import '../../models/vehicle_model.dart';

class AdminProvider extends ChangeNotifier {
  final VehicleService _vehicleService = VehicleService();
  List<Datum> _vehicles = [];

  bool _isLoading = false;
  String? _errorMessage;

  List<Datum> get vehicles => _vehicles;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> getvehicles() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final response = await _vehicleService.getvehicles();

      VehicleModel vehicleModel = VehicleModel.fromJson(response);
      _vehicles = vehicleModel.data;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> deletevehicle({required String vehicleId}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      await _vehicleService.deletevehicle(vehicleId: vehicleId);
      _vehicles.removeWhere((vehicle) => vehicle.id == vehicleId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> editvehicle({
    required String vehicleId,
    required String vehiclename,
    required String vehicleBrand,
    required String vehicleType,
    required String fuelType,
    required int seats,
    required int pricePerDay,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final body = jsonEncode({
        'name': vehiclename,
        'brand': vehicleBrand,
        'type': vehicleType,
        'fuelType': fuelType,
        'seats': seats,
        'pricePerDay': pricePerDay,
      });
      await _vehicleService.editvehicle(vehicleId: vehicleId, body: body);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> addvehicle({
    required String name,
    required String brand,
    required String fuelType,
    required int seats,
    required int pricePerDay,
    required String type,
    required List<String> images,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Prepare fields as Map<String, String>
      final fields = {
        'name': name,
        'brand': brand,
        'fuelType': fuelType,
        'seats': seats.toString(),
        'pricePerDay': pricePerDay.toString(),
        'type': type,
      };

      await _vehicleService.addvehicle(fields: fields, imagePaths: images);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }
}
