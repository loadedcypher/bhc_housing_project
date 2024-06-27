import 'package:bhc_housing_project/models/user.dart';
import 'package:bhc_housing_project/providers/auth_provider.dart';
import 'package:bhc_housing_project/providers/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _omangNumberController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _userTypeController = TextEditingController();

  bool _passwordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              const Text('Signup', style: TextStyle(color: Color(0xFFAC2324)))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'Signup',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFAC2324),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Enter your first name' : null,
              ),
              SizedBox(height: 12.0),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Enter your last name' : null,
              ),
              SizedBox(height: 12.0),
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
                  // Add email format validation if needed
                  return null;
                },
              ),
              SizedBox(height: 12.0),
              TextFormField(
                controller: _omangNumberController,
                decoration: InputDecoration(
                  labelText: 'Omang Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter your Omang number';
                  }
                  // Validate Botswana Omang number format (9 digits, 5th digit: 1 or 2)
                  if (!RegExp(r'^\d{9}$').hasMatch(value)) {
                    return 'Invalid Omang number';
                  }
                  if (value[4] != '1' && value[4] != '2') {
                    return 'Invalid Omang number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12.0),
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter your phone number';
                  }
                  // Validate Botswana phone number format (8 digits, starts with 7)
                  if (!RegExp(r'^7\d{7}$').hasMatch(value)) {
                    return 'Invalid phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12.0),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: _togglePasswordVisibility,
                  ),
                ),
                obscureText: !_passwordVisible,
                validator: (value) =>
                    value!.isEmpty ? 'Enter your password' : null,
              ),
              SizedBox(height: 12.0),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: 'User Type',
                  border: OutlineInputBorder(),
                ),
                items: ['current_tenant', 'prospective_client']
                    .map((type) =>
                        DropdownMenuItem(value: type, child: Text(type)))
                    .toList(),
                validator: (value) => value == null ? 'Select user type' : null,
                onChanged: (value) {
                  _userTypeController.text = value.toString();
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      final authProvider =
                          Provider.of<AuthProvider>(context, listen: false);
                      final databaseProvider =
                          Provider.of<DatabaseProvider>(context, listen: false);
                      final response = await authProvider.signUpWithEmail(
                        _emailController.text,
                        _passwordController.text,
                      );

                      if (response.user != null) {
                        final user = User(
                          id: response.user!.id,
                          firstName: _firstNameController.text,
                          lastName: _lastNameController.text,
                          email: _emailController.text,
                          omangNumber: _omangNumberController.text,
                          phoneNumber: _phoneNumberController.text,
                          userType: _userTypeController.text,
                        );
                        databaseProvider.addUser(user);
                      }

                      Navigator.pushReplacementNamed(context, '/home');
                    } catch (error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Signup failed: $error')),
                      );
                    }
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Color(0xFFFAA21B);
                      }
                      return Color(0xFFAC2324);
                    },
                  ),
                ),
                child: const Text(
                  'Signup',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, '/login'),
                child: const Text("Already Registered? Sign In!"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
