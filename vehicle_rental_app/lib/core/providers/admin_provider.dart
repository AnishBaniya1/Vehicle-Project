import 'dart:convert';
import 'dart:developer';

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
}
