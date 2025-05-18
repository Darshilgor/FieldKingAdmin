import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:field_king_admin/packages/config.dart';
import 'package:field_king_admin/services/firebase_services.dart';

class UserDetailsController extends GetxController {
  RxString userId = RxString('');
  Rx<Map<String, dynamic>?> user = Rx<Map<String, dynamic>?>(null);

  @override
  void onInit() {
    getArgument();
    super.onInit();
  }

  getArgument() {
    var argument = Get.arguments;
    if (argument != null) {
      userId.value = argument['userId'];
      getUserDetails();
    }
  }

  void getUserDetails() async {
    final doc =
        await FirebaseFirestoreService.getUserDetails(userId: userId.value);
    user.value = doc.data() as Map<String, dynamic>?;
  }
}
