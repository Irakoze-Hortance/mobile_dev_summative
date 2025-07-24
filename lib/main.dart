// main.dart
// Main entry point with authentication state management
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'screens/splash_screen.dart';
import 'screens/auth_screen.dart';
import 'screens/home_screen.dart';
import 'services/auth_service.dart';

void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health App',
      theme: ThemeData(
        primaryColor: const Color(0xFF2D7D79),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF2D7D79),
        ),
        useMaterial3: true,
      ),
      home: const AuthWrapper(),
      // Define named routes for navigation
      routes: {
        '/auth': (context) => const AuthScreen(),
        '/home': (context) => const HomeScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

// Widget to handle authentication state
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    
    return StreamBuilder<User?>(
      // Listen to authentication state changes
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        // Debug: Print auth state
        print('Auth state: ${snapshot.connectionState}');
        print('Has user: ${snapshot.hasData}');
        print('User: ${snapshot.data?.email}');
        
        // Show splash screen while checking auth state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        }
        
        // If user is logged in, show home screen
        if (snapshot.hasData && snapshot.data != null) {
          // Force a slight delay to ensure navigation works
          return const HomeScreen();
        }
        
        // Otherwise, show authentication screen
        return const AuthScreen();
      },
    );
  }
}
