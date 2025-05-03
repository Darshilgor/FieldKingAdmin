
import 'package:field_king_admin/packages/screen.dart';
import 'package:field_king_admin/services/app_color/app_colors.dart';
import 'package:field_king_admin/services/text_style/text_style.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

typedef OnValidation = dynamic Function(String? text);

class InputField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool obscureText;
  final bool firstCapital;
  final bool disable;
  final bool readOnly;
  final String hintText;
  final String? suffixIcon;
  final String? prefixIcon;
  final bool? isHasInVisibleBorder;
  final List<TextInputFormatter>? inputFormatter;
  final OnValidation? validator;
  final Function(String?)? onChange;
  final Function(String?)? onSubmitted;
  final Function()? onTap;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final int? maxLine;
  final int? minLine;
  final double? width;
  final double? height;
  final Color? textFieldColor;
  final Color? fillColor;
  final TextStyle? hintStyle;
  final Color? borderColor;
  final AutovalidateMode? autovalidateMode;
  final Function()? onPrefixIconTap, onSuffixIconTap;
  final bool? isPngSuffixIcon, isPngPrefixIcon;
  final EdgeInsets? suffixIconPadding;
  final Color? prefixIconColor, suffixIconColor;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? prefixIconPadding;
  final BorderRadius? borderRadius;
  final double? suffixIconSize;
  final String? labelText;
  final int? maxLength;
  final InputBorder? disableBorder;
  final InputBorder? border;
  final InputBorder? focusBorder;
  final InputBorder? enableBorder;
  final InputBorder? errorBorder;

  const InputField({
    super.key,
    this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.readOnly = false,
    this.focusNode,
    this.obscureText = false,
    this.disable = false,
    this.firstCapital = false,
    this.hintText = "",
    this.onChange,
    this.fillColor,
    this.inputFormatter,
    this.onSubmitted,
    this.onTap,
    this.isHasInVisibleBorder = false,
    this.textInputAction,
    this.keyboardType,
    this.validator,
    this.maxLine = 1,
    this.width,
    this.height,
    this.textFieldColor,
    this.hintStyle,
    this.borderColor,
    this.autovalidateMode,
    this.onPrefixIconTap,
    this.onSuffixIconTap,
    this.suffixIconPadding,
    this.isPngPrefixIcon,
    this.isPngSuffixIcon,
    this.suffixIconColor,
    this.prefixIconColor,
    this.textStyle,
    this.prefixIconPadding,
    this.borderRadius,
    this.suffixIconSize,
    this.labelText,
    this.maxLength,
    this.minLine = 1,
    this.border,
    this.disableBorder,
    this.focusBorder,
    this.enableBorder,
    this.errorBorder,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: AppColor.blackColor,
        ),
      ),
      child: TextFormField(
        maxLength: maxLength,
        readOnly: readOnly,
        onTap: onTap ?? () {},
        textCapitalization:
        firstCapital ? TextCapitalization.words : TextCapitalization.none,
        cursorColor: AppColor.blackColor,
        cursorHeight: 25,
        cursorWidth: 1.5,
        autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        focusNode: focusNode,
        autofocus: false,
        obscureText: obscureText,
        minLines: minLine,
        maxLines: maxLine,
        inputFormatters: inputFormatter ?? [],
        style: textStyle ??
            const TextStyle().regular14.textColor(
              AppColor.blackColor,
            ),
        decoration: InputDecoration(
          counterText: "",
          floatingLabelStyle: TextStyle().medium17.textColor(
            AppColor.blackColor,
          ),
          labelText: labelText,
          labelStyle: TextStyle().regular16.textColor(
            AppColor.labeColor,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          prefixIcon: (prefixIcon ?? "").isEmpty
              ? null
              : GestureDetector(
            onTap: onPrefixIconTap,
            child: Padding(
              padding: prefixIconPadding ??
                  const EdgeInsets.only(
                    left: 15,
                    right: 10,
                    top: 10,
                    bottom: 10,
                  ),
              child: isPngPrefixIcon == true
                  ? Image.asset(
                prefixIcon ?? "",
                height: 22,
                width: 22,
                color: prefixIconColor ?? AppColor.blackColor,
              )
                  : SvgPicture.asset(
                prefixIcon ?? "",
                height: 22,
                width: 22,
                colorFilter: ColorFilter.mode(
                  prefixIconColor ?? AppColor.blackColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          isCollapsed: true,
          suffixIcon: (suffixIcon ?? "").isEmpty
              ? null
              : GestureDetector(
            onTap: onSuffixIconTap,
            child: Padding(
              padding: suffixIconPadding ??
                  const EdgeInsets.only(
                    left: 8,
                    right: 12,
                    top: 12,
                    bottom: 12,
                  ),
              child: isPngSuffixIcon == true
                  ? Image.asset(
                suffixIcon ?? "",
                height: suffixIconSize ?? 16,
                width: suffixIconSize ?? 16,
                color: suffixIconColor ??
                    AppColor.blackColor.withOpacity(0.50),
              )
                  : SvgPicture.asset(
                suffixIcon ?? "",
                height: suffixIconSize ?? 16,
                width: suffixIconSize ?? 16,
                colorFilter: ColorFilter.mode(
                  suffixIconColor ??
                      AppColor.blackColor.withOpacity(0.50),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          enabled: !disable,
          hintStyle: hintStyle ??
              const TextStyle().regular16.textColor(
                AppColor.hintColor,
              ),
          hintText: hintText,
          filled: false,
          fillColor: fillColor ?? AppColor.whiteColor,
          disabledBorder: disableBorder ??
              OutlineInputBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(50),
                borderSide: BorderSide(
                  width: 1,
                  color: AppColor.borderColor,
                ),
              ),
          enabledBorder: enableBorder ??
              OutlineInputBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(50),
                borderSide: BorderSide(
                  width: 1,
                  color: AppColor.borderColor,
                ),
              ),
          border: border ??
              OutlineInputBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(50),
                borderSide: BorderSide(
                  width: 1,
                  color: AppColor.borderColor,
                ),
              ),
          errorBorder: errorBorder ??
              OutlineInputBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(50),
                borderSide: BorderSide(
                  width: 1,
                  color: AppColor.errorColor,
                ),
              ),
          focusedErrorBorder: errorBorder ??
              OutlineInputBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(50),
                borderSide: BorderSide(
                  width: 1.5,
                  color: AppColor.errorColor,
                ),
              ),
          errorStyle: TextStyle().regular13.textColor(
            AppColor.errorColor,
          ),
          focusedBorder: focusBorder ??
              OutlineInputBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(50),
                borderSide: BorderSide(
                  width: 1,
                  color: AppColor.borderColor,
                ),
              ),
        ),
        textInputAction: textInputAction ?? TextInputAction.next,
        keyboardType: keyboardType ?? TextInputType.visiblePassword,
        onChanged: (val) {
          if (onChange != null) {
            onChange!(val);
          }
        },
        onFieldSubmitted: onSubmitted,
        validator: (val) {
          if (validator != null) {
            return validator!(val);
          } else {
            return null;
          }
        },
      ),
    );
  }
}
