import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:field_king_admin/packages/config.dart';
import 'package:field_king_admin/services/firebase_services.dart';

class UserDetailsController extends GetxController {
  RxString userId = RxString('');

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

  getUserDetails() {
    FirebaseFirestoreService.getUserDetails(
      userId: userId.value,
    ).then((value) {
      print('User details is ${value.data()}');
    });
  }
}
