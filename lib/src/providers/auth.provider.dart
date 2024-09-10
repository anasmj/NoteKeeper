import 'package:firebase_auth/firebase_auth.dart';
import 'package:notekeeper/src/data/app.user.dart';
import 'package:notekeeper/src/services/auth/auth.services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth.provider.g.dart';

@riverpod
class Auth extends _$Auth {
  @override
  AppUser build() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return AppUser();
    return _fromFirebaseUser(user);
  }

  _fromFirebaseUser(User user) => AppUser(
        id: user.uid,
        name: user.displayName,
        email: user.email,
        photoUrl: user.photoURL,
      );

  Future<void> signUp(String email, String pass) async {
    final user = await AuthServices().register(email, pass);
    if (user != null) state = _fromFirebaseUser(user);
  }
}
