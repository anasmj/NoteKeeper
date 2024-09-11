import 'package:firebase_auth/firebase_auth.dart' as auth;

abstract class FirebaseAuthService {
  Future<auth.User?> login(String email, String password);

  Future<auth.User?> register(String email, String password);

  Future<void> logout();
}
