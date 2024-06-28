import 'package:bhc_housing_project/services/api_service.dart';
import 'package:flutter/material.dart';

class StatementsScreen extends StatefulWidget {
  final String customerNumber;

  StatementsScreen({required this.customerNumber});

  @override
  _StatementsScreenState createState() => _StatementsScreenState();
}

class _StatementsScreenState extends State<StatementsScreen> {
  late Future<List<Map<String, dynamic>>> customerDetails;

  @override
  void initState() {
    super.initState();
    customerDetails = ApiService.getCustomerDetails(widget.customerNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tenant Statement',
          style: TextStyle(color: Color(0xFFFAA21B)),
        ),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: customerDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return const Center(child: Text('No data found'));
            }
            final data = snapshot.data!.first;
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildCard('Address', data['address']),
                _buildCard('Location', data['location']),
                _buildCard('Date Registered', data['date_registered']),
                _buildCard('Tenant Type', data['tenant_type']),
                ..._buildStatementCards(data['statement'], data['tenant_type']),
              ],
            );
          } else {
            return const Center(child: Text('No data found'));
          }
        },
      ),
    );
  }

  Widget _buildCard(String title, String detail) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFFAC2324),
          ),
        ),
        subtitle: Text(
          detail,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildStatementCards(
      Map<String, dynamic> statement, String tenantType) {
    if (tenantType == 'rental') {
      final rentalStatement = statement['rental_statement'];
      return [
        _buildCard('Date Of Billing', rentalStatement['Date Of Billing']),
        _buildCard('Monthly Rent', rentalStatement['Monthly Rent'].toString()),
        _buildCard(
            'Amounts Received', rentalStatement['Amounts Received'].toString()),
        _buildCard('Outstanding Balance',
            rentalStatement['Outstanding Balance'].toString()),
      ];
    } else {
      final tpsStatement = statement['tps_statement'];
      return [
        _buildCard('Date Of Sales', tpsStatement['Date Of Sales']),
        _buildCard('Sales Price', tpsStatement['Sales Price'].toString()),
        _buildCard('Loan Amount', tpsStatement['Loan Amount'].toString()),
        _buildCard('Payback Period (months)',
            tpsStatement['Payback Period (months)'].toString()),
        _buildCard('Down Payment', tpsStatement['Down Payment'].toString()),
        _buildCard('Interest Rate (%)', tpsStatement['Interest Rate (%)']),
        _buildCard('Monthly Installment',
            tpsStatement['Monthly Installment'].toString()),
        _buildCard('Monthly Admin Charges',
            tpsStatement['Monthly Admin Charges'].toString()),
        _buildCard('Admin Charges', tpsStatement['Admin Charges'].toString()),
        _buildCard(
            'Finance Charges', tpsStatement['Finance Charges'].toString()),
        _buildCard('Rental Billing', tpsStatement['Rental Billing'].toString()),
        _buildCard('Loan Billing', tpsStatement['Loan Billing'].toString()),
        _buildCard(
            'Amounts Received', tpsStatement['Amounts Received'].toString()),
        _buildCard('Other Charges', tpsStatement['Other Charges'].toString()),
        _buildCard('Outstanding Balance As of',
            tpsStatement['Outstanding Balance As of'].toString()),
        _buildCard('Balance', tpsStatement['Balance'].toString()),
      ];
    }
  }
}
