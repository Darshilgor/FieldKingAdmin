
import 'package:field_king_admin/packages/screen.dart';
import 'package:field_king_admin/services/app_color/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color? backgroundColor;
  final double? leadingWidth;
  final Widget? leadingIcon;
  final double? toolbarHeight;
  final Widget? title;
  final List<Widget>? action;
  final bool? isLeading;
  final void Function()? onTap;
  final Widget? leadingWidget;
  const CustomAppBar({
    super.key,
    this.backgroundColor,
    this.leadingWidth = 70,
    this.leadingIcon,
    this.toolbarHeight = 50,
    this.action,
    this.title,
    this.isLeading = true,
    this.onTap,
    this.leadingWidget,
  });
  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      backgroundColor: AppColor.whiteColor,
      leadingWidth: leadingWidth,
      toolbarHeight: toolbarHeight,
      leading: isLeading == true
          ? Padding(
        padding: EdgeInsets.all(5),
        child: InkWell(
          onTap: onTap,
          child: Container(
            // width: 32.w,
            // height: 32.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.bgColor2,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 7,
              ),
              child: Icon(
                Icons.arrow_back_ios,
                size: 22,
              ),
            ),
          ),
        ),
      )
          : leadingWidget,
      title: title,
      actions: action,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight!);
}
