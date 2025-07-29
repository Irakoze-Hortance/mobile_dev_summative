

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
            Text('Is logged in: ${authUtils.isLoggedIn()}'),
            const SizedBox(height: 10),
            
            Text('Email: ${authUtils.getCurrentUserEmail() ?? 'Not logged in'}'),
            const SizedBox(height: 10),
            
            Text('User ID: ${authUtils.getCurrentUserId() ?? 'No ID'}'),
            const SizedBox(height: 10),
            
            Text('Display Name: ${authUtils.getCurrentUserDisplayName() ?? 'No name set'}'),
            const SizedBox(height: 20),
            
            ElevatedButton(
              onPressed: () async {
                final userData = await authUtils.getCurrentUserData();
                if (userData != null) {
                  print('User data: $userData');

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('User: ${userData['fullName']}')),
                  );
                }
              },
              child: const Text('Get User Data'),
            ),
            const SizedBox(height: 20),
            
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
