import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vehicle_rental_app/core/services/secure_storage.dart';

class ApiService {
  // Singleton pattern
  ApiService._();
  static final ApiService instance = ApiService._();

  //securestoragservice
  final SecureStorageService _storage = SecureStorageService();

  //HTTP GET Request
  Future<dynamic> httpGet({
    required String url,
    required bool isWithoutToken,
  }) async {
    try {
      final headers = await _buildHeaders(isWithoutToken: isWithoutToken);
      final response = await http.get(Uri.parse(url), headers: headers);

      return _handleResponse(response);
    } catch (e) {
      throw Exception('Get Request Failed: $e');
    }
  }

  //HTTP POST Request
  Future<dynamic> httpPost({
    required String url,
    required String body,
    required bool isWithoutToken,
  }) async {
    try {
      final headers = await _buildHeaders(isWithoutToken: isWithoutToken);

      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      return _handleResponse(response);
    } catch (e) {
      throw Exception('POST request failed: $e');
    }
  }

  //HTTP PUT Request
  Future<dynamic> httpPut({
    required String url,
    required Map<String, dynamic> body,
    required bool isWithoutToken,
  }) async {
    try {
      final headers = await _buildHeaders(isWithoutToken: isWithoutToken);

      final response = await http.put(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );

      return _handleResponse(response);
    } catch (e) {
      throw Exception('PUT request failed: $e');
    }
  }

  //HTTP DELETE Request
  Future<dynamic> httpDelete({
    required String url,
    bool isWithoutToken = false,
  }) async {
    try {
      final headers = await _buildHeaders(isWithoutToken: isWithoutToken);

      final response = await http.delete(Uri.parse(url), headers: headers);

      return _handleResponse(response);
    } catch (e) {
      throw Exception('DELETE request failed: $e');
    }
  }

  // ============================================
  // Private Helper Methods
  // ============================================

  //Request Headers
  Future<Map<String, String>> _buildHeaders({
    required bool isWithoutToken,
  }) async {
    final headers = {"Content-Type": "application/json"};
    // if (!isWithoutToken) {
    //   final token = await _storage.readValue(key);
    //   if (token != null && token.isNotEmpty) {
    //     headers['Authorization'] = 'Bearer $token';
    //   }
    // }
    return headers;
  }

  //Handle HTTP Response
  dynamic _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return jsonDecode(response.body);
      case 400:
        throw Exception('Bad request: ${response.body}');
      case 401:
        throw Exception('Unauthorized: ${response.body}');
      case 403:
        throw Exception('Forbidden: ${response.body}');
      case 404:
        throw Exception('Not found: ${response.body}');
      case 500:
        throw Exception('Server error: ${response.body}');
      default:
        throw Exception('Request failed with status: ${response.statusCode}');
    }
  }
}
