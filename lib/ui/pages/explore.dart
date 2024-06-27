import 'package:bhc_housing_project/models/property.dart';
import 'package:bhc_housing_project/services/api_service.dart';
import 'package:bhc_housing_project/ui/pages/property_detail.dart';
import 'package:flutter/material.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  late Future<List<Property>> futureProperties;
  String selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    futureProperties = ApiService.fetchProperties();
  }

  List<Property> filterProperties(List<Property> properties, String filter) {
    if (filter == 'All') {
      return properties;
    } else {
      return properties
          .where((property) =>
              property.availabilityType ==
              filter.toLowerCase().replaceAll(' ', '_'))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore'),
        automaticallyImplyLeading: false,
        actions: [
          DropdownButton<String>(
            value: selectedFilter,
            icon: const Icon(Icons.filter_list),
            items: <String>['All', 'For Rent', 'For Sale']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedFilter = newValue!;
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Property>>(
        future: futureProperties,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Property> filteredProperties =
                filterProperties(snapshot.data!, selectedFilter);
            return ListView.builder(
              itemCount: filteredProperties.length,
              itemBuilder: (context, index) {
                final property = filteredProperties[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: ListTile(
                    title: Text(property.houseType.houseType,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                        '${property.houseType.category} - ${property.availabilityType.capitalize()}'),
                    trailing: const Icon(Icons.arrow_forward),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PropertyDetailScreen(property: property),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
