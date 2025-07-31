// auth_service.dart
// Service class to handle all Firebase authentication operations
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class AuthService {
  // Firebase Auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  // Firestore instance for storing user data
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Stream to listen to authentication state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign in with email and password
  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      // Debug: Log sign in attempt
      
      // Attempt to sign in user
      final UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      
      // Debug: Log successful sign in
      
      return result.user;
    } on FirebaseAuthException catch (e) {
      // Debug: Log Firebase auth error
      
      // Handle specific Firebase auth errors
      throw _handleAuthException(e);
    } catch (e) {
      // Debug: Log unexpected error with stack trace
      
      // This might be a type casting issue in Firebase
      // Try to work around it by checking the current auth state
      try {
        final currentUser = _auth.currentUser;
        if (currentUser != null && currentUser.email == email.trim()) {
          return currentUser;
        }
      } catch (_) {
        // Ignore any errors in the workaround
      }
      
      // Handle any other errors
      throw 'Authentication failed. Please try again or restart the app.';
    }
  }

  // Register with email and password
  Future<User?> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      // Create user account
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );


      // // Store additional user data in Firestore
      // if (result.user != null) {
      //   await _firestore.collection('users').doc(result.user!.uid).set({
      //     'uid': result.user!.uid,
      //     'email': email.trim(),
      //     'fullName': fullName,
      //     'createdAt': FieldValue.serverTimestamp(),
      //   });
      // }
      
      return result.user;
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase auth errors
      throw _handleAuthException(e);
    } catch (e, stackTrace) {
      // Handle any other errors
      debugPrint('$e');
      debugPrintStack(stackTrace: stackTrace);
      throw 'An unexpected error occurred. Please try again.';
    }
  }

  // Send password reset email
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase auth errors
      throw _handleAuthException(e);
    } catch (e) {
      // Handle any other errors
      throw 'An unexpected error occurred. Please try again.';
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw 'Error signing out. Please try again.';
    }
  }

  // Get current logged in user data from Firestore
  Future<Map<String, dynamic>?> getCurrentUserData() async {
    try {
      if (currentUser != null) {
        final DocumentSnapshot doc = await _firestore
            .collection('users')
            .doc(currentUser!.uid)
            .get();
        
        if (doc.exists) {
          return doc.data() as Map<String, dynamic>;
        }
      }
      return null;
    } catch (e) {
      throw 'Error fetching user data. Please try again.';
    }
  }

  // Handle Firebase Auth exceptions and return user-friendly messages
  String _handleAuthException(FirebaseAuthException e) {
    // Log the error for debugging
    
    switch (e.code) {
      case 'user-not-found':
        return 'No user found with this email address.';
      case 'wrong-password':
        return 'Invalid password. Please try again.';
      case 'email-already-in-use':
        return 'This email is already registered. Please sign in instead.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'weak-password':
        return 'Password is too weak. Please use at least 6 characters.';
      case 'network-request-failed':
        return 'Network error. Please check your internet connection.';
      case 'too-many-requests':
        return 'Too many failed attempts. Please try again later.';
      case 'user-disabled':
        return 'This account has been disabled. Please contact support.';
      case 'unknown':
        // This often indicates reCAPTCHA issues
        if (e.message != null && e.message!.contains('CONFIGURATION_NOT_FOUND')) {
          return 'App configuration error. Please ensure SHA certificates are added to Firebase Console.';
        }
        return 'Authentication configuration error. Please check Firebase setup.';
      default:
        return 'Authentication error: ${e.message}';
    }
  }

  }
