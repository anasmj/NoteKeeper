import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notekeeper/src/data/app.user.dart';

import 'firebase.auth.dart';

class AuthServices extends FirebaseAuthService {
  final _auth = FirebaseAuth.instance;

  StreamProvider<AppUser?> authProvider() => StreamProvider<AppUser?>((ref) {
        return _auth.authStateChanges().map(_fromFirebaseUser);
      });

  AppUser? _fromFirebaseUser(User? user) {
    if (user == null) return null;
    return AppUser(
      id: user.uid,
      name: user.displayName,
      email: user.email,
      photoUrl: user.photoURL,
    );
  }

  Stream<AppUser?> get user => _auth.authStateChanges().map(_fromFirebaseUser);

  @override
  Future<User?> register(String email, String password) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user;
  }

  @override
  Future<User?> login(String email, String password) async {
    final creds = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return creds.user;
  }

  @override
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
