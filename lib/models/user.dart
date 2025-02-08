class User {
  final int? id;
  final String username;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String dateOfBirth;
  final String password;
  final String userType; // "farmer" or "market seller"

  User({
    this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.password,
    required this.userType,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'date_of_birth': dateOfBirth,
      'password': password,
      'user_type': userType,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      phoneNumber: map['phone_number'],
      dateOfBirth: map['date_of_birth'],
      password: map['password'],
      userType: map['user_type'],
    );
  }
}
