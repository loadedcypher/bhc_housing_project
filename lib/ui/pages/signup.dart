import 'package:bhc_housing_project/models/user.dart';
import 'package:bhc_housing_project/providers/auth_provider.dart';
import 'package:bhc_housing_project/providers/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _omangNumberController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _userTypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Signup')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Enter your first name' : null,
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Enter your last name' : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) =>
                    value!.isEmpty ? 'Enter your email' : null,
              ),
              TextFormField(
                controller: _omangNumberController,
                decoration: const InputDecoration(labelText: 'Omang Number'),
                validator: (value) =>
                    value!.isEmpty ? 'Enter your Omang number' : null,
              ),
              TextFormField(
                controller: _phoneNumberController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                validator: (value) =>
                    value!.isEmpty ? 'Enter your phone number' : null,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) =>
                    value!.isEmpty ? 'Enter your password' : null,
              ),
              DropdownButtonFormField(
                decoration: const InputDecoration(labelText: 'User Type'),
                items: ['current_tenant', 'prospective_client']
                    .map((type) =>
                        DropdownMenuItem(value: type, child: Text(type)))
                    .toList(),
                validator: (value) => value == null ? 'Select user type' : null,
                onChanged: (value) {
                  _userTypeController.text = value.toString();
                },
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
                          _emailController.text, _passwordController.text);

                      if (response.user != null) {
                        final user = User(
                            id: response.user!.id,
                            firstName: _firstNameController.text,
                            lastName: _lastNameController.text,
                            email: _emailController.text,
                            omangNumber: _omangNumberController.text,
                            phoneNumber: _phoneNumberController.text,
                            userType: _userTypeController.text);
                        databaseProvider.addUser(user);
                      }

                      Navigator.pushReplacementNamed(context, '/home');
                    } catch (error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Signup failed: $error')));
                    }
                  }
                },
                child: const Text('Signup'),
              ),
              TextButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/login'),
                  child: const Text("Already Registered? Sign In!"))
            ],
          ),
        ),
      ),
    );
  }
}
