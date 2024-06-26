import 'package:bhc_housing_project/services/api_service.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  final String customerNumber;
  const Dashboard({super.key, required this.customerNumber});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late Future<List<Map<String, dynamic>>> customerDetails;

  @override
  void initState() {
    super.initState();
    // Replace with actual customer number or fetch dynamically
    customerDetails = ApiService.getCustomerDetails(widget.customerNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
    );
  }

  List<Widget> _buildStatement(
      Map<String, dynamic> statement, String tenantType) {
    if (tenantType == 'rental') {
      return [
        Text('Date Of Billing: ${statement['Date Of Billing']}'),
        Text('Monthly Rent: ${statement['Monthly Rent']}'),
        Text('Amounts Received: ${statement['Amounts Received']}'),
        Text('Outstanding Balance: ${statement['Outstanding Balance']}'),
      ];
    } else {
      return [
        Text('Date Of Sales: ${statement['Date Of Sales']}'),
        Text('Sales Price: ${statement['Sales Price']}'),
        Text('Loan Amount: ${statement['Loan Amount']}'),
        Text(
            'Payback Period (months): ${statement['Payback Period (months)']}'),
        Text('Down Payment: ${statement['Down Payment']}'),
        Text('Interest Rate (%): ${statement['Interest Rate (%)']}'),
        Text('Monthly Installment: ${statement['Monthly Installment']}'),
        Text('Monthly Admin Charges: ${statement['Monthly Admin Charges']}'),
        Text('Admin Charges: ${statement['Admin Charges']}'),
        Text('Finance Charges: ${statement['Finance Charges']}'),
        Text('Rental Billing: ${statement['Rental Billing']}'),
        Text('Loan Billing: ${statement['Loan Billing']}'),
        Text('Amounts Received: ${statement['Amounts Received']}'),
        Text('Other Charges: ${statement['Other Charges']}'),
        Text(
            'Outstanding Balance As of: ${statement['Outstanding Balance As of']}'),
        Text('Balance: ${statement['Balance']}'),
      ];
    }
  }
}
