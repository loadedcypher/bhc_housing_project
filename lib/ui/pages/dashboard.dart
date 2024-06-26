import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  final String userName;
  final String? propertyPlotNumber;
  final String? propertyRegion;
  final String? propertyLocation;

  const Dashboard({
    Key? key,
    this.userName = 'Guest', // Placeholder for name
    this.propertyPlotNumber,
    this.propertyRegion,
    this.propertyLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: const Color(0xFFAC2324),
      ),
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
            _buildCardsColumn(),
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
          style: TextStyle(
            fontSize: 18.0,
            color: const Color(0xFF1E1E1E),
          ),
          children: [
            TextSpan(text: 'Welcome, '),
            TextSpan(
              text: userName, // Display the user's name here
              style: TextStyle(color: const Color(0xFFAC2324)),
            ),
            TextSpan(text: '!'),
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
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Property Details',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Plot Number: $propertyPlotNumber\n'
              'Region: $propertyRegion\n'
              'Location: $propertyLocation',
              style: const TextStyle(fontSize: 12.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDividerWithText(String text) {
    return Row(
      children: [
        Expanded(
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
        Expanded(
          child: Divider(
            color: Colors.black,
            height: 20,
          ),
        ),
      ],
    );
  }

  Widget _buildCardsColumn() {
    return Column(
      children: [
        _buildServiceCard(
          iconPath: 'lib/ui/assets/generalEnquiries.png',
          // Remove color property as entire PNG will cover the card
        ),
        const SizedBox(height: 16.0),
        _buildServiceCard(
          iconPath: 'lib/ui/assets/serviceRequest.png',
          // Remove color property as entire PNG will cover the card
        ),
        const SizedBox(height: 16.0),
        _buildServiceCard(
          iconPath: 'lib/ui/assets/statements.png',
          // Remove color property as entire PNG will cover the card
        ),
      ],
    );
  }

  Widget _buildServiceCard({
    required String iconPath,
  }) {
    return Card(
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
            width: 360, // Adjust width as needed
            height: 137, // Adjust height as needed
            fit: BoxFit.contain, // Cover the entire card with the image
          ),
          const SizedBox(height: 8.0),
          
        ],
      ),
    );
  }
}
