import 'package:field_king_admin/packages/config.dart';
import 'package:field_king_admin/packages/screen.dart';

class TabBarController extends GetxController
{
  RxInt currentIndex = RxInt(0);
  final GlobalKey<ScaffoldState> tabBarKey = GlobalKey<ScaffoldState>();
}