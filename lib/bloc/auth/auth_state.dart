import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  final bool loading;
  final bool isLoggedIn;
  final String? errorMessage;
  final String? username;

  const AuthState({
    this.loading = false,
    this.isLoggedIn = false,
    this.errorMessage,
    this.username
  });

  AuthState copyWith({
    bool? loading,
    bool? isLoggedIn,
    String? errorMessage, required String username,
  }) {
    return AuthState(
      loading: loading ?? this.loading,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      errorMessage: errorMessage,
      username: username ?? this.username
    );
  }

  @override
  List<Object?> get props => [loading, isLoggedIn, errorMessage];
}
