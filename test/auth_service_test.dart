import 'package:flutter_test/flutter_test.dart';
import 'package:health_app/services/auth_service.dart';

void main() {
  group('AuthService', () {
    late AuthService authService;

    setUp(() {
      authService = AuthService();
    });

    test('signInWithEmailAndPassword returns user on success', () async {
      final user = await authService.signInWithEmailAndPassword(
        email: 'test@example.com',
        password: 'password',
      );
      expect(user, isNotNull);
    });

    test('signOut signs out the user', () async {
      await authService.signOut();
      final user = await authService.currentUser;
      expect(user, isNull);
    });
  });
}