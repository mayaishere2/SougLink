import 'package:bloc/bloc.dart';
import '../models/user.dart';
import '../repository/user_repository.dart';

enum UserStatus { initial, loading, success, error }

class UserState {
  final UserStatus status;
  final String? message;
  final User? user;

  UserState({required this.status, this.message, this.user});

  UserState copyWith({UserStatus? status, String? message, User? user}) {
    return UserState(
      status: status ?? this.status,
      message: message ?? this.message,
      user: user ?? this.user,
    );
  }
}

class UserCubit extends Cubit<UserState> {
  final UserRepository repository;

  UserCubit(this.repository) : super(UserState(status: UserStatus.initial));

  // Register a new user
  void registerUser(User user) async {
    emit(state.copyWith(status: UserStatus.loading));
    try {
      final result = await repository.registerUser(user);
      if (result > 0) {
        emit(state.copyWith(
          status: UserStatus.success,
          message: 'User registered successfully!',
        ));
      } else {
        emit(state.copyWith(
          status: UserStatus.error,
          message: 'Failed to register user.',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: UserStatus.error,
        message: 'Error: ${e.toString()}',
      ));
    }
  }

  // Login user
  void loginUser(String username, String password) async {
    emit(state.copyWith(status: UserStatus.loading));
    try {
      final user = await repository.validateLogin(username, password);
      if (user != null) {
        emit(state.copyWith(
          status: UserStatus.success,
          user: user,
        ));
      } else {
        emit(state.copyWith(
          status: UserStatus.error,
          message: 'Invalid username or password.',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: UserStatus.error,
        message: 'Error: ${e.toString()}',
      ));
    }
  }
}
