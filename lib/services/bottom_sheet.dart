
import 'package:field_king_admin/app/module/login/controller/login_controller.dart';
import 'package:field_king_admin/packages/config.dart';
import 'package:field_king_admin/packages/screen.dart';
import 'package:field_king_admin/services/app_button.dart';
import 'package:field_king_admin/services/app_color/app_colors.dart';
import 'package:field_king_admin/services/app_icon.dart';
import 'package:field_king_admin/services/text_style/text_style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:gap/gap.dart';

bottomSheet({
  context,
  widgetList,
  Function()? onTap,
  String? buttonTitle,
  GlobalKey<FormState>? formKey,
  RxBool? isLoading,
  bool? isShowResendCode = false,
  Function()? resendCodeOnTap,
}) {
  Get.find<LoginController>().endTime.value =
      DateTime.now().add(Duration(minutes: 2));
  return showModalBottomSheet(
    backgroundColor: AppColor.whiteColor,
    isScrollControlled: true,
    context: context,
    builder: (context) => Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(Get.height * 0.02),
            Container(
              height: 5,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  10,
                ),
                color: Colors.grey,
              ),
            ),
            const Gap(20),
            ...widgetList,
            const Gap(40),
            Obx(
                  () => CommonAppButton(
                text: buttonTitle ?? '',
                buttonType: (isLoading?.value ?? false)
                    ? ButtonType.progress
                    : ButtonType.enable,
                onTap: onTap,
              ),
            ),
            Gap((isShowResendCode ?? false) ? 15 : 10),
            Visibility(
              visible: isShowResendCode ?? false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Resend code in: ',
                        style: TextStyle().regular14.textColor(
                          AppColor.blackColor.withOpacity(
                            0.7,
                          ),
                        ),
                      ),
                      TimerCountdown(
                        format: CountDownTimerFormat.minutesSeconds,
                        endTime: DateTime.now().add(
                          Duration(
                            minutes: 2,
                          ),
                        ),
                        onEnd: () {
                          Get.find<LoginController>().isTimerOut.value = true;
                        },
                        timeTextStyle: TextStyle().regular14.textColor(
                          Colors.grey,
                        ),
                        colonsTextStyle: TextStyle().regular14.textColor(
                          Colors.grey,
                        ),
                        spacerWidth: 1,
                        enableDescriptions: false,
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.find<LoginController>().isTimerOut.value = false;
                      Get.find<LoginController>().endTime.value =
                          DateTime.now().add(Duration(minutes: 2));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          Assets.reSendIcon,
                          width: 20,
                          height: 20,
                          colorFilter: ColorFilter.mode(
                            Get.find<LoginController>().isTimerOut.value
                                ? AppColor.blackColor
                                : Colors.grey,
                            BlendMode.srcIn,
                          ),
                        ),
                        const Gap(4),
                        Text(
                          'Resend code',
                          style: const TextStyle().medium16.textColor(
                            Get.find<LoginController>().isTimerOut.value
                                ? AppColor.blackColor
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Gap((isShowResendCode ?? false) ? 15 : 10),
          ],
        ),
      ),
    ),
  );
}
