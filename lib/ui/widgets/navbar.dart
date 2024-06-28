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
      const BottomNavigationBarItem(
          icon: Icon(Icons.dashboard), label: 'Dashboard'),
      const BottomNavigationBarItem(icon: Icon(Icons.help), label: 'Help'),
    ];

    if (userType == 'prospective_client') {
      items = [
        items[0],
        const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Explore'),
        const BottomNavigationBarItem(
            icon: Icon(Icons.info), label: 'General Enquiries'),
      ];
    } else if (userType == 'current_tenant') {
      items = [
        items[0],
        const BottomNavigationBarItem(
            icon: Icon(Icons.edit_document), label: 'Edit Document'),
        const BottomNavigationBarItem(
            icon: Icon(Icons.warning), label: 'Service Requests'),
        const BottomNavigationBarItem(
            icon: Icon(Icons.info), label: 'General Enquiries'),
      ];
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: items,
            currentIndex: currentIndex,
            selectedItemColor: Colors.amber[800],
            unselectedItemColor: Colors.grey,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
