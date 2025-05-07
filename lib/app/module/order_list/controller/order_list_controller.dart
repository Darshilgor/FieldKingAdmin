import 'package:field_king_admin/packages/config.dart';
import 'package:field_king_admin/services/firebase_services.dart';

class OrderListController extends GetxController {
  RxInt totalNoOfActiveOrder=RxInt(0);

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
    ).then(
      (e) async {
        Get.back();
        if (status == 'Reached') {
          await FirebaseFirestoreService.updateOrderListStatus(
              orderId: mainOrderId);
        }
      },
    );
  }
}
