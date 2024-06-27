import 'package:bhc_housing_project/models/service_request.dart';
import 'package:flutter/material.dart';
import '../services/database_service.dart';
import '../models/user.dart';

class DatabaseProvider with ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();

  List<User> _users = [];
  bool _isLoading = false;

  List<User> get users => _users;
  bool get isLoading => _isLoading;

  // Insert a new user
  Future<void> addUser(User user) async {
    try {
      await _databaseService.insertUser(user);
      _users.add(user);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  // Update an existing user
  Future<void> editUser(User user) async {
    try {
      await _databaseService.updateUser(user);
      final index = _users.indexWhere((u) => u.id == user.id);
      if (index != -1) {
        _users[index] = user;
        notifyListeners();
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> makeServiceRequest(ServiceRequest serviceRequest) async {
    await _databaseService.insertServiceRequest(serviceRequest);
    notifyListeners();
  }

  Future<List<ServiceRequest>> fetchServiceRequests() async {
    final response = await _databaseService.getServiceRequests();

    return response;
  }
}
