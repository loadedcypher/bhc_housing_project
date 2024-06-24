class User {
  final String? id;
  final String firstName;
  final String lastName;
  final String email;
  final String omangNumber;
  final String phoneNumber;
  final String userType;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.omangNumber,
    required this.phoneNumber,
    required this.userType,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      omangNumber: json['omang_number'],
      phoneNumber: json['phone_number'],
      userType: json['user_type'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'omang_number': omangNumber,
      'phone_number': phoneNumber,
      'user_type': userType,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
