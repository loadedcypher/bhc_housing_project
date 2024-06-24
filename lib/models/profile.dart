class Profile {
  String id;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String nationalId;
  String role;

  Profile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.nationalId,
    required this.role,
  });

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      id: map['id'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      email: map['email'],
      phoneNumber: map['phone_number'],
      nationalId: map['national_id'],
      role: map['role'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone_number': phoneNumber,
      'national_id': nationalId,
      'role': role,
    };
  }
}
