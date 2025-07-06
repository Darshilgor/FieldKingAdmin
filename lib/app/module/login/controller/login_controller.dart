import 'package:field_king_admin/packages/config.dart';
import 'package:field_king_admin/packages/screen.dart';
import 'package:field_king_admin/services/firebase_services.dart';
import 'package:field_king_admin/services/toast_message.dart';

class LoginController extends GetxController {
  final loginFormKey = GlobalKey<FormState>();

  Rx<TextEditingController> phoneNoController = TextEditingController().obs;
  Rx<TextEditingController> pinPutController = TextEditingController().obs;
  RxBool isVerifyOtpBtnLoad = RxBool(false);
  RxBool isSendOtpBtnLoad = RxBool(false);
  RxBool isTimerOut = RxBool(false);
  var endTime = Rx<DateTime?>(null);

  verifyOtpFunction({String? verificationId}) {
    FirebaseAuthServices.verifyOTP(
      verificationId: verificationId ?? '',
      otp: pinPutController.value.text,
      onVerified: (value) async {
        isVerifyOtpBtnLoad.value = false;
        isVerifyOtpBtnLoad.refresh();
        Preference.isOtpVerified = true;
        Preference.phoneNumber = phoneNoController.value.text;
        Get.back();
        bool isUserExits = await FirebaseFirestoreService.checkUserExitsOrNot(
          phoneNo: phoneNoController.value.text,
        );
        if (isUserExits == true) {
          Get.toNamed(Routes.tabBarView);
        } else {
          Get.offAllNamed(
            Routes.signUp,
            arguments: {
              'phoneNo': phoneNoController,
            },
          );
        }
      },
      onError: (e) {
        isVerifyOtpBtnLoad.value = false;
        isVerifyOtpBtnLoad.refresh();
        ToastMessage.getSnackToast(
          message: 'Invalid OTP, Please enter correct OTP.',
        );
      },
    );
  }

  sendOtpFunction({
    BuildContext? context,
    required Function(String) onCodeSentFunction,
  }) {
    FirebaseAuthServices.sendOTP(
      phoneNumber: '+91${phoneNoController.value.text}',
      onError: (e) {
        print(e);
        isSendOtpBtnLoad.value = false;
        ToastMessage.getSnackToast(
          message: e.message,
        );
      },
      onCodeSent: (verificationId) => onCodeSentFunction(verificationId),
    );
  }
}
