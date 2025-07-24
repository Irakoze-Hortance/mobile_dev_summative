// auth_utils.dart
// Utility functions for authentication
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class AuthUtils {
  // Singleton instance
  static final AuthUtils _instance = AuthUtils._internal();
  factory AuthUtils() => _instance;
  AuthUtils._internal();

  // Auth service instance
  final AuthService _authService = AuthService();

  // Get current logged in user
  User? getCurrentUser() {
    return _authService.currentUser;
  }

  // Check if user is logged in
  bool isLoggedIn() {
    return getCurrentUser() != null;
  }

  // Get current user ID
  String? getCurrentUserId() {
    return getCurrentUser()?.uid;
  }

  // Get current user email
  String? getCurrentUserEmail() {
    return getCurrentUser()?.email;
  }

  // Get current user display name
  String? getCurrentUserDisplayName() {
    return getCurrentUser()?.displayName;
  }

  // Get current user data from Firestore
  Future<Map<String, dynamic>?> getCurrentUserData() async {
    return await _authService.getCurrentUserData();
  }

  // Listen to auth state changes
  Stream<User?> authStateChanges() {
    return _authService.authStateChanges;
  }
}

// Global instance for easy access
final authUtils = AuthUtils();
