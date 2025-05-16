import 'package:field_king_admin/app/module/profile/controller/profile_controller.dart';
import 'package:field_king_admin/app/module/tab_bar/controller/tab_bar_controller.dart';
import 'package:field_king_admin/packages/config.dart';
import 'package:field_king_admin/packages/screen.dart';
import 'package:field_king_admin/services/app_color/app_colors.dart';
import 'package:field_king_admin/services/app_icon.dart';
import 'package:field_king_admin/services/common_code.dart';
import 'package:field_king_admin/services/custom_app_bar.dart';
import 'package:field_king_admin/services/text_form_field.dart';
import 'package:field_king_admin/services/text_style/text_style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
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
          'Profile',
        ),
        isLeading: false,
        action: [
          Padding(
            padding: const EdgeInsets.only(
              right: 20,
            ),
            child: GestureDetector(
              onTap: () {
                Get.toNamed(
                  Routes.editProfile,
                );
              },
              child: Text(
                'Edit',
                style: TextStyle().regular16.textColor(
                      AppColor.blackColor,
                    ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Gap(20),
              Obx(
                () => Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  child: extendedImage(
                    imageUrl: controller.profilePhoto.value,
                    height: 135,
                    width: 135,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Gap(40),
              InputField(
                disable: true,
                controller: controller.firstNameController.value,
                labelText: 'First Name',
                prefixIcon: Assets.accountIcon,
                prefixIconColor: AppColor.blackColor,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if ((value ?? '').isEmpty) {
                    return 'Please enter first name';
                  } else {
                    return null;
                  }
                },
              ),
              Gap(20),
              InputField(
                disable: true,
                controller: controller.lastNameController.value,
                labelText: 'Last Name',
                prefixIcon: Assets.accountIcon,
                prefixIconColor: AppColor.blackColor,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if ((value ?? '').isEmpty) {
                    return 'Please enter last name';
                  } else {
                    return null;
                  }
                },
              ),
              Gap(20),
              InputField(
                disable: true,
                controller: controller.brandNameController.value,
                labelText: 'Brand Name',
                prefixIcon: Assets.brandNameIcon,
                isPngPrefixIcon: true,
                prefixIconColor: AppColor.blackColor,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if ((value ?? '').isEmpty) {
                    return 'Please enter brand name';
                  } else {
                    return null;
                  }
                },
              ),
              Gap(20),
              InputField(
                disable: true,
                controller: controller.phoneNumberController.value,
                labelText: 'Phone Number',
                prefixIcon: Assets.phoneIcon,
                prefixIconColor: AppColor.blackColor,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if ((value ?? '').isEmpty) {
                    return 'Please enter phone number';
                  } else {
                    return null;
                  }
                },
              ),
              Gap(20),
              /* InputField(
                readOnly: true,
                disable: true,
                controller: controller.totalOrderMeterController.value,
                labelText: 'Total order meter',
                prefixIcon: Assets.meterIcon,
                prefixIconColor: AppColor.blackColor,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                validator: (value) {},
              ),
              Gap(20),
              InputField(
                readOnly: true,
                disable: true,
                controller: controller.totalOrderAmountController.value,
                labelText: 'Total order amount',
                prefixIcon: Assets.rupeeIcon,
                prefixIconColor: AppColor.blackColor,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                validator: (value) {},
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
