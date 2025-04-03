part of 'app_pages.dart';

abstract class Routes {
  static const String splash = _Paths.splash;
  static const String login = _Paths.login;
  static const String home = _Paths.home;
}

abstract class _Paths {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';
}
