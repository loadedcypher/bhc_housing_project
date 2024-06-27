import 'package:bhc_housing_project/models/service_requests.dart';
import 'package:bhc_housing_project/ui/pages/servicereqform.dart';
import 'package:flutter/material.dart';

class ServiceRequests extends StatelessWidget {
  final List<ServiceRequest> serviceRequests;
  final Function(ServiceRequest) onAddRequest;

  const ServiceRequests({super.key, required this.serviceRequests, required this.onAddRequest});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Requests'),
        backgroundColor: const Color(0xFFAC2324),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: serviceRequests.length,
          itemBuilder: (context, index) {
            final request = serviceRequests[index];
            return _buildServiceRequestCard(
              context,
              type: request.type,
              description: request.description,
              status: request.status,
              referenceNumber: request.referenceNumber,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newRequest = await Navigator.push<ServiceRequest?>(
            context,
            MaterialPageRoute(
              builder: (context) => const ServiceReqFormPage(),
            ),
          );
          if (newRequest != null) {
            onAddRequest(newRequest);
          }
        },
        backgroundColor: const Color(0xFFAC2324),
        child: const Icon(Icons.build),
      ),
    );
  }

  Widget _buildServiceRequestCard(
    BuildContext context, {
    required String type,
    required String description,
    required String status,
    required String referenceNumber,
  }) {
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
            Row(
              children: [
                const Icon(
                  Icons.warning, // Change icon based on type
                  size: 40.0,
                  color: Color(0xFFAC2324),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        type,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        description,
                        style: const TextStyle(fontSize: 12.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Text(
              'Status: $status',
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Reference Number: $referenceNumber',
              style: const TextStyle(fontSize: 12.0),
            ),
          ],
        ),
      ),
    );
  }
}
