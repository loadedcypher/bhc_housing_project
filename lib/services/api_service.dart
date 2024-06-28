import 'dart:convert';
import 'package:bhc_housing_project/config/enviroment.dart';
import 'package:bhc_housing_project/models/property.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static final String baseUrl = EnviromentVariables.bhcSimulationUrl!;

  static Future<List<Property>> fetchProperties() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        List<dynamic> propertiesJson = jsonResponse['record']['properties'];
        return propertiesJson.map((json) => Property.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load properties: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load properties: $e');
    }
  }

  static Future<List<Map<String, dynamic>>> getCustomerDetails(
      String customerNumber) async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        List<dynamic> userPropertyDetails =
            jsonResponse['record']['user_property_details'];
        return userPropertyDetails
            .where((detail) => detail['customer_number'] == customerNumber)
            .map((item) => item as Map<String, dynamic>)
            .toList();
      } else {
        throw Exception(
            'Failed to load customer details: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load customer details: $e');
    }
  }
}
