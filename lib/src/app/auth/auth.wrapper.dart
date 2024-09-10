import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notekeeper/src/app/home/home.dart';
import 'package:notekeeper/src/data/auth.p.dart';
import 'package:notekeeper/src/services/auth/auth.services.dart';

import 'authenticate.page.dart';

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      body: ref.watch(authProvider).when(
        data: (user) {
          return user == null ? const AuthenticatePage() : const HomePage();
        },
        error: (e, s) {
          return const AuthenticatePage();
        },
        loading: () {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        },
      ),
    );
  }
}
