import 'package:field_king_admin/packages/config.dart';
import 'package:field_king_admin/packages/screen.dart';
import 'package:field_king_admin/services/firebase_services.dart';
import 'package:field_king_admin/services/genera_controller.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    callOnboardingScreen();
    startUpFunction();
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

  startUpFunction() {
    GeneralController.isShowWithOutGst.value = true;
    // FirebaseFirestoreService.getIsShowWithOutGst();
    // FirebaseFirestoreService.getUser();
  }
}
