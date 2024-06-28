import 'package:flutter/material.dart';
import 'package:bhc_housing_project/models/property.dart';
import 'package:bhc_housing_project/ui/widgets/CompanyLeaseApplicationForm.dart';
import 'package:bhc_housing_project/ui/widgets/CompanySaleApplicationForm.dart';
import 'package:bhc_housing_project/ui/widgets/IndividualLeaseApplicationForm.dart';
import 'package:bhc_housing_project/ui/widgets/IndividualSaleApplicationForm.dart';

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
    bool isForRent = property.availabilityType == 'for_rent';
    bool isForSale = property.availabilityType == 'for_sale';

    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          if (isForRent) ...[
            _buildStyledButton(
              context,
              'Apply To Rent as An Individual',
              Color(0xFFAC2324),
              Color(0xFFFAA21B),
              showIndividualLeaseApplicationDialog,
            ),
            const SizedBox(height: 10.0),
            _buildStyledButton(
              context,
              'Apply to Rent as a Company',
              Color(0xFFFAA21B),
              Color(0xFFAC2324),
              showCompanyLeaseApplicationDialog,
            ),
            const SizedBox(height: 10.0),
          ],
          if (isForSale) ...[
            _buildStyledButton(
              context,
              'Apply to Buy as an Individual',
              Color(0xFFAC2324),
              Color(0xFFFAA21B),
              showPersonalApplicationFormDialog,
            ),
            const SizedBox(height: 10.0),
            _buildStyledButton(
              context,
              'Apply to Buy as a Company',
              Color(0xFFFAA21B),
              Color(0xFFAC2324),
              showCompanySalesApplicationFormDialog,
            ),
            const SizedBox(height: 10.0),
          ],
        ],
      ),
    );
  }

  Widget _buildStyledButton(
    BuildContext context,
    String text,
    Color backgroundColor,
    Color foregroundColor,
    Function(BuildContext) onPressed,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ElevatedButton(
        onPressed: () => onPressed(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
