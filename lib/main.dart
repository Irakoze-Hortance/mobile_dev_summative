import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'screens/splash_screen.dart';
import 'screens/auth_screen.dart';
import 'screens/home_screen.dart';
import 'screens/appointments_screen.dart';
import 'screens/appointment_form_screen.dart';
import 'screens/mental_health_screen.dart';
import 'screens/health_education_screen.dart';
import 'services/auth_service.dart';
import 'screens/pandemics.dart';
import 'screens/reproductive_health.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        '/appointments': (context) => const AppointmentsScreen(),
        '/appointment-form': (context) => const AppointmentFormScreen(),
        '/mental-health': (context) => const MentalHealthScreen(),
        '/health-education': (context) => const HealthEducationScreen(),
        // Add new routes for Pandemic and Reproductive Health pages
        '/pandemic': (context) => const PandemicPage(),
        '/reproductive-health': (context) => const ReproductiveHealthPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return StreamBuilder<User?>(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
       
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        }

        if (snapshot.hasData && snapshot.data != null) {
          return const HomeScreen();
        }

        return const AuthScreen();
      },
    );
  }
}
