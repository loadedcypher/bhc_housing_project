import 'package:bhc_housing_project/providers/auth_provider.dart';
import 'package:bhc_housing_project/services/supabase_service.dart';
import 'package:bhc_housing_project/ui/pages/dashboard.dart';
import 'package:bhc_housing_project/ui/pages/explore.dart';
import 'package:bhc_housing_project/ui/pages/general_enquiries.dart';
import 'package:bhc_housing_project/ui/pages/service_requests.dart';
import 'package:bhc_housing_project/ui/pages/statements.dart';
import 'package:bhc_housing_project/ui/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  late Future<Map<String, dynamic>> _userDataFuture;

  @override
  void initState() {
    super.initState();
    _userDataFuture = _fetchUserData();
    SupabaseService.supabaseClient.auth.onAuthStateChange.listen((data) {
      if (data.event == AuthChangeEvent.signedIn ||
          data.event == AuthChangeEvent.signedOut) {
        setState(() {
          _userDataFuture = _fetchUserData();
        });
      }
    });
  }

  Future<Map<String, dynamic>> _fetchUserData() async {
    final user = SupabaseService.supabaseClient.auth.currentUser;
    if (user != null) {
      final response = await SupabaseService.supabaseClient
          .from('users')
          .select('user_type, customer_number')
          .eq('id', user.id)
          .single();
      return {
        'userType': response['user_type'],
        'customerNumber': response['customer_number'] ?? '',
      };
    }
    return {'userType': '', 'customerNumber': ''};
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "BHC House Management",
          style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFFAC2324)),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _userDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final userData = snapshot.data!;
          final userType = userData['userType'];
          final customerNumber = userData['customerNumber'];

          List<Widget> pages = _getPages(userType, customerNumber);

          return IndexedStack(
            index: _selectedIndex,
            children: pages,
          );
        },
      ),
      bottomNavigationBar: FutureBuilder<Map<String, dynamic>>(
        future: _userDataFuture,
        builder: (context, snapshot) {
          String userType = snapshot.data?['userType'] ?? '';
          return RoleBasedNavBar(
            userType: userType,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          );
        },
      ),
    );
  }

  List<Widget> _getPages(String userType, String customerNumber) {
    if (userType == 'prospective_client') {
      return [
        Dashboard(),
        ExplorePage(),
        GeneralEnquiries(),
      ];
    } else if (userType == 'current_tenant') {
      return [
        Dashboard(),
        StatementsScreen(customerNumber: customerNumber),
        ServiceRequests(serviceRequests: [], onAddRequest: (ServiceRequest) {}),
        GeneralEnquiries()
      ];
    } else {
      return [
        const Center(child: Text('Error Page')),
        const Center(child: Text('Help Page')),
      ];
    }
  }

  void _logout(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.logout();
    Navigator.pushReplacementNamed(context, '/login');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Logged out")),
    );
  }
}
