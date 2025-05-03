import 'package:field_king_admin/app/module/sign_up/controller/sign_up_controller.dart';
import 'package:field_king_admin/packages/config.dart';
import 'package:field_king_admin/packages/screen.dart';
import 'package:field_king_admin/services/app_button.dart';
import 'package:field_king_admin/services/app_color/app_colors.dart';
import 'package:field_king_admin/services/app_icon.dart';
import 'package:field_king_admin/services/close_keyboard.dart';
import 'package:field_king_admin/services/text_form_field.dart';
import 'package:field_king_admin/services/text_style/text_style.dart';
import 'package:gap/gap.dart';

class SignUpScreenView extends StatelessWidget {
  SignUpScreenView({super.key});

  final controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => closeKeyboard(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Form(
            key: controller.signUpFormKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Gap(Get.height * 0.1),
                  Text(
                    'Fill your details to continue.',
                    style: TextStyle().bold26.textColor(
                          AppColor.blackColor,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  Gap(Get.height * 0.2),
                  InputField(
                    controller: controller.firstNameController.value,
                    labelText: 'First Name',
                    hintText: 'KishorBhai',
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
                    hintText: 'Gor',
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
                    hintText: 'Field King',
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
                    readOnly: true,
                    controller: controller.phoneNoController.value,
                    labelText: 'Phone No',
                    hintText: '9409529203',
                    prefixIcon: Assets.phoneIcon,
                    prefixIconColor: AppColor.blackColor,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    maxLength: 10,
                    validator: (value) {
                      if (value?.length == 0) {
                        return 'Please enter phone number';
                      } else if (value?.length != 10) {
                        return 'Please enter valid phone number';
                      } else {
                        return null;
                      }
                    },
                  ),
                  Gap(20),
                  InputField(
                    controller: controller.locationController.value,
                    labelText: 'Address',
                    hintText: 'Address',
                    prefixIcon: Assets.lcoationIcon,
                    isPngPrefixIcon: true,
                    prefixIconColor: AppColor.blackColor,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if ((value ?? '').isEmpty) {
                        return 'Please enter address';
                      } else {
                        return null;
                      }
                    },
                  ),
                  Gap(40),
                  Obx(
                    () => CommonAppButton(
                      text: 'Submit',
                      buttonType: controller.isSubmitBtnLoading.value
                          ? ButtonType.progress
                          : ButtonType.enable,
                      onTap: () {
                        if (controller.signUpFormKey.currentState!.validate()) {
                          closeKeyboard();
                          controller.isSubmitBtnLoading.value = true;
                          controller.addUser();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
