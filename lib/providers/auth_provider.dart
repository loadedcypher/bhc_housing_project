import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  Future<AuthResponse> signInWithEmail(String email, String password) async {
    try {
      final response = await _authService.signInWithEmail(email, password);
      _isLoggedIn = true;
      notifyListeners();

      return response;
    } catch (error) {
      throw error;
    }
  }

  Future<AuthResponse> signUpWithEmail(String email, String password) async {
    try {
      final response = await _authService.signUpWithEmail(email, password);
      _isLoggedIn = true;
      notifyListeners();

      return response;
    } catch (error) {
      throw error;
    }
  }

  Future<void> logout() async {
    try {
      await _authService.signOut();
      _isLoggedIn = false;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
