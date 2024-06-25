class Property {
  final int propertyId;
  final String location;
  final String availabilityType;
  final HouseType houseType;

  Property({
    required this.propertyId,
    required this.location,
    required this.availabilityType,
    required this.houseType,
  });

  factory Property.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw FormatException('Failed to load property: JSON is null');
    }

    return Property(
      propertyId: json['property_id'] ?? 0,
      location: json['location'] ?? '',
      availabilityType: json['availability_type'] ?? '',
      houseType: HouseType.fromJson(json['house_type'] as Map<String, dynamic>),
    );
  }
}

class HouseType {
  final String houseType;
  final String category;
  final PriceRange? priceRange; // Make PriceRange nullable
  final int builtUpArea;
  final PlotSize? plotSize; // Make PlotSize nullable
  final int bedrooms;
  final bool furnished;
  final bool fittedKitchen;
  final bool wardrobes;
  final bool garage;
  final bool carport;
  final String floorFinish;
  final bool servantsQuarters;
  final bool screenWall;
  final bool fence;
  final bool swimmingPool;
  final bool scullery;
  final bool fireplace;
  final bool diningRoom;
  final bool enSuite;
  final int bathrooms;

  HouseType({
    required this.houseType,
    required this.category,
    this.priceRange,
    required this.builtUpArea,
    this.plotSize,
    required this.bedrooms,
    required this.furnished,
    required this.fittedKitchen,
    required this.wardrobes,
    required this.garage,
    required this.carport,
    required this.floorFinish,
    required this.servantsQuarters,
    required this.screenWall,
    required this.fence,
    required this.swimmingPool,
    required this.scullery,
    required this.fireplace,
    required this.diningRoom,
    required this.enSuite,
    required this.bathrooms,
  });

  factory HouseType.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw FormatException('Failed to load house type: JSON is null');
    }

    return HouseType(
      houseType: json['houseType'] ?? '',
      category: json['category'] ?? '',
      priceRange: json['priceRange'] != null
          ? PriceRange.fromJson(json['priceRange'] as Map<String, dynamic>)
          : null,
      builtUpArea: json['builtUpArea'] ?? 0,
      plotSize: json['plotSize'] != null
          ? PlotSize.fromJson(json['plotSize'] as Map<String, dynamic>)
          : null,
      bedrooms: json['bedrooms'] ?? 0,
      furnished: json['furnished'] ?? false,
      fittedKitchen: json['fittedKitchen'] ?? false,
      wardrobes: json['wardrobes'] ?? false,
      garage: json['garage'] ?? false,
      carport: json['carport'] ?? false,
      floorFinish: json['floorFinish'] ?? '',
      servantsQuarters: json['servantsQuarters'] ?? false,
      screenWall: json['screenWall'] ?? false,
      fence: json['fence'] ?? false,
      swimmingPool: json['swimmingPool'] ?? false,
      scullery: json['scullery'] ?? false,
      fireplace: json['fireplace'] ?? false,
      diningRoom: json['diningRoom'] ?? false,
      enSuite: json['enSuite'] ?? false,
      bathrooms: json['bathrooms'] ?? 0,
    );
  }
}

class PriceRange {
  final int min;
  final int max;

  PriceRange({
    required this.min,
    required this.max,
  });

  factory PriceRange.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw FormatException('Failed to load price range: JSON is null');
    }

    return PriceRange(
      min: json['min'] ?? 0,
      max: json['max'] ?? 0,
    );
  }
}

class PlotSize {
  final int min;
  final int max;

  PlotSize({
    required this.min,
    required this.max,
  });

  factory PlotSize.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw FormatException('Failed to load plot size: JSON is null');
    }

    return PlotSize(
      min: json['min'] ?? 0,
      max: json['max'] ?? 0,
    );
  }
}
