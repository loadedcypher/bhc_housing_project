import 'package:bhc_housing_project/providers/auth_provider.dart';
import 'package:bhc_housing_project/services/supabase_service.dart';
import 'package:bhc_housing_project/ui/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  bool _passwordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      try {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        final response = await authProvider.signInWithEmail(
          _emailController.text.trim(),
          _passwordController.text,
        );
        if (response.user != null) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const Home()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Sign in failed')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign in failed: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'Login',
                style: TextStyle(
                  color: Color(0xFFAC2324),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: _togglePasswordVisibility,
                  ),
                ),
                obscureText: !_passwordVisible,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  // Implement forgot password logic here
                },
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _signIn,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Color(0xFFFAA21B); // Color when pressed
                    }
                    return Color(0xFFAC2324); // Default color
                  }),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, '/signup'),
                child: Text(
                  "Haven't registered yet? Sign up now!",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
