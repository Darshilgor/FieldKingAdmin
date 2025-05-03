import 'package:field_king_admin/app/module/login/view/login_view.dart';
import 'package:field_king_admin/app/module/sign_up/view/sign_up_view.dart';
import 'package:field_king_admin/app/module/splash_screen/view/splash_screen_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splashScreen;

  static final routes = [
    GetPage(
      name: _Paths.splashScreen,
      page: () => SplashScreenView(),
    ),GetPage(
      name: _Paths.signUp,
      page: () => SignUpScreenView(),
    ),GetPage(
      name: _Paths.login,
      page: () => LoginScreenView(),
    ),
  ];
}
