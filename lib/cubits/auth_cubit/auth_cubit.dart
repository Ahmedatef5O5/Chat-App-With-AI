import 'package:chat_app_with_ai/services/auth_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final _authServices = AuthServicesImpl();

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      bool success = await _authServices.loginWithEmailAndPassword(
        email,
        password,
      );
      if (success) {
        emit(AuthSuccess());
      } else {
        emit(AuthFailure("Login failed. Check your credentials."));
      }
    } catch (e) {
      emit(AuthFailure('Login Failed: $e'));
    }
  }

  Future<void> register(String userName, String email, String password) async {
    emit(AuthLoading());
    try {
      bool success = await _authServices.registerWithEmailAndPassword(
        userName,
        email,
        password,
      );
      if (success) {
        emit(AuthSuccess());
      } else {
        emit(AuthFailure("Register failed. Try again."));
      }
    } catch (e) {
      emit(AuthFailure('Register Failed: $e.'));
    }
  }
}
