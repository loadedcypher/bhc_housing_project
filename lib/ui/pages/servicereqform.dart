import 'package:bhc_housing_project/models/service_request.dart';
import 'package:bhc_housing_project/providers/database_provider.dart';
import 'package:bhc_housing_project/services/supabase_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import 'package:supabase_flutter/supabase_flutter.dart';

class ServiceReqFormPage extends StatefulWidget {
  const ServiceReqFormPage({super.key});

  @override
  _ServiceReqFormPageState createState() => _ServiceReqFormPageState();
}

class _ServiceReqFormPageState extends State<ServiceReqFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _selectedFaultType = 'Electrical';
  String? _selectedFaultDetail;
  String? _description;

  final user = SupabaseService.supabaseClient.auth.currentUser;

  final Map<String, List<String>> _faultDetails = {
    'Electrical': [
      'Live wires',
      'Sockets',
      'Lights',
      'Geaser',
      'No power',
    ],
    'Plumbing': [
      'Leaking pipes',
      'Clogged drains',
      'Faulty taps',
      'Broken toilet',
      'Low water pressure',
    ],
    'General Maintenance': [
      'Broken windows',
      'Faulty doors',
      'Damaged walls',
      'Roof leaks',
      'Paint issues',
      'Outdoor maintenance',
    ],
  };

  String _generateReferenceNumber() {
    final random = Random();
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return String.fromCharCodes(Iterable.generate(
        6, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }

  void _submitForm() async {
    final databaseProvider =
        Provider.of<DatabaseProvider>(context, listen: false);
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final referenceNumber = _generateReferenceNumber();
      final newRequest = ServiceRequest(
          type: _selectedFaultType,
          description: _description ?? '',
          detail: _description!,
          status: 'Pending',
          reference_number: referenceNumber,
          user_id: user!.id);

      await databaseProvider.makeServiceRequest(newRequest);

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Service Request Submitted'),
          content: Text(
              'Your case has been logged with BHC. Your reference number is $referenceNumber. You will be assisted within 5 days.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(newRequest);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Service Request'),
        backgroundColor: const Color(0xFFAC2324),
        foregroundColor: const Color(0xFFFFFFFF), // Accent color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Fault Type'),
                value: _selectedFaultType,
                items: _faultDetails.keys.map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedFaultType = value!;
                    _selectedFaultDetail = null;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select a fault type' : null,
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Fault Detail'),
                value: _selectedFaultDetail,
                items: _faultDetails[_selectedFaultType]?.map((String fault) {
                  return DropdownMenuItem<String>(
                    value: fault,
                    child: Text(fault),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedFaultDetail = value!;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select a fault detail' : null,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 4,
                onSaved: (value) {
                  _description = value;
                },
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter a description'
                    : null,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFAC2324),
                  foregroundColor: const Color(0xFFFFFFFF), // Button color
                ),
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
