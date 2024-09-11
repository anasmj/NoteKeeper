import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth.type.provider.g.dart';

enum AuthType { signIn, signUp }

@riverpod
class AuthTypeP extends _$AuthTypeP {
  @override
  AuthType build() => AuthType.signIn;
  void toggleAuthType(AuthType type) {
    state = type == AuthType.signUp ? AuthType.signIn : AuthType.signUp;
  }
}
