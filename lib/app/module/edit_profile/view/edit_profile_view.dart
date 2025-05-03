
import 'package:field_king_admin/app/module/edit_profile/controller/edit_profile_controller.dart';
import 'package:field_king_admin/packages/config.dart';
import 'package:field_king_admin/packages/screen.dart';
import 'package:field_king_admin/services/app_button.dart';
import 'package:field_king_admin/services/app_color/app_colors.dart';
import 'package:field_king_admin/services/app_icon.dart';
import 'package:field_king_admin/services/common_code.dart';
import 'package:field_king_admin/services/custom_app_bar.dart';
import 'package:field_king_admin/services/text_form_field.dart';
import 'package:field_king_admin/services/text_style/text_style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart';

class EditProfileView extends StatelessWidget {
  EditProfileView({super.key});

  final controller = Get.put(EditProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: CustomAppBar(
        title: Text(
          'Edit Profile',
        ),
        isLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 20,
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Gap(20),
                    Stack(
                      children: [
                        Obx(
                              () => editProfileExtendedImage(
                            height: 135,
                            width: 135,
                            profileImage: controller.profilePhoto.value,
                            selectedProfileImage: controller.profileImage.value,
                          ),
                        ),
                        Positioned(
                          right: 8,
                          bottom: 0,
                          child: InkWell(
                            onTap: () {
                              pickImageFunction(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(
                                8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(
                                  60,
                                ),
                              ),
                              child: SvgPicture.asset(
                                Assets.editIcon,
                                width: 18,
                                height: 18,
                                colorFilter: ColorFilter.mode(
                                  AppColor.whiteColor,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gap(40),
                    InputField(
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
                  ],
                ),
              ),
            ),
            CommonAppButton(
              text: 'Update',
              buttonType: controller.isButtonLoading.value
                  ? ButtonType.progress
                  : ButtonType.enable,
              onTap: () {
                controller.isButtonLoading.value = true;

                controller.updateProfile();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickImageFunction(BuildContext context) async {
    Get.bottomSheet(
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(
                    20,
                  ),
                  topRight: Radius.circular(
                    20,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      top: 10,
                    ),
                    width: 150,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColor.blackColor,
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 25,
                      bottom: 0,
                    ),
                    child: InkWell(
                      onTap: () async {
                        Get.back();
                        var status = await Permission.photos.request();
                        if (status.isGranted) {
                          controller.profileImage.value = await pickImage(
                              ImageSource.gallery,
                              canBack: true);
                        } else if (status.isDenied) {
                          Get.snackbar(
                            'Permission Denied',
                            'Gallery access is required to select pictures.',
                            snackPosition: SnackPosition.BOTTOM,
                            margin: EdgeInsets.only(
                              bottom: 10,
                              left: 10,
                              right: 10,
                            ),
                          );
                        } else if (status.isPermanentlyDenied) {
                          Get.snackbar(
                            'Permission Permanently Denied',
                            'Please enable gallery access in the app settings.',
                            snackPosition: SnackPosition.BOTTOM,
                            mainButton: TextButton(
                              onPressed: () {
                                openAppSettings();
                              },
                              child: const Text('Open Settings'),
                            ),
                          );
                        }
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            Assets.galleryIcon,
                            width: 25,
                            height: 25,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Upload photo from gallery',
                            style: TextStyle().semiBold14.textColor(
                              AppColor.blackColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 15,
                      bottom: 20,
                    ),
                    child: InkWell(
                      onTap: () async {
                        Get.back();
                        var status = await Permission.camera.request();
                        if (status.isGranted) {
                          controller.profileImage.value =
                          await pickImage(ImageSource.camera);
                        } else {
                          Get.snackbar(
                            'Permission Denied',
                            'Camera access is required to take pictures.',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            Assets.cameraIcon,
                            width: 25,
                            height: 25,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Capture photo using camera',
                            style: TextStyle().semiBold14.textColor(
                              AppColor.blackColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
