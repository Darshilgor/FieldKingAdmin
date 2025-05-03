import 'package:field_king_admin/app/module/tab_bar/controller/tab_bar_controller.dart';
import 'package:field_king_admin/packages/config.dart';
import 'package:field_king_admin/packages/screen.dart';
import 'package:field_king_admin/services/app_color/app_colors.dart';
import 'package:field_king_admin/services/app_icon.dart';
import 'package:field_king_admin/services/text_style/text_style.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class TabBarScreenView extends StatelessWidget {
  TabBarScreenView({super.key});

  final controller = Get.put<TabBarController>(TabBarController());

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Obx(
            () => Scaffold(
          key: controller.tabBarKey,
          extendBody: true,
          drawer: _buildDrawer(context),
          body: IndexedStack(
            index: controller.currentIndex.value,
            children: [
              HomeScreenView(),
              ChatView(),
              // CartView(),
              ProfileView(),
            ],
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.grey,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: controller.currentIndex.value == 0,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 5,
                        ),
                        child: SvgPicture.asset(
                          Assets.home,
                          width: 25,
                          height: 25,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.currentIndex.value = 0;
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 5,
                          right: 10,
                          bottom: 10,
                          top: 10,
                        ),
                        child: Text(
                          'Home',
                          style: controller.currentIndex.value == 0
                              ? TextStyle().semiBold18.textColor(
                            AppColor.blackColor,
                          )
                              : TextStyle().medium16.textColor(
                            AppColor.blackColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Visibility(
                      visible: controller.currentIndex.value == 1,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 2,
                        ),
                        child: SvgPicture.asset(
                          Assets.chat,
                          width: 27,
                          height: 27,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.currentIndex.value = 1;
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 5,
                          right: 10,
                          bottom: 10,
                          top: 10,
                        ),
                        child: Text(
                          'Chat',
                          style: controller.currentIndex.value == 1
                              ? TextStyle().semiBold18.textColor(
                            AppColor.blackColor,
                          )
                              : TextStyle().medium16.textColor(
                            AppColor.blackColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Row(
                //   children: [
                //     Visibility(
                //       visible: controller.currentIndex.value == 2,
                //       child: Padding(
                //         padding: const EdgeInsets.only(
                //           bottom: 1,
                //         ),
                //         child: SvgPicture.asset(
                //           Assets.cart,
                //           width: 28,
                //           height: 28,
                //         ),
                //       ),
                //     ),
                //     GestureDetector(
                //       onTap: () {
                //         controller.currentIndex.value = 2;
                //       },
                //       child: Padding(
                //         padding: const EdgeInsets.only(
                //           left: 5,
                //           right: 10,
                //           bottom: 10,
                //           top: 10,
                //         ),
                //         child: Text(
                //           'Cart',
                //           style: controller.currentIndex.value == 2
                //               ? TextStyle().semiBold18.textColor(
                //                     AppColor.blackColor,
                //                   )
                //               : TextStyle().medium16.textColor(
                //                     AppColor.blackColor,
                //                   ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                Row(
                  children: [
                    Visibility(
                      visible: controller.currentIndex.value == 2,
                      child: SvgPicture.asset(
                        Assets.profile,
                        width: 27,
                        height: 27,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.currentIndex.value = 2;
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 5,
                          right: 10,
                          bottom: 10,
                          top: 10,
                        ),
                        child: Text(
                          'Profile',
                          style: controller.currentIndex.value == 2
                              ? TextStyle().semiBold18.textColor(
                            AppColor.blackColor,
                          )
                              : TextStyle().medium16.textColor(
                            AppColor.blackColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // SalomonBottomBarItem _buildSalomonBottomBarItem(
  //     {required String iconPath, title}) {
  //   return SalomonBottomBarItem(
  //     icon: SvgPicture.asset(
  //       iconPath,
  //       colorFilter: ColorFilter.mode(
  //         blackWhite(),
  //         BlendMode.srcIn,
  //       ),
  //     ),
  //     title: Text(
  //       title,
  //       style: textStyle600(
  //         fontSize: 12,
  //         color: blackWhite(isOpposite: true),
  //       ),
  //     ),
  //     selectedColor: primaryBlackWhite(),
  //     activeIcon: SvgPicture.asset(
  //       iconPath,
  //       colorFilter: ColorFilter.mode(
  //         blackWhite(isOpposite: true),
  //         BlendMode.srcIn,
  //       ),
  //     ),
  //   );
  // }

  Theme _buildDrawer(BuildContext context) {
    return Theme(
      data: ThemeData(useMaterial3: false),
      child: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: Get.height * 0.2,
              decoration: BoxDecoration(
                color: AppColor.whiteColor,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    spreadRadius: 2,
                    color: Colors.grey.withOpacity(
                      0.3,
                    ),
                  ),
                ],
              ),
            ),
            Gap(20),
            GestureDetector(
              onTap: () {
                Get.back();
                Get.toNamed(
                  Routes.orderHistoryView,
                );
              },
              child: Text(
                'Order History',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColor.blackColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
