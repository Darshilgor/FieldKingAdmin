import 'package:field_king_admin/packages/screen.dart';
import 'package:field_king_admin/services/app_color/app_colors.dart';
import 'package:field_king_admin/services/close_keyboard.dart';
import 'package:field_king_admin/services/text_style/text_style.dart';
import 'package:pinput/pinput.dart';

Widget otpWidget({
  context,
  Function(String)? onChanged,
  TextEditingController? controller,
}) {
  return Pinput(
    cursor: VerticalDivider(
      width: 1,
      color: AppColor.blackColor,
      thickness: 1,
      indent: 14,
      endIndent: 14,
    ),
    enableSuggestions: false,
    autofillHints: const [],
    controller: controller,
    errorPinTheme: PinTheme(
      width: 70,
      height: 56,
      textStyle: const TextStyle().regular20.textColor(
            AppColor.errorColor,
          ),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        border: Border.all(
          color: AppColor.borderColor,
          width: 0.8,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    defaultPinTheme: PinTheme(
      width: 70,
      height: 56,
      textStyle: TextStyle().regular20.textColor(
            AppColor.blackColor,
          ),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        border: Border.all(
          color: AppColor.borderColor,
          width: 0.8,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    focusedPinTheme: PinTheme(
      width: 70,
      height: 56,
      textStyle: TextStyle().regular20.textColor(
            AppColor.blackColor,
          ),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        border: Border.all(
          color: AppColor.borderColor,
          width: 0.8,
        ),
        borderRadius: BorderRadius.circular(
          12,
        ),
      ),
    ),
    submittedPinTheme: PinTheme(
      width: 70,
      height: 56,
      textStyle: TextStyle().regular20.textColor(
            AppColor.blackColor,
          ),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        border: Border.all(
          color: AppColor.borderColor,
          width: 0.8,
        ),
        borderRadius: BorderRadius.circular(
          12,
        ),
      ),
    ),
    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
    showCursor: true,
    closeKeyboardWhenCompleted: true,
    separatorBuilder: (index) => const SizedBox(width: 10),
    autofocus: true,
    length: 6,
    onChanged: onChanged,
    onCompleted: (value) {
      closeKeyboard();
    },
  );
}
