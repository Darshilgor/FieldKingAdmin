import 'package:field_king_admin/app/model/order_history_details_model.dart';
import 'package:field_king_admin/packages/config.dart';

class UserOrderHistoryDetailsController extends GetxController {
  RxList<OrderHistoryItem> orderHistoryList = RxList<OrderHistoryItem>();

  @override
  void onInit() {
    getArgument();
    super.onInit();
  }

  getArgument() {
    var argument = Get.arguments;
    if (argument != null && argument['orderHistory'] != null) {
      final List<dynamic> rawList = argument['orderHistory'];

      orderHistoryList.value =
          rawList.map((e) => OrderHistoryItem.fromJson(e)).toList();
    }
  }
}
