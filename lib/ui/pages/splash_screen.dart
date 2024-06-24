import 'package:bhc_housing_project/services/supabase_service.dart';
import 'package:bhc_housing_project/ui/pages/home.dart';
import 'package:bhc_housing_project/ui/pages/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthState();
  }

  Future<void> _checkAuthState() async {
    // Add a small delay to show the splash screen
    await Future.delayed(const Duration(seconds: 2));
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() {
    // Check if the user is logged in
    final user = SupabaseService.supabaseClient.auth.currentUser;
    if (user == null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => LoginPage()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const Home()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
