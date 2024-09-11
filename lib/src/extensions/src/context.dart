part of '../extensions.dart';

extension ContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get text => theme.textTheme;

  void showSnack(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(this).colorScheme.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        behavior: SnackBarBehavior.floating,
        content: Text(message),
      ),
    );
  }

  void push(Widget page) =>
      Navigator.of(this).push(MaterialPageRoute(builder: (context) => page));

  void fadePush(Widget page) => Navigator.of(this).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
      );
}
  /// [Navigator] that displays the route.
