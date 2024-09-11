// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:gap/gap.dart';
// import 'package:notekeeper/src/providers/auth.provider.dart';
// import 'package:notekeeper/src/providers/auth.type.provider.dart';

// class SignUpPage extends ConsumerStatefulWidget {
//   const SignUpPage({super.key});

//   @override
//   ConsumerState<SignUpPage> createState() => _SignUpPageState();
// }

// class _SignUpPageState extends ConsumerState<SignUpPage> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Sign Up'),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: _emailController,
//               decoration: const InputDecoration(label: Text('Email')),
//             ),
//             // 6 char 
//             TextField(
//               controller: _passwordController,
//               decoration: const InputDecoration(label: Text('Password')),
//             ),
//             const Gap(30),
//             ElevatedButton(
//                 onPressed: () {
//                   ref.read(authProvider.notifier).signUp(
//                         _emailController.text,
//                         _passwordController.text,
//                       );
//                 },
//                 child: const Text('Sign Up')),
//             TextButton(
//               onPressed: ref.read(authTypePProvider.notifier).toggleAuthType,
//               child: const Text('Sign In'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
