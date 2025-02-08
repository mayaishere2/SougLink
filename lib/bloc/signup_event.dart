abstract class SignupEvent {}

class SignupButtonPressed extends SignupEvent {
  final String username;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String dateOfBirth;
  final String password;
  final String userType;

  SignupButtonPressed({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.password,
    required this.userType,
  });
}
