import 'dart:convert';
import 'package:bhc_housing_project/models/property.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://192.168.0.199:3000';

  static Future<List<Property>> fetchProperties() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/properties'));

      if (response.statusCode == 200) {
        Iterable jsonResponse = json.decode(response.body);
        return List<Property>.from(jsonResponse
            .map((model) => Property.fromJson(model as Map<String, dynamic>)));
      } else {
        throw Exception('Failed to load properties: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load properties: $e');
    }
  }

  static Future<List<Map<String, dynamic>>> getCustomerDetails(
      String customerNumber) async {
    final response = await http.get(Uri.parse(
        '$baseUrl/user_property_details?customer_number=$customerNumber'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((item) => item as Map<String, dynamic>).toList();
    } else {
      print('Failed to load customer details');
      return [];
    }
  }
}
