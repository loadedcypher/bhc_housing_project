import 'package:bhc_housing_project/services/supabase_service.dart';
import 'package:bhc_housing_project/ui/pages/general_enquiries.dart';
import 'package:bhc_housing_project/ui/pages/service_requests.dart';
import 'package:bhc_housing_project/ui/pages/explore.dart';
import 'package:bhc_housing_project/ui/pages/statements.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Dashboard extends StatefulWidget {
  final String userName;
  final String? propertyPlotNumber;
  final String? propertyRegion;
  final String? propertyLocation;

  const Dashboard({
    Key? key,
    this.userName = 'Guest',
    this.propertyPlotNumber,
    this.propertyRegion,
    this.propertyLocation,
  }) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String customerNumber = "";
  Future<void> fetchCustomerNumber() async {
    final user = SupabaseService.supabaseClient.auth.currentUser;
    if (user != null) {
      final response = await SupabaseService.supabaseClient
          .from('users')
          .select('customer_number')
          .eq('id', user.id)
          .single();
      print(response);
      if (mounted) {
        setState(() {
          customerNumber = response['customer_number'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildGreeting(),
            const SizedBox(height: 16.0),
            _buildPropertyCard(),
            const SizedBox(height: 16.0),
            _buildDividerWithText('Management Tools'),
            const SizedBox(height: 16.0),
            _buildCardsColumn(context),
          ],
        ),
      ),
    );
  }

  Widget _buildGreeting() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 18.0,
            color: Color(0xFF1E1E1E),
          ),
          children: [
            const TextSpan(text: 'Welcome, '),
            TextSpan(
              text: widget.userName,
              style: const TextStyle(color: Color(0xFFAC2324)),
            ),
            const TextSpan(text: '!'),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 4.0,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: const DecorationImage(
                image: AssetImage('lib/ui/assets/house.png'),
                fit: BoxFit.cover,
              ),
            ),
            height: 200,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your Property Details',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Plot Number: ${widget.propertyPlotNumber}\n'
                  'Region: ${widget.propertyRegion}\n'
                  'Location: ${widget.propertyLocation}',
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDividerWithText(String text) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: Colors.black,
            height: 20,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Expanded(
          child: Divider(
            color: Colors.black,
            height: 20,
          ),
        ),
      ],
    );
  }

  Widget _buildCardsColumn(BuildContext context) {
    return Column(
      children: [
        _buildServiceCard(
          context,
          iconPath: 'lib/ui/assets/generalEnquiries.png',
          destination: GeneralEnquiries(),
        ),
        const SizedBox(height: 16.0),
        _buildServiceCard(
          context,
          iconPath: 'lib/ui/assets/serviceRequest.png',
          destination: ServiceRequests(
            onAddRequest: (ServiceRequest) {},
            serviceRequests: [],
          ),
        ),
        const SizedBox(height: 16.0),
        _buildServiceCard(
          context,
          iconPath: 'lib/ui/assets/statements.png',
          destination: StatementsScreen(customerNumber: customerNumber),
        ),
        const SizedBox(height: 16.0),
        _buildServiceCard(
          context,
          iconPath: 'lib/ui/assets/explore.png',
          destination: ExplorePage(),
        ),
      ],
    );
  }

  Widget _buildServiceCard(
    BuildContext context, {
    required String iconPath,
    required Widget destination,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        elevation: 0.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              width: 360,
              height: 137,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
