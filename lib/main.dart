import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notekeeper/firebase_options.dart';
import 'package:notekeeper/src/app/auth/auth.wrapper.dart';
import 'package:notekeeper/src/app/splash/splash.dart';
import 'package:notekeeper/src/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  bool isFirstLaunch = await checkFirstLaunch();
  runApp(
    ProviderScope(
      child: MainApp(isFirstLaunch: isFirstLaunch),
    ),
  );
}

class MainApp extends StatelessWidget {
  final bool isFirstLaunch;
  const MainApp({super.key, required this.isFirstLaunch});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isFirstLaunch ? const SplashView() : const AuthWrapper(),
      theme: lightTheme,
    );
  }
}

Future<bool> checkFirstLaunch() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

  if (isFirstLaunch) {
    prefs.setBool('isFirstLaunch', false);
  }

  return isFirstLaunch;
}
