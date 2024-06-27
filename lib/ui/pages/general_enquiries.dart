import 'package:flutter/material.dart';

class GeneralEnquiries extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('General Enquiries'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView(
                children: [
                  _buildEnquiryCard(
                    context,
                    icon: Icons.business,
                    title: 'BHC Products',
                    route: '/bhc-products',
                  ),
                  _buildEnquiryCard(
                    context,
                    icon: Icons.assignment,
                    title: 'Application Procedures',
                    route: '/application-procedures',
                  ),
                  _buildEnquiryCard(
                    context,
                    icon: Icons.check_circle,
                    title: 'Eligibility Criteria',
                    route: '/eligibility-criteria',
                  ),
                  _buildEnquiryCard(
                    context,
                    icon: Icons.home_work,
                    title: 'Housing Developments',
                    route: '/housing-developments',
                  ),
                  _buildEnquiryCard(
                    context,
                    icon: Icons.help,
                    title: 'FAQs',
                    route: '/faqs',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEnquiryCard(BuildContext context,
      {required IconData icon, required String title, required String route}) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 4.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 40.0, color: const Color(0xFFAC2324)),
              const SizedBox(width: 16.0),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
