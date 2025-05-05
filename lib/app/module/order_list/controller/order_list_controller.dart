import 'package:field_king_admin/packages/config.dart';
import 'package:field_king_admin/services/firebase_services.dart';

class OrderListController extends GetxController {
  getOrderlist() {
    return FirebaseFirestoreService.getOrderList();
  }

  updateStatus({
    required String status,
    required userId,
    required mainOrderId,
    required userOrderCollectionId,
    required int index,
  }) async {
    await FirebaseFirestoreService.updateAllSubOrderStatus(
      userId: userId,
      status: status,
      orderCollectionId: userOrderCollectionId,
      orderListId: mainOrderId,
    ).then((e) {
      Get.back();
    });
  }
}
