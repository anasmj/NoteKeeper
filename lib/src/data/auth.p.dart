import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notekeeper/src/data/app.user.dart';

final userProvider = StreamProvider<AppUser?>((ref) {
  final auth = FirebaseAuth.instance;
  return auth.authStateChanges().map(_fromFirebaseUser);
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
