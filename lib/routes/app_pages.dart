import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/utils/animation_util/custom_slide_animation.dart';
import '../pages/home/bloc/home_bloc.dart';
import '../pages/home/home_page.dart';
import '../pages/login/bloc/login_bloc.dart';
import '../pages/login/login_page.dart';
import '../pages/splash/bloc/splash_bloc.dart';
import '../pages/splash/splash_page.dart';
import '../repository/user_repository.dart';

part 'app_routes.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    Map<String, dynamic>? arguments;

    if (settings.arguments != null) {
      arguments = settings.arguments as Map<String, dynamic>;
    }

    switch (settings.name) {
      case "/":
      case _Paths.splash:
        return PageRouteBuilder(
          pageBuilder:
              (context, animation, secondaryAnimation) => BlocProvider(
                create: (context) => SplashBloc()..add(StartSplash()),
                child: const SplashPage(),
              ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return slideTransition(animation, child);
          },
        );

      case _Paths.login:
        return PageRouteBuilder(
          pageBuilder:
              (context, animation, secondaryAnimation) => BlocProvider(
                create: (context) => LoginBloc(),
                child: const LoginPage(),
              ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return slideTransition(animation, child);
          },
        );
      case _Paths.home:
        return PageRouteBuilder(
          pageBuilder:
              (context, animation, secondaryAnimation) => BlocProvider(
                create:
                    (context) =>
                        HomeBloc(userRepository: UserRepository())
                          ..add(LoadUsers()),
                child: const HomePage(),
              ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return slideTransition(animation, child);
          },
        );
    }
    return null;
  }
}

/// slider transition
SlideTransition slideTransition(
  Animation<double> animation,
  Widget child, {
  AnimationType animationType = AnimationType.rightToLeft,
}) {
  Offset begin;

  switch (animationType) {
    case AnimationType.rightToLeft:
      begin = const Offset(1.0, 0.0);
    case AnimationType.leftToRight:
      begin = const Offset(-1.0, 0.0);
    case AnimationType.topToBottom:
      begin = const Offset(0.0, -1.0);
    case AnimationType.bottomToTop:
      begin = const Offset(0.0, 1.0);
  }

  const Offset end = Offset.zero;
  const Cubic curve = Curves.ease;

  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

  return SlideTransition(position: animation.drive(tween), child: child);
}
