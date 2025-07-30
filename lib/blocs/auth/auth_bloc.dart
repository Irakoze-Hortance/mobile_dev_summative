import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_app/blocs/auth/auth_event.dart';
import 'package:health_app/blocs/auth/auth_state.dart';
import 'package:health_app/services/auth_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService = AuthService();

  AuthBloc() : super(const AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading(
      obscurePassword: state.obscurePassword,
      obscureConfirmPassword: state.obscureConfirmPassword,
    ));

    try {
      final user = await _authService.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      if (user != null) {
        emit(AuthSuccess(
          user: user,
          message: 'Login successful!',
          obscurePassword: state.obscurePassword,
          obscureConfirmPassword: state.obscureConfirmPassword,
        ));
      } else {
        emit(AuthFailure(
          error: 'Login failed. Please try again.',
          obscurePassword: state.obscurePassword,
          obscureConfirmPassword: state.obscureConfirmPassword,
        ));
      }
    } catch (e) {
      // Handle the specific error case from the original code
      if (e.toString().contains("type 'List<Object?>' is not a subtype")) {
        try {
          await Future.delayed(const Duration(milliseconds: 500));
          final currentUser = _authService.currentUser;
          
          if (currentUser != null && currentUser.email == event.email.trim()) {
            emit(AuthSuccess(
              user: currentUser,
              message: 'Login successful!',
              obscurePassword: state.obscurePassword,
              obscureConfirmPassword: state.obscureConfirmPassword,
            ));
            return;
          }
        } catch (_) {
          // Ignore secondary error
        }
      }
      
      emit(AuthFailure(
        error: e.toString(),
        obscurePassword: state.obscurePassword,
        obscureConfirmPassword: state.obscureConfirmPassword,
      ));
    }
  }

  Future<void> _onSignUpRequested(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading(
      obscurePassword: state.obscurePassword,
      obscureConfirmPassword: state.obscureConfirmPassword,
    ));

    try {
      final user = await _authService.registerWithEmailAndPassword(
        email: event.email,
        password: event.password,
        fullName: event.fullName,
      );

      if (user != null) {
        emit(AuthSuccess(
          user: user,
          message: 'Registration successful! Welcome!',
          obscurePassword: state.obscurePassword,
          obscureConfirmPassword: state.obscureConfirmPassword,
        ));
      } else {
        emit(AuthFailure(
          error: 'Registration failed. Please try again.',
          obscurePassword: state.obscurePassword,
          obscureConfirmPassword: state.obscureConfirmPassword,
        ));
      }
    } catch (e) {
      emit(AuthFailure(
        error: e.toString(),
        obscurePassword: state.obscurePassword,
        obscureConfirmPassword: state.obscureConfirmPassword,
      ));
    }
  }

  void _onTogglePasswordVisibility(
    TogglePasswordVisibility event,
    Emitter<AuthState> emit,
  ) {
    final newObscurePassword = event.field == 'password' 
        ? !state.obscurePassword 
        : state.obscurePassword;
    final newObscureConfirmPassword = event.field == 'confirmPassword' 
        ? !state.obscureConfirmPassword 
        : state.obscureConfirmPassword;

    emit(AuthPasswordVisibilityChanged(
      obscurePassword: newObscurePassword,
      obscureConfirmPassword: newObscureConfirmPassword,
    ));
  }

  void _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) {
    final currentUser = _authService.currentUser;
    
    if (currentUser != null) {
      emit(AuthSuccess(
        user: currentUser,
        message: 'Already logged in as: ${currentUser.email}',
        obscurePassword: state.obscurePassword,
        obscureConfirmPassword: state.obscureConfirmPassword,
      ));
    } else {
      emit(AuthFailure(
        error: 'No user currently logged in',
        obscurePassword: state.obscurePassword,
        obscureConfirmPassword: state.obscureConfirmPassword,
      ));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _authService.signOut();
      emit(const AuthInitial());
    } catch (e) {
      emit(AuthFailure(
        error: e.toString(),
        obscurePassword: state.obscurePassword,
        obscureConfirmPassword: state.obscureConfirmPassword,
      ));
    }
  }
}
