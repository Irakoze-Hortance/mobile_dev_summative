import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState extends Equatable {
  final bool obscurePassword;
  final bool obscureConfirmPassword;

  const AuthState({
    this.obscurePassword = true,
    this.obscureConfirmPassword = true,
  });

  @override
  List<Object?> get props => [obscurePassword, obscureConfirmPassword];
}

class AuthInitial extends AuthState {
  const AuthInitial() : super();
}

class AuthLoading extends AuthState {
  const AuthLoading({
    super.obscurePassword,
    super.obscureConfirmPassword,
  });
}

class AuthSuccess extends AuthState {
  final User user;
  final String message;

  const AuthSuccess({
    required this.user,
    required this.message,
    super.obscurePassword,
    super.obscureConfirmPassword,
  });

  @override
  List<Object?> get props => [user, message, ...super.props];
}

class AuthFailure extends AuthState {
  final String error;

  const AuthFailure({
    required this.error,
    super.obscurePassword,
    super.obscureConfirmPassword,
  });

  @override
  List<Object?> get props => [error, ...super.props];
}

class AuthPasswordVisibilityChanged extends AuthState {
  const AuthPasswordVisibilityChanged({
    required super.obscurePassword,
    required super.obscureConfirmPassword,
  });
}
