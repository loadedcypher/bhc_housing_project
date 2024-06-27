import 'package:bhc_housing_project/models/service_request.dart';
import 'package:bhc_housing_project/services/supabase_service.dart';
import 'package:bhc_housing_project/models/user.dart' as user_model;
import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseService {
  final SupabaseClient _client = SupabaseService.supabaseClient;

  // Insert a new user
  Future<void> insertUser(user_model.User user) async {
    try {
      await _client.from('users').insert(user.toJson());
    } catch (error) {
      throw Exception('Failed to insert user: $error');
    }
  }

  // Update an existing user
  Future<void> updateUser(user_model.User user) async {
    try {
      await _client.from('users').update(user.toJson()).eq('id', user.id!);
    } catch (error) {
      throw Exception('Failed to update user: $error');
    }
  }

  // Delete a user
  Future<void> deleteUser(int userId) async {
    try {
      await _client.from('users').delete().eq('id', userId);
    } catch (error) {
      throw Exception('Failed to delete user: $error');
    }
  }

  Future<void> insertServiceRequest(ServiceRequest request) async {
    await _client.from('service_requests').insert(request.toMap());
  }

  Future<List<ServiceRequest>> getServiceRequests() async {
    final response = await _client.from('service_requests').select();

    final data = response as List;
    return data.map((json) => ServiceRequest.fromMap(json)).toList();
  }
}
