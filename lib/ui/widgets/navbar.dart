import 'package:flutter/material.dart';

class RoleBasedNavBar extends StatelessWidget {
  final String userType;

  RoleBasedNavBar({required this.userType});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: _getNavBarItems(userType),
    );
  }

  List<BottomNavigationBarItem> _getNavBarItems(String userType) {
    List<BottomNavigationBarItem> items;

    if (userType == 'prospective_client') {
      items = [
        const BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: 'Users',
        ),
      ];
    } else if (userType == 'current_tenant') {
      items = [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ];
    } else {
      items = [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.info),
          label: 'Info',
        ),
      ];
    }

    // Ensure there are always at least two items
    if (items.length < 2) {
      items.add(const BottomNavigationBarItem(
        icon: Icon(Icons.info),
        label: 'Info',
      ));

      items.add(const BottomNavigationBarItem(
        icon: Icon(Icons.polymer),
        label: 'Polymer',
      ));
    }

    return items;
  }
}
