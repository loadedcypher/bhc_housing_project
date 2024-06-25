import 'package:bhc_housing_project/models/property.dart';
import 'package:bhc_housing_project/ui/pages/applications_page.dart';
import 'package:flutter/material.dart';

class PropertyDetailScreen extends StatelessWidget {
  final Property property;

  PropertyDetailScreen({required this.property});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(property.houseType.houseType),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              title: Text('Category'),
              subtitle: Text(property.houseType.category),
            ),
            ListTile(
              title: Text('Price Range'),
              subtitle: Text(
                  '${property.houseType.priceRange!.min} - ${property.houseType.priceRange!.max}'),
            ),
            ListTile(
              title: Text('Built-up Area'),
              subtitle: Text('${property.houseType.builtUpArea} sq. m'),
            ),
            ListTile(
              title: Text('Plot Size'),
              subtitle: Text(
                  '${property.houseType.plotSize!.min} - ${property.houseType.plotSize!.max} sq. m'),
            ),
            ListTile(
              title: Text('Bedrooms'),
              subtitle: Text('${property.houseType.bedrooms}'),
            ),
            ListTile(
              title: Text('Bathrooms'),
              subtitle: Text('${property.houseType.bathrooms}'),
            ),
            ListTile(
              title: Text('Furnished'),
              subtitle: Text(property.houseType.furnished ? 'Yes' : 'No'),
            ),
            ListTile(
              title: Text('Fitted Kitchen'),
              subtitle: Text(property.houseType.fittedKitchen ? 'Yes' : 'No'),
            ),
            ListTile(
              title: Text('Wardrobes'),
              subtitle: Text(property.houseType.wardrobes ? 'Yes' : 'No'),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ApplicationPage(),
                      ));
                },
                child: const Text('Apply for this property'))
          ],
        ),
      ),
    );
  }
}
