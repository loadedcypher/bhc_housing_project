import 'package:bhc_housing_project/models/user.dart';
import 'package:bhc_housing_project/providers/auth_provider.dart';
import 'package:bhc_housing_project/providers/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

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
  final _confirmPasswordController = TextEditingController();
  final _customerNumberController = TextEditingController();

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  bool _isCurrentTenant = false;

  void _togglePasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _confirmPasswordVisible = !_confirmPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Signup',
          style: TextStyle(
            color: Color(0xFFAC2324),
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 40),
              Image.asset(
                'lib/ui/assets/BHC HQ LOGO.png',
                height: 200,
                width: 200,
              ),
              const SizedBox(height: 40),
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Enter your first name' : null,
              ),
              const SizedBox(height: 12.0),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Enter your last name' : null,
              ),
              const SizedBox(height: 12.0),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
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
              const SizedBox(height: 12.0),
              TextFormField(
                controller: _omangNumberController,
                decoration: const InputDecoration(
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
              const SizedBox(height: 12.0),
              TextFormField(
                controller: _phoneNumberController,
                decoration: const InputDecoration(
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
              const SizedBox(height: 12.0),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
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
              const SizedBox(height: 12.0),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _confirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: _toggleConfirmPasswordVisibility,
                  ),
                ),
                obscureText: !_confirmPasswordVisible,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Confirm your password';
                  }
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12.0),
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: 'User Type',
                  border: OutlineInputBorder(),
                ),
                value: _isCurrentTenant ? 'current_tenant' : null,
                items: ['current_tenant', 'prospective_client']
                    .map((type) =>
                        DropdownMenuItem(value: type, child: Text(type)))
                    .toList(),
                validator: (value) => value == null ? 'Select user type' : null,
                onChanged: (value) {
                  setState(() {
                    _isCurrentTenant = value == 'current_tenant';
                  });
                },
              ),
              const SizedBox(height: 12.0),
              Visibility(
                visible: _isCurrentTenant,
                child: TextFormField(
                  controller: _customerNumberController,
                  decoration: InputDecoration(
                    labelText: 'Customer Number',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => _isCurrentTenant && value!.isEmpty
                      ? 'Enter your customer number'
                      : null,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      final authProvider =
                          Provider.of<AuthProvider>(context, listen: false);
                      final databaseProvider =
                          Provider.of<DatabaseProvider>(context, listen: false);
                      final response = await authProvider.signUpWithEmail(
                        _emailController.text.trim(),
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
                          userType: _isCurrentTenant
                              ? 'current_tenant'
                              : 'prospective_client',
                          customerNumber: _isCurrentTenant
                              ? _customerNumberController.text
                              : null,
                        );
                        await databaseProvider.addUser(user);
                      }

                      Navigator.pushReplacementNamed(context, '/login');
                    } catch (error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Signup failed: $error')),
                      );
                    }
                  }
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.resolveWith<Color>((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return const Color(0xFFFAA21B); // Color when pressed
                    }
                    return const Color(0xFFAC2324); // Default color
                  }),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              TextButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, '/login'),
                child: const Text(
                  "Already Registered? Sign In!",
                  style: TextStyle(
                    color: Color(0xFFFAA21B),
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
