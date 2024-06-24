import 'package:bhc_housing_project/providers/auth_provider.dart';
import 'package:bhc_housing_project/services/supabase_service.dart';
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

  @override
  void dispose() {
    // Add any necessary cleanup here
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome'),
            ElevatedButton(
              onPressed: () async {
                final authProvider =
                    Provider.of<AuthProvider>(context, listen: false);
                await authProvider.logout();
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: RoleBasedNavBar(
        userType: userType,
      ),
    );
  }
}
