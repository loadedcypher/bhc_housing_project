// This module is used for handling the supabase auth services.

import 'package:bhc_housing_project/services/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _client = SupabaseService.supabaseClient;

  // method to sign up a user with email and password.

  Future<AuthResponse> signUpWithEmail(String email, String password) async {
    final response =
        await _client.auth.signUp(email: email, password: password);
    return response;
  }

  // Sign in method with email and password
  Future<AuthResponse> signInWithEmail(String email, String password) async {
    final response =
        await _client.auth.signInWithPassword(email: email, password: password);
    return response;
  }

  // method to sign a user out.
  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  Future<User?> getCurrentUser() async {
    final currentUser = SupabaseService.supabaseClient.auth.currentUser;
    if (currentUser != null) {
      return await getUserData(currentUser.id);
    }
    return null;
  }

  Future<User?> getUserData(String userId) async {
    final userData = await SupabaseService.supabaseClient
        .from('users')
        .select()
        .eq('id', userId)
        .single();

    return User.fromJson(userData);
  }
}
