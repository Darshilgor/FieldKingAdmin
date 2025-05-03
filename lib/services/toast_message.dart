
import 'package:field_king_admin/packages/config.dart';
import 'package:field_king_admin/packages/screen.dart';

class ToastMessage {
  static getSnackToast({
    title = "Alert",
    message = '',
    snackPosition = SnackPosition.TOP,
    backgroundColor = Colors.red,
    colorText = Colors.white,
    Widget? icon,
    Duration duration = const Duration(milliseconds: 3000),
    Function? onTapSnackBar,
    Function? onTapButton,
    bool withButton = false,
    buttonText = 'Ok',
    Function? onDismissed,
  }) {
    Get.snackbar(
      title,
      message,
      mainButton: withButton
          ? TextButton(
          onPressed: () {
            if (onTapButton != null) onTapButton();
          },
          child: Text(buttonText))
          : null,
      onTap: (tap) {
        if (onTapSnackBar != null) onTapSnackBar(tap);
      },
      duration: duration,
      isDismissible: true,
      snackPosition: snackPosition,
      backgroundColor: backgroundColor,
      icon: icon,
      colorText: Colors.white,
      snackbarStatus: (status) {
        if (status == SnackbarStatus.CLOSED) {
          if (onDismissed != null) onDismissed();
        }
      },
    );
  }
}
