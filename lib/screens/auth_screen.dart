
import 'package:flutter/material.dart';
import 'package:health_app/services/auth_service.dart';
import 'package:health_app/widgets/login_tab.dart';
import 'package:health_app/widgets/signup_tab.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _checkCurrentUser();
  }
  
  // Check if user is already logged in
  void _checkCurrentUser() {
    final currentUser = _authService.currentUser;
    if (currentUser != null) {
      print('User already logged in: ${currentUser.email}');
      // Optional: Auto-navigate to home if already logged in
      // WidgetsBinding.instance.addPostFrameCallback((_) {
      //   Navigator.pushReplacementNamed(context, '/home');
      // });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Login & Register',
          style: TextStyle(
            color: Color(0xFF2D7D79),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFF2D7D79),
          labelColor: const Color(0xFF2D7D79),
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(text: 'Login'),
            Tab(text: 'Sign Up'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          LoginTab(),
          SignUpTab(),
        ],
      ),
    );
  }
}