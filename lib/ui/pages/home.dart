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
  String userType = '';
  String customerNumber = "";
  int _selectedIndex = 0;

  void _logout(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    await authProvider.logout();

    Navigator.pushReplacementNamed(context, '/login');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Logged out")),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchUserType();
    fetchCustomerNumber();
    SupabaseService.supabaseClient.auth.onAuthStateChange.listen((data) {
      if (data.event == AuthChangeEvent.signedIn ||
          data.event == AuthChangeEvent.signedOut) {
        fetchUserType();
        fetchCustomerNumber();
      }
    });
  }

  Future<void> fetchUserType() async {
    final user = SupabaseService.supabaseClient.auth.currentUser;
    if (user != null) {
      final response = await SupabaseService.supabaseClient
          .from('users')
          .select('user_type')
          .eq('id', user.id)
          .single();
      if (mounted) {
        setState(() {
          userType = response['user_type'];
        });
      }
    }
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
          customerNumber = response['customer_number']!;
        });
      }
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pagesProspectiveClient = [
      Dashboard(),
      ExplorePage(),
      GeneralEnquiries(),
    ];

    List<Widget> _pagesCurrentTenant = [
      Dashboard(),
      StatementsScreen(customerNumber: customerNumber),
      ServiceRequests(serviceRequests: [], onAddRequest: (ServiceRequest) {}),
      GeneralEnquiries()
    ];

    List<Widget> _pages = userType == 'prospective_client'
        ? _pagesProspectiveClient
        : _pagesCurrentTenant;

    if (_pages.length < 2) {
      _pages = [
        const Center(child: Text('Error Page')),
        const Center(child: Text('Help Page')),
      ];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("BHC House Management"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: RoleBasedNavBar(
        userType: userType,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
