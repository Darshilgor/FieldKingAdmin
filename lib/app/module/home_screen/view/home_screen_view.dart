import 'package:field_king_admin/app/module/home_screen/controller/home_screen_controller.dart';
import 'package:field_king_admin/app/module/tab_bar/controller/tab_bar_controller.dart';
import 'package:field_king_admin/packages/config.dart';
import 'package:field_king_admin/packages/screen.dart';
import 'package:field_king_admin/services/app_color/app_colors.dart';
import 'package:field_king_admin/services/app_icon.dart';
import 'package:field_king_admin/services/custom_app_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreenView extends StatelessWidget {
    HomeScreenView({super.key});

  final controller =Get.put(HomeScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingWidget: Padding(
          padding: const EdgeInsets.all(
            8,
          ),
          child: GestureDetector(
            onTap: () {
              Get.find<TabBarController>().tabBarKey.currentState?.openDrawer();
            },
            child: SvgPicture.asset(
              Assets.drawerIcon,
              width: 15,
              height: 15,
              colorFilter: ColorFilter.mode(
                AppColor.blackColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        title: Text(
          'Field King',
        ),
        isLeading: false,
      ),
    );
  }
}
