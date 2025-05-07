import 'package:field_king_admin/packages/config.dart';
import 'package:field_king_admin/services/firebase_services.dart';

class ChatController extends GetxController {
  getUserList() {
    return FirebaseFirestoreService.getUserList();
  }

}
