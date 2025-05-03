import 'package:field_king_admin/packages/screen.dart';
import 'package:field_king_admin/services/app_color/app_colors.dart';
import 'package:field_king_admin/services/text_style/text_style.dart';

class CommonAppButton extends StatelessWidget {
  final Function()? onTap;
  final ButtonType buttonType;
  final String text;
  final IconData? icon;
  final Color? textColor;
  final TextStyle? style;
  final double? borderRadius;
  final double? width;
  final double? height;
  final List<BoxShadow>? boxShadow;
  final BoxBorder? border;
  final bool? isAddButton;
  final Color? buttonColor;
  final Color? disableButtonColor;
  final bool? isBorder;

  const CommonAppButton({
    super.key,
    this.onTap,
    this.buttonType = ButtonType.disable,
    required this.text,
    this.icon,
    this.height,
    this.textColor,
    this.style,
    this.borderRadius,
    this.width,
    this.boxShadow,
    this.border,
    this.isAddButton = true,
    this.buttonColor = AppColor.buttonBackgroundColor,
    this.disableButtonColor,
    this.isBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    Color background = disableButtonColor ?? AppColor.buttonBackgroundColor;
    switch (buttonType) {
      case ButtonType.enable:
        {
          if (isAddButton == true) {
            background = buttonColor!;
          } else {
            background = AppColor.buttonBackgroundColor;
          }
        }
        break;
      case ButtonType.disable:
        {
          background = disableButtonColor ?? AppColor.whiteColor;
        }
        break;
      case ButtonType.progress:
        break;
    }
    return Material(
      color: background,
      borderRadius: BorderRadius.circular(borderRadius ?? 7),
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius ?? 7),
        onTap: (buttonType == ButtonType.enable) ? (onTap ?? () {}) : () {},
        child: Container(
          height: height ?? 50,
          width: width ?? double.infinity,
          decoration: BoxDecoration(
            // color: isBorder == false ? AppColor.primaryColor : null,
            color: null,
            border: isBorder == true
                ? Border.all(
              color: AppColor.buttonBackgroundColor,
              width: 1,
            )
                : null,
            borderRadius: BorderRadius.circular(borderRadius ?? 7),
            boxShadow: boxShadow,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (buttonType == ButtonType.progress)
                SizedBox(
                  height: 30,
                  width: 30,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColor.whiteColor,
                      strokeWidth: 3,
                    ),
                  ),
                ),
              if (buttonType != ButtonType.progress)
                Center(
                  child: Text(
                    text,
                    style: style ??
                        const TextStyle().bold18.textColor(
                          textColor ?? AppColor.whiteColor,
                        ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

enum ButtonType { enable, disable, progress }
