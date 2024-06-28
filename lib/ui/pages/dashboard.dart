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
  String name = "";
  String userType = "";

  @override
  void initState() {
    super.initState();
    fetchCustomerDetails();
  }

  Future<void> fetchCustomerDetails() async {
    await fetchCustomerName();
    await fetchCustomerNumber();
    await fetchUserType();
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

  Future<void> fetchUserType() async {
    final user = SupabaseService.supabaseClient.auth.currentUser;
    if (user != null) {
      final response = await SupabaseService.supabaseClient
          .from('users')
          .select('user_type')
          .eq('id', user.id)
          .single();
      print(response);
      if (mounted) {
        setState(() {
          userType = response['user_type'];
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
            if (userType == 'current_tenant')
              _buildPropertyCard()
            else
              _buildFindAHomeText(),
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
          Text(
            'Dumela ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
            ),
          ),
          Text(
            name.isNotEmpty ? name : widget.userName,
            style: TextStyle(
              color: Color(0xFFAC2324),
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          Text(
            '!',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
            ),
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
              image: DecorationImage(
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
                SizedBox(height: 85.0),
                Text(
                  'Property Details',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  'Plot Number: ${widget.propertyPlotNumber ?? ''}\n'
                  'Region: ${widget.propertyRegion ?? ''}\n'
                  'Location: ${widget.propertyLocation ?? ''}',
                  style: TextStyle(
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

  Widget _buildFindAHomeText() {
    return Text(
      'Find a home now!',
      style: TextStyle(
        color: Colors.black,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildDividerWithText(String text) {
    return Column(
      children: [
        Row(
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
            textAlign: TextAlign.right,
            style: TextStyle(
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
    List<Widget> cards = [
      _buildServiceCard(
        context,
        iconPath: 'lib/ui/assets/generalEnquiries.png',
        destination: GeneralEnquiries(),
      ),
    ];

    if (userType == 'current_tenant') {
      cards.addAll([
        SizedBox(height: 10.0),
        _buildServiceCard(
          context,
          iconPath: 'lib/ui/assets/serviceRequest.png',
          destination: ServiceRequests(
            onAddRequest: (ServiceRequest) {},
            serviceRequests: [],
          ),
        ),
        SizedBox(height: 10.0),
        _buildServiceCard(
          context,
          iconPath: 'lib/ui/assets/statements.png',
          destination: StatementsScreen(customerNumber: customerNumber),
        ),
      ]);
    } else if (userType == 'prospective_client') {
      cards.addAll([
        SizedBox(height: 10.0),
        _buildServiceCard(
          context,
          iconPath: 'lib/ui/assets/explore.png',
          destination: ExplorePage(),
        ),
      ]);
    }

    return Column(
      children: cards,
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
