part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const splashScreen = _Paths.splashScreen;
  static const tabBarScreen = _Paths.tabBarScreen;
  static const login = _Paths.login;
  static const signUp = _Paths.signUp;

}

abstract class _Paths {
  _Paths._();

  static const splashScreen = '/splash-screen';
  static const tabBarScreen = '/tabbar-screen';
  static const login = '/login';
  static const signUp = '/sign-up';

}
