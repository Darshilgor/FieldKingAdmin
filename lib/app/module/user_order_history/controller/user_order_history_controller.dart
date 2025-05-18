import 'package:field_king_admin/packages/config.dart';
import 'package:field_king_admin/services/firebase_services.dart';

class UserOrderHistoryController extends GetxController {
  RxList<Map<String, dynamic>> orderList = <Map<String, dynamic>>[].obs;
  RxString userId = RxString('');

  @override
  void onInit() {
    getArgument();
    super.onInit();
  }

  void getUserOrderHistory() async {
    final snapshot = await FirebaseFirestoreService.getUserOrderList(
      userId: userId.value,
    );

    orderList.value =
        snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    print('order list is ${orderList.value}');
  }

  getArgument() {
    var aguemnt = Get.arguments;
    if (aguemnt != null) {
      userId.value = aguemnt['userId'];
    }
    getUserOrderHistory();
  }

  updatePaymentStatus({String? userId, String? orderId, bool? paymentStatus}) {
    return FirebaseFirestoreService.updatePaymentStatus(
      userId: userId,
      orderId: orderId,
      status: paymentStatus,
    );
  }
}
