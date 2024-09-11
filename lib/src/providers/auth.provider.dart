import 'package:firebase_auth/firebase_auth.dart';
import 'package:notekeeper/src/data/app.user.dart';
import 'package:notekeeper/src/providers/loading.provider.dart';
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

  Future<String?> signIn(String email, String pass) async {
    ref.read(loadingProvider.notifier).update(true);
    final errorMsg = await AuthServices().login(email, pass);
    ref.read(loadingProvider.notifier).update(false);
    return errorMsg;
  }


  Future<String?> signUp(String email, String pass) async {
    ref.read(loadingProvider.notifier).update(true);
    final errorMsg = await AuthServices().register(email, pass);
    ref.read(loadingProvider.notifier).update(false);

    return errorMsg;
  }
}
