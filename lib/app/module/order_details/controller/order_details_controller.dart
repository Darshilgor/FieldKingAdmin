import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:field_king_admin/packages/config.dart';
import 'package:field_king_admin/services/firebase_services.dart';
import 'package:firebase_storage/firebase_storage.dart';

class OrderDetailsController extends GetxController {
  Rxn<DocumentSnapshot> order = Rxn<DocumentSnapshot>();

  @override
  void onInit() {
    getArgument();
    super.onInit();
  }

  getArgument() {
    var argument = Get.arguments;
    if (argument != null) {
      order.value = argument['orderDetails'];
    }
  }

  updateStatus({
    String? status,
    String? subOrderId,
    String? userId,
    String? mainOrderId,
    String? userOrderCollectionId,
    int? index,
  }) async {
    await FirebaseFirestoreService.updateOrderStatus(
      userId: userId,
      mainOrderId: mainOrderId,
      status: status,
      subOrderId: subOrderId,
      userOrderCollectionId: userOrderCollectionId,
    ).then(
      (e) async {
        final updatedDoc = await FirebaseFirestore.instance
            .collection('OrderList')
            .doc(mainOrderId)
            .get();
        order.value = updatedDoc;

        order.refresh();
        Get.back();
      },
    );
  }
}
