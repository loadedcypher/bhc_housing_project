import 'package:flutter/material.dart';
import 'package:bhc_housing_project/models/property.dart';
import 'package:bhc_housing_project/ui/widgets/CompanyLeaseApplicationForm.dart';
import 'package:bhc_housing_project/ui/widgets/IndividualLeaseApplicationForm.dart';

class PropertyDetailScreen extends StatelessWidget {
  final Property property;

  const PropertyDetailScreen({Key? key, required this.property})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          property.houseType.houseType,
          style: TextStyle(
            color: Color(0xFFAC2324), // Title color
          ),
        ), // App bar background color
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageSection(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailSection(),
                  const SizedBox(height: 20),
                  _buildApplyButton(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Image.network(
        property.imageUrl!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[300],
            child: const Center(
              child: Icon(Icons.error, size: 50, color: Colors.grey),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailSection() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailItem('Category', property.houseType.category),
            _buildDetailItem('Price Range',
                '${property.houseType.priceRange!.min} - ${property.houseType.priceRange!.max}'),
            _buildDetailItem(
                'Built-up Area', '${property.houseType.builtUpArea} sq. m'),
            _buildDetailItem('Plot Size',
                '${property.houseType.plotSize!.min} - ${property.houseType.plotSize!.max} sq. m'),
            _buildDetailItem(
                'Bedrooms', property.houseType.bedrooms.toString()),
            _buildDetailItem(
                'Bathrooms', property.houseType.bathrooms.toString()),
            _buildDetailItem(
                'Furnished', property.houseType.furnished ? 'Yes' : 'No'),
            _buildDetailItem('Fitted Kitchen',
                property.houseType.fittedKitchen ? 'Yes' : 'No'),
            _buildDetailItem(
                'Wardrobes', property.houseType.wardrobes ? 'Yes' : 'No'),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildApplyButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(children: [
        ElevatedButton(
          onPressed: () {
            showIndividualLeaseApplicationDialog(context);
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFAC2324),
              foregroundColor: Color(0xFFFAA21B) // Button background color
              ),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: Text('Apply for this Individually',
                style: TextStyle(fontSize: 16)),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        ElevatedButton(
          onPressed: () {
            showCompanyLeaseApplicationDialog(context);
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFFAA21B),
              foregroundColor: Color(0xFFAC2324) // Button background color
              ),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: Text('Apply for this property as a Company',
                style: TextStyle(fontSize: 16)),
          ),
        ),
      ]),
    );
  }
}
