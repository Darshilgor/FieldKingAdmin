import 'package:field_king_admin/packages/config.dart';
import 'package:field_king_admin/packages/screen.dart';
import 'package:field_king_admin/services/firebase_services.dart';

class ChatController extends GetxController {
  Rx<TextEditingController> searchController = TextEditingController().obs;
  final searchQuery = ''.obs;
  final debouncedQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    debounce(searchQuery, (val) {
      debouncedQuery.value = val;
    }, time: Duration(milliseconds: 300));
  }

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
