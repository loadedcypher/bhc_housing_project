import 'package:flutter/material.dart';

class RoleBasedNavBar extends StatelessWidget {
  final String userType;
  final int currentIndex;
  final Function(int) onTap;

  const RoleBasedNavBar({
    Key? key,
    required this.userType,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> items = [
      BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
    ];

    if (userType == 'prospective_client') {
      items.addAll([
        const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Explore'),
        const BottomNavigationBarItem(
            icon: Icon(Icons.settings), label: 'General Enquiries'),
      ]);
    } else if (userType == 'current_tenant') {
      items.addAll([
        const BottomNavigationBarItem(
            icon: Icon(Icons.edit_document), label: 'Statements'),
        const BottomNavigationBarItem(
            icon: Icon(Icons.warning), label: 'Service Requests'),
      ]);
    }

    // Ensure at least 2 items to prevent assertion error
    if (items.length < 2) {
      return const Text('Loading....');
    }

    return BottomNavigationBar(
      items: items,
      currentIndex: currentIndex,
      selectedItemColor: Colors.amber[800],
      onTap: onTap,
    );
  }
}
