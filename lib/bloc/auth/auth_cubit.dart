import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';
import '../../services/auth_service.dart'; // your existing service

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService = AuthService();

  AuthCubit() : super(const AuthState());

  Future<void> login(String email, String password) async {
    emit(state.copyWith(loading: true, errorMessage: null));
    try {
      await _authService.signIn(email, password);
      emit(state.copyWith(loading: false, isLoggedIn: true));
    } catch (e) {
      emit(state.copyWith(loading: false, errorMessage: e.toString()));
    }
  }

  Future<void> signup(String email, String password) async {
    emit(state.copyWith(loading: true, errorMessage: null));
    try {
      await _authService.signUp(email, password);
      emit(state.copyWith(loading: false, isLoggedIn: true));
    } catch (e) {
      emit(state.copyWith(loading: false, errorMessage: e.toString()));
    }
  }

  void logout() {
    _authService.signOut();
    emit(const AuthState());
  }
}
