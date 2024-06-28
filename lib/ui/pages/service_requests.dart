import 'package:flutter/material.dart';
import 'package:bhc_housing_project/models/service_request.dart';
import 'package:bhc_housing_project/ui/pages/servicereqform.dart';

class ServiceRequests extends StatefulWidget {
  final List<ServiceRequest> serviceRequests;
  final Function(ServiceRequest) onAddRequest;

  const ServiceRequests({
    super.key,
    required this.serviceRequests,
    required this.onAddRequest,
  });

  @override
  _ServiceRequestsState createState() => _ServiceRequestsState();
}

class _ServiceRequestsState extends State<ServiceRequests> {
  List<ServiceRequest> _serviceRequests = [];

  @override
  void initState() {
    super.initState();
    _serviceRequests = widget.serviceRequests;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        flexibleSpace: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'lib/ui/assets/serviceRequestTopBar.png', // Replace with your image asset path
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              height: 300, // Increase the height to your desired size
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: _serviceRequests.length,
          itemBuilder: (context, index) {
            final request = _serviceRequests[index];
            return _buildServiceRequestCard(
              context,
              type: request.type,
              description: request.description,
              status: request.status,
              referenceNumber: request.reference_number,
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
            widget.onAddRequest(newRequest);
            setState(() {
              _serviceRequests.add(newRequest);
            });
          }
        },
        backgroundColor: const Color(0xFFFAA21B),
        child: const Icon(Icons.add, color: Colors.white),
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
      borderRadius: BorderRadius.circular(12.0),
    ),
    elevation: 6.0,
    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        gradient: LinearGradient(
          colors: [Colors.white, Colors.grey.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFAC2324).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: const Icon(
                    Icons.build,
                    size: 32.0,
                    color: Color(0xFFAC2324),
                  ),
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
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        description,
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(
              color: Colors.black26,
              height: 24.0,
            ),
            Text(
              'Status: $status',
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 127, 127, 127),
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Reference Number: $referenceNumber',
              style: const TextStyle(
                fontSize: 12.0,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
  }

