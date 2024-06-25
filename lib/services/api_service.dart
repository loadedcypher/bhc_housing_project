import 'dart:convert';
import 'package:bhc_housing_project/models/property.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String url = 'http://192.168.0.199:3000/properties';

  static Future<List<Property>> fetchProperties() async {
    try {
      final response = await http.get(Uri.parse(url));

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
}
