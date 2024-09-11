import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:notekeeper/src/data/auth.p.dart';
import 'package:notekeeper/src/extensions/extensions.dart';
import 'package:notekeeper/src/services/firebase/auth/auth.services.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final user = ref
        .watch(userProvider)
        .when(data: (user) => user, error: (e, s) => null, loading: () => null);

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  context.theme.colorScheme.secondary,
                  context.theme.primaryColor,
                ],
              ),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: user != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.email_outlined, color: Colors.white),
                        const Gap(10),
                        Text(
                          user.email ?? 'Anonymous',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
          ),
          const Spacer(),
          TextButton(
            style: TextButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () async => await AuthServices().logout(),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
