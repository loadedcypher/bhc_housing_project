import 'package:bhc_housing_project/services/supabase_service.dart';
import 'package:bhc_housing_project/ui/pages/general_enquiries.dart';
import 'package:bhc_housing_project/ui/pages/service_requests.dart';
import 'package:bhc_housing_project/ui/pages/explore.dart';
import 'package:bhc_housing_project/ui/pages/statements.dart';
import 'package:flutter/material.dart';

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
  String name = ""; // Ensure this is initialized with an empty string

  @override
  void initState() {
    super.initState();
    fetchCustomerDetails();
  }

  Future<void> fetchCustomerDetails() async {
    await fetchCustomerName();
    await fetchCustomerNumber();
  }

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

  Future<void> fetchCustomerName() async {
    final user = SupabaseService.supabaseClient.auth.currentUser;
    if (user != null) {
      final response = await SupabaseService.supabaseClient
          .from('users')
          .select('first_name')
          .eq('id', user.id)
          .single();
      print(response);
      if (mounted) {
        setState(() {
          name = response['first_name'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            'Welcome, ',
            style: TextStyle(
              fontSize: 24.0,
              color: Color(0xFF1E1E1E),
            ),
            children: [
              const TextSpan(text: 'Dumela '),
              TextSpan(
                text: name.isNotEmpty ? name : widget.userName,
                style: const TextStyle(
                    color: Color(0xFFAC2324), fontWeight: FontWeight.bold),
              ),
              const TextSpan(text: '!'),
            ],
          ),
        ],
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
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.8),
                ],
              ),
            ),
            height: 200,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 85.0),
                const Text(
                  'Property Details',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5.0),
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
    return Column(
      children: [
        const Row(
          children: [
            Expanded(
              child: Divider(
                color: Color.fromRGBO(202, 196, 208, 1),
                height: 20,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            text,
            textAlign: TextAlign.right, // Set the text alignment to right
            style: const TextStyle(
              color: Color.fromRGBO(54, 60, 69, 1),
              fontSize: 20.0,
              fontWeight: FontWeight.normal,
            ),
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
        const SizedBox(height: 10.0),
        _buildServiceCard(
          context,
          iconPath: 'lib/ui/assets/serviceRequest.png',
          destination: ServiceRequests(
            onAddRequest: (ServiceRequest) {},
            serviceRequests: [],
          ),
        ),
        const SizedBox(height: 10.0),
        _buildServiceCard(
          context,
          iconPath: 'lib/ui/assets/statements.png',
          destination: StatementsScreen(customerNumber: customerNumber),
        ),
        const SizedBox(height: 10.0),
        _buildServiceCard(
          context,
          iconPath: 'lib/ui/assets/explore.png',
          destination: const ExplorePage(),
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
