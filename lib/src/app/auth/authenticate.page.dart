import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notekeeper/src/app/auth/login.dart';
import 'package:notekeeper/src/app/auth/sign.up.dart';
import 'package:notekeeper/src/providers/auth.type.provider.dart';

class AuthenticatePage extends ConsumerWidget {
  const AuthenticatePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final authType = ref.watch(authTypePProvider);

    return authType == AuthType.signIn ? const Login() : const Signup();
  }
}
