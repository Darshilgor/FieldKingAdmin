part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const splashScreen = _Paths.splashScreen;
  static const login = _Paths.login;
  static const signUp = _Paths.signUp;
  static const viewProfile = _Paths.viewProfile;
  static const editProfile = _Paths.editProfile;
  static const tabBarView = _Paths.tabBarView;

}

abstract class _Paths {
  _Paths._();

  static const splashScreen = '/splash-screen';
  static const login = '/login';
  static const signUp = '/sign-up';
  static const viewProfile = '/view-profile';
  static const editProfile = '/edit-profile';
  static const tabBarView = '/tab-bar-view';

}
