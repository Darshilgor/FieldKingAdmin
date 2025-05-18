import 'package:field_king_admin/app/module/chat_screen/view/chat_screen_view.dart';
import 'package:field_king_admin/app/module/edit_profile/view/edit_profile_view.dart';
import 'package:field_king_admin/app/module/login/view/login_view.dart';
import 'package:field_king_admin/app/module/order_details/view/order_details_view.dart';
import 'package:field_king_admin/app/module/profile/view/profile_view.dart';
import 'package:field_king_admin/app/module/sign_up/view/sign_up_view.dart';
import 'package:field_king_admin/app/module/splash_screen/view/splash_screen_view.dart';
import 'package:field_king_admin/app/module/tab_bar/view/tab_bar_view.dart';
import 'package:field_king_admin/app/module/user_details_view/view/user_details_view.dart';
import 'package:field_king_admin/app/module/user_list/view/user_list_view.dart';
import 'package:field_king_admin/app/module/user_order_history/view/user_order_history_view.dart';
import 'package:field_king_admin/app/module/user_order_history_details/view/user_order_history_detailss_view.dart';
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
    ),GetPage(
      name: _Paths.viewProfile,
      page: () => ProfileView(),
    ),GetPage(
      name: _Paths.editProfile,
      page: () => EditProfileView(),
    ),GetPage(
      name: _Paths.tabBarView,
      page: () => TabBarView(),
    ),GetPage(
      name: _Paths.orderDetailsView,
      page: () => OrderDetailsView(),
    ),GetPage(
      name: _Paths.chatScreenView,
      page: () => ChatScreenView(),
    ),GetPage(
      name: _Paths.userListView,
      page: () => UserListView(),
    ),GetPage(
      name: _Paths.userDetailsView,
      page: () => UserDetailsView(),
    ),GetPage(
      name: _Paths.userOrderHistoryView,
      page: () => UserOrderHistoryView(),
    ),GetPage(
      name: _Paths.userOrderhistoryDetailsView,
      page: () => UserOrderHistoryDetailssView(),
    ),
  ];
}
