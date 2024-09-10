part of '../extensions.dart';

extension ContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get text => theme.textTheme;

  void showSnack(String message) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(message)));
  }

  void push(Widget page) =>
      Navigator.of(this).push(MaterialPageRoute(builder: (context) => page));
}
