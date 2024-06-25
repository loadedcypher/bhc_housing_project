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
  int _selectedIndex = 0;

  void _logout(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    await authProvider.logout();

    Navigator.pushReplacementNamed(context, '/login');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Logged out")),
    );
    // Navigate to the login page or perform any other logout actions
  }

  @override
  void initState() {
    super.initState();
    fetchUserType();
    SupabaseService.supabaseClient.auth.onAuthStateChange.listen((data) {
      if (data.event == AuthChangeEvent.signedIn ||
          data.event == AuthChangeEvent.signedOut) {
        fetchUserType();
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Define the pages based on user type
    List<Widget> _pagesProspectiveClient = [
      const Dashboard(),
      ExplorePage(),
      const GeneralEnquiries(),
    ];

    List<Widget> _pagesCurrentTenant = [
      const Dashboard(),
      const StatementsPage(),
      const ServiceRequest(),
    ];

    List<Widget> _pages = userType == 'prospective_client'
        ? _pagesProspectiveClient
        : _pagesCurrentTenant;

    // Ensure at least 2 pages to prevent index errors
    if (_pages.length < 2) {
      _pages = [
        const Center(child: Text('Error Page')),
        const Center(child: Text('Help Page')),
      ];
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            onSelected: (String result) {
              if (result == 'logout') {
                _logout(context);
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'logout',
                child: Text('Logout'),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: RoleBasedNavBar(
        userType: userType,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
