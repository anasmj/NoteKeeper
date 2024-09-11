import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notekeeper/src/data/app.user.dart';
import 'package:notekeeper/src/utils/msg.from.error.dart';

class AuthServices {
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

  Future<String?> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseException catch (e) {
      return getMessageFromErrorCode(e.code);
    }
  }

  Future<String?> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseException catch (e) {
      log(e.toString(), name: 'login');
      return getMessageFromErrorCode(e.code);
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
