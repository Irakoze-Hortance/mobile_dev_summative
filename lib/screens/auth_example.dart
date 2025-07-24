// auth_example.dart
// Example showing how to use authentication utilities in your app

import 'package:flutter/material.dart';
import '../utils/auth_utils.dart';

class AuthExample extends StatelessWidget {
  const AuthExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auth Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Example 1: Check if user is logged in
            Text('Is logged in: ${authUtils.isLoggedIn()}'),
            const SizedBox(height: 10),
            
            // Example 2: Get current user email
            Text('Email: ${authUtils.getCurrentUserEmail() ?? 'Not logged in'}'),
            const SizedBox(height: 10),
            
            // Example 3: Get current user ID
            Text('User ID: ${authUtils.getCurrentUserId() ?? 'No ID'}'),
            const SizedBox(height: 10),
            
            // Example 4: Get current user display name
            Text('Display Name: ${authUtils.getCurrentUserDisplayName() ?? 'No name set'}'),
            const SizedBox(height: 20),
            
            // Example 5: Get user data from Firestore
            ElevatedButton(
              onPressed: () async {
                final userData = await authUtils.getCurrentUserData();
                if (userData != null) {
                  print('User data: $userData');
                  // Use the data as needed
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('User: ${userData['fullName']}')),
                  );
                }
              },
              child: const Text('Get User Data'),
            ),
            const SizedBox(height: 20),
            
            // Example 6: Listen to auth state changes
            StreamBuilder(
              stream: authUtils.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return const Text('User is logged in');
                } else {
                  return const Text('User is not logged in');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
