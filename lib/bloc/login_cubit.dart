import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/databases/database_user.dart'; // For database operations
import '/models/user.dart'; // Your User model

// Define Login States
abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccessFarmer extends LoginState {
  final User user; // The user who logged in
  const LoginSuccessFarmer(this.user);

  @override
  List<Object?> get props => [user];
}

class LoginSuccessSeller extends LoginState {
  final User user; // The user who logged in
  const LoginSuccessSeller(this.user);

  @override
  List<Object?> get props => [user];
}

class LoginFailure extends LoginState {
  final String error; // Error message
  const LoginFailure(this.error);

  @override
  List<Object?> get props => [error];
}

// Define LoginCubit
class LoginCubit extends Cubit<LoginState> {
  final UserDatabase userDatabase; // Inject database dependency

  LoginCubit(this.userDatabase) : super(LoginInitial());

  // Login Method
  Future<void> login(String username, String password) async {
    emit(LoginLoading()); // Emitting loading state before login process
    try {
      // Fetch user from the database
      final user = await userDatabase.validateLogin(username, password);

      if (user != null && user.password == password) {
        // Check if user is a farmer or seller and emit respective success state
        if (user.userType == 'farmer') {
          emit(LoginSuccessFarmer(user)); // Emit success with farmer user details
        } else if (user.userType == 'seller') {
          emit(LoginSuccessSeller(user)); // Emit success with seller user details
        }
      } else {
        emit(LoginFailure('Invalid username or password.'));
      }
    } catch (e) {
      emit(LoginFailure('An error occurred: $e'));
    }
  }
}
