import 'package:field_king_admin/packages/config.dart';
import 'package:field_king_admin/services/firebase_services.dart';

class ChatController extends GetxController {
  getUserList() {
    return FirebaseFirestoreService.getUserList();
  }

  getUserDetails({String? userId}) {
    FirebaseFirestoreService.getChatUserDetails(userId: userId).listen(
      (snapshot) {
        final data = snapshot.docs.first.data() as Map<String, dynamic>;
      },
    );
  }
}
