import 'package:field_king_admin/app/module/login/controller/login_controller.dart';
import 'package:field_king_admin/packages/config.dart';
import 'package:field_king_admin/packages/screen.dart';
import 'package:field_king_admin/services/app_button.dart';
import 'package:field_king_admin/services/app_color/app_colors.dart';
import 'package:field_king_admin/services/app_icon.dart';
import 'package:field_king_admin/services/bottom_sheet.dart';
import 'package:field_king_admin/services/close_keyboard.dart';
import 'package:field_king_admin/services/pin_put.dart';
import 'package:field_king_admin/services/text_form_field.dart';
import 'package:field_king_admin/services/text_style/text_style.dart';
import 'package:field_king_admin/services/toast_message.dart';
import 'package:gap/gap.dart';

class LoginScreenView extends StatelessWidget {
  LoginScreenView({super.key});

  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => closeKeyboard(),
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: SafeArea(
            child: Form(
              key: controller.loginFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Gap(Get.height * 0.1),
                  Text(
                    'Welcome to Field King!',
                    style: TextStyle().bold26.textColor(
                          AppColor.blackColor,
                        ),
                  ),
                  Gap(20),
                  Text(
                    'Please enter phone number to get opt.',
                    style: TextStyle().regular16.textColor(
                          AppColor.descriptionColor,
                        ),
                  ),
                  Gap(
                    Get.height * 0.2,
                  ),
                  InputField(
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
                        return 'Please enter phone number.';
                      } else if (value?.length != 10) {
                        return 'Please enter valid phone number.';
                      } else {
                        return null;
                      }
                    },
                  ),
                  Gap(20),
                  Obx(
                    () => CommonAppButton(
                      text: 'Send Otp',
                      buttonType: controller.isSendOtpBtnLoad.value
                          ? ButtonType.progress
                          : ButtonType.enable,
                      onTap: () {
                        if (controller.loginFormKey.currentState!.validate()) {
                          closeKeyboard();

                          if (controller.phoneNoController.value.text ==
                                  '9426781202' ||
                              controller.phoneNoController.value.text ==
                                  '9409529203') {
                            controller.isSendOtpBtnLoad.value = true;

                            controller.sendOtpFunction(
                              context: context,
                              onCodeSentFunction: (verificationId) {
                                if (verificationId.isNotEmpty) {
                                  {
                                    controller.isSendOtpBtnLoad.value = false;
                                    controller.pinPutController.value.text = '';
                                    bottomSheet(
                                      isLoading: controller.isVerifyOtpBtnLoad,
                                      buttonTitle: 'Verify',
                                      context: context,
                                      isShowResendCode: true,
                                      formKey: controller.loginFormKey,
                                      widgetList: [
                                        Text(
                                          'Verify phone number',
                                          style:
                                              TextStyle().semiBold18.textColor(
                                                    AppColor.blackColor,
                                                  ),
                                        ),
                                        Gap(20),
                                        Text(
                                          'We have send verification code to your phone number, please verify your phone number.',
                                          style:
                                              TextStyle().regular16.textColor(
                                                    AppColor.descriptionColor,
                                                  ),
                                          textAlign: TextAlign.center,
                                        ),
                                        Gap(50),
                                        otpWidget(
                                          controller:
                                              controller.pinPutController.value,
                                        ),
                                      ],
                                      onTap: () {
                                        if (controller.pinPutController.value
                                                .text.length ==
                                            6) {
                                          controller.isVerifyOtpBtnLoad.value =
                                              true;
                                          controller.isVerifyOtpBtnLoad
                                              .refresh();
                                          controller.verifyOtpFunction(
                                            verificationId: verificationId,
                                          );
                                        } else {
                                          ToastMessage.getSnackToast(
                                            message: 'Please enter otp.',
                                          );
                                        }
                                      },
                                    );
                                  }
                                } else {
                                  ToastMessage.getSnackToast(
                                    message:
                                        'Something went wrong.Please try again later',
                                  );
                                }
                              },
                            );
                          } else {
                            ToastMessage.getSnackToast(
                              message: 'You have not access of admin',
                            );
                          }
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
