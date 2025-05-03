import 'package:field_king_admin/packages/config.dart';
import 'package:field_king_admin/packages/screen.dart';

class ProfileController extends GetxController {
  Rx<TextEditingController> firstNameController = TextEditingController().obs;
  Rx<TextEditingController> lastNameController = TextEditingController().obs;
  Rx<TextEditingController> brandNameController = TextEditingController().obs;
  Rx<TextEditingController> phoneNumberController = TextEditingController().obs;

  /*Rx<TextEditingController> totalOrderMeterController =
      TextEditingController().obs;
  Rx<TextEditingController> totalOrderAmountController =
      TextEditingController().obs;*/
  RxString profilePhoto = RxString('');

  @override
  void onInit() {
    getUserData();
    super.onInit();
  }

  getUserData() {
    firstNameController.value.text = Preference.firstName ?? '';
    lastNameController.value.text = Preference.lastName ?? '';
    brandNameController.value.text = Preference.brandName ?? '';
    phoneNumberController.value.text = Preference.phoneNumber ?? '';
    profilePhoto.value = Preference.profileImage ?? '';
    // totalOrderMeterController.value.text = Preference.totalOrderMeter ?? '0';
    // totalOrderAmountController.value.text = Preference.totalOrderAmount ?? '0';
  }

  updateProfileImage() {
    profilePhoto.value = Preference.profileImage ?? '';
  }
}
