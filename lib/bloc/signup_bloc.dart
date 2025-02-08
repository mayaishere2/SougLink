import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souglink/repository/user_repository.dart';
import '../models/user.dart';
import 'signup_event.dart';
import 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final UserRepository _userRepository = UserRepository();

  SignupBloc() : super(SignupInitial()) {
    // Register the event handler
    on<SignupButtonPressed>(_onSignupButtonPressed);
  }

  Future<void> _onSignupButtonPressed(
    SignupButtonPressed event,
    Emitter<SignupState> emit,
  ) async {
    print("Signup process started for username: ${event.username}");
    try {
      final existingUser = await _userRepository.getUserByUsername(event.username);
      if (existingUser != null) {
        emit(SignupFailure(error: 'Username already taken'));
      } else {
        final user = User(
          username: event.username,
          firstName: event.firstName,
          lastName: event.lastName,
          phoneNumber: event.phoneNumber,
          dateOfBirth: event.dateOfBirth,
          password: event.password,
          userType: event.userType,
        );
        print("Attempting to register user: ${user.username}");
        final result = await _userRepository.registerUser(user);
        print("User registration result: $result");
        print("User registered successfully, emitting SignupSuccess");
        emit(SignupSuccess());
      }
    } catch (e) {
      emit(SignupFailure(error: e.toString()));
    }
  }
}
