
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';
import '../../services/auth_service.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService = AuthService();

  AuthCubit() : super(const AuthState());

  Future<void> login(String email, String password) async {
  emit(state.copyWith(loading: true, errorMessage: null, username: ''));

  try {
    await _authService.signInWithEmailAndPassword(email: email, password: password);

    final userData = await _authService.getCurrentUserData();
    final name = userData?['fullName'] ?? email;

    emit(state.copyWith(loading: false, isLoggedIn: true, username: name));
  } catch (e) {
    emit(state.copyWith(loading: false, errorMessage: e.toString(), username: ''));
  }
}

  Future<void> signup(String email, String password, String fullName) async {
    emit(state.copyWith(loading: true, errorMessage: null, username: fullName));
    try {
      await _authService.registerWithEmailAndPassword(
        email: email,
        password: password,
        fullName: fullName,
      );
      emit(state.copyWith(loading: false, isLoggedIn: true, username: fullName));
    } catch (e) {
      emit(state.copyWith(loading: false, errorMessage: e.toString(), username: fullName));
    }
  }

  void logout() {
    _authService.signOut();
    emit(const AuthState());
  }
}
