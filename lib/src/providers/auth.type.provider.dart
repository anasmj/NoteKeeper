import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth.type.provider.g.dart';

enum AuthType { signIn, signUp }

@riverpod
class AuthTypeP extends _$AuthTypeP {
  @override
  AuthType build() => AuthType.signUp;
  void toggleAuthType() =>
      state = state == AuthType.signUp ? AuthType.signIn : AuthType.signUp;
}
