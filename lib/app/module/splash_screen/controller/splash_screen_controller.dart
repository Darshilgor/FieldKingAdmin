import 'package:field_king_admin/packages/config.dart';
import 'package:field_king_admin/packages/screen.dart';
import 'package:field_king_admin/services/firebase_services.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    callOnboardingScreen();
    updateUserActiveStatus();
    // startUpFunction();
  }

  Future<void> callOnboardingScreen() async {
    await Future.delayed(
      const Duration(
        seconds: 3,
      ),
      () async {
        Preference.isLogin == true
            ? Get.offAllNamed(
                Routes.tabBarView,
              )
            : Get.offAllNamed(
                Routes.login,
              );
      },
    );
  }

  updateUserActiveStatus() async {
    await FirebaseFirestoreService.updateUserActiveStatus(
      userId: Preference.userId,
    );
  }

// startUpFunction() {
//   FirebaseFirestoreServices.getIsShowWithOutGst();
//   FirebaseFirestoreServices.getUser();
// }
}
