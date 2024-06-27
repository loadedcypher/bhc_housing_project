import 'package:bhc_housing_project/services/supabase_service.dart';
import 'package:bhc_housing_project/ui/pages/home.dart';
import 'package:bhc_housing_project/ui/pages/login.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4), // Adjusted duration to 4 seconds
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeInOut,
    );

    _controller!.forward();
    _controller!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _navigateToNextScreen();
      }
    });

    _checkAuthState();
  }

  Future<void> _checkAuthState() async {
    // Add a delay to show the splash screen
    await Future.delayed(const Duration(seconds: 2));
  }

  void _navigateToNextScreen() {
    // Check if the user is logged in
    final user = SupabaseService.supabaseClient.auth.currentUser;
    if (user == null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const Home()),
      );
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFAC2324), Color(0xFFFAA21B)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: _animation!,
                child: Image.asset(
                  'lib/ui/assets/LOGO HQ WHITE.png',
                  height: 150.0, // Adjust the height of the logo
                  width: 150.0, // Adjust the width of the logo
                ),
              ),
              const SizedBox(height: 20.0), // Spacer between logo and text
              const Text(
                'Powered by YGG',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10.0),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
