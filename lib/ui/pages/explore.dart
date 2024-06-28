import 'package:flutter/material.dart';
import 'package:bhc_housing_project/models/property.dart';
import 'package:bhc_housing_project/services/api_service.dart';
import 'package:bhc_housing_project/ui/pages/property_detail.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key});

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
        automaticallyImplyLeading: false,
        title: const Text('Explore'), // App bar background color
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
                  elevation: 4,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PropertyDetailScreen(property: property),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Image.network(
                            property.imageUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[300],
                                child: const Center(
                                  child: Icon(Icons.error),
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                property.houseType.houseType,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Color(0xFFAC2324), // Title color
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${property.houseType.category} - ${property.availabilityType.capitalize()}',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                property.location,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
