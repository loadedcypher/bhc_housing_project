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
        foregroundColor: Colors.white,
        flexibleSpace: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'lib/ui/assets/statementsTopBar.png', // Replace with your image asset path
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              height: 300, // Increase the height to your desired size
            ),
          ],
        ),
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
              return Center(child: Text('No data found'));
            }
            final data = snapshot.data!.first;
            return ListView(
              padding: EdgeInsets.all(16),
              children: [
                Text('Customer Number: ${data['customer_number']}'),
                Text('Address: ${data['address']}'),
                Text('Location: ${data['location']}'),
                Text('Date Registered: ${data['date_registered']}'),
                Text('Tenant Type: ${data['tenant_type']}'),
                ..._buildStatement(data['statement'], data['tenant_type']),
              ],
            );
          } else {
            return const Center(child: Text('No data found'));
          }
        },
      ),
    );
  }

  List<Widget> _buildStatement(
      Map<String, dynamic> statement, String tenantType) {
    if (tenantType == 'rental') {
      final rentalStatement = statement['rental_statement'];
      return [
        Text('Date Of Billing: ${rentalStatement['Date Of Billing']}'),
        Text('Monthly Rent: ${rentalStatement['Monthly Rent']}'),
        Text('Amounts Received: ${rentalStatement['Amounts Received']}'),
        Text('Outstanding Balance: ${rentalStatement['Outstanding Balance']}'),
      ];
    } else {
      final tpsStatement = statement['tps_statement'];

      return [
        Text('Date Of Sales: ${tpsStatement['Date Of Sales']}'),
        Text('Sales Price: ${tpsStatement['Sales Price']}'),
        Text('Loan Amount: ${tpsStatement['Loan Amount']}'),
        Text(
            'Payback Period (months): ${tpsStatement['Payback Period (months)']}'),
        Text('Down Payment: ${tpsStatement['Down Payment']}'),
        Text('Interest Rate (%): ${tpsStatement['Interest Rate (%)']}'),
        Text('Monthly Installment: ${tpsStatement['Monthly Installment']}'),
        Text('Monthly Admin Charges: ${tpsStatement['Monthly Admin Charges']}'),
        Text('Admin Charges: ${tpsStatement['Admin Charges']}'),
        Text('Finance Charges: ${tpsStatement['Finance Charges']}'),
        Text('Rental Billing: ${tpsStatement['Rental Billing']}'),
        Text('Loan Billing: ${tpsStatement['Loan Billing']}'),
        Text('Amounts Received: ${tpsStatement['Amounts Received']}'),
        Text('Other Charges: ${tpsStatement['Other Charges']}'),
        Text(
            'Outstanding Balance As of: ${tpsStatement['Outstanding Balance As of']}'),
        Text('Balance: ${tpsStatement['Balance']}'),
      ];
    }
  }
}
