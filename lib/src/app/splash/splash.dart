import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notekeeper/src/app/auth/auth.wrapper.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({
    super.key,
  });

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  final _duration = const Duration(milliseconds: 100);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
    _controller.addStatusListener(
      (status) async {
        if (status == AnimationStatus.completed) {
          await Future.delayed(_duration);
          if (context.mounted) {
            // ignore: use_build_context_synchronously
            Navigator.of(context).pushReplacement(
              NoRouteTransition(
                builder: (context) => const AuthWrapper(),
              ),
            );
          }
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
            animation: _animation,
            builder: (context, snapshot) {
              return ScaleTransition(
                scale: _animation,
                alignment: Alignment.center,
                child: const Image(
                  image: AssetImage('assets/images/png/pencil.png'),
                  height: 300,
                  width: 300,
                ),
              );
            }),
      ),
    );
  }
}

class NoRouteTransition extends PageRoute {
  NoRouteTransition({required this.builder});

  final WidgetBuilder builder;

  @override
  Color? get barrierColor => Colors.transparent;

  @override
  String? get barrierLabel => '';

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  bool get maintainState => false;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);
}
