import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:field_king_admin/app/module/order_list/controller/order_list_controller.dart';
import 'package:field_king_admin/packages/config.dart';
import 'package:field_king_admin/packages/screen.dart';
import 'package:field_king_admin/services/app_color/app_colors.dart';
import 'package:field_king_admin/services/custom_app_bar.dart';

class OrderListView extends StatelessWidget {
  OrderListView({super.key});

  final controller = Get.put(OrderListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: CustomAppBar(
        title: Text(
          'Order List',
        ),
        isLeading: false,
      ),
      /*body: StreamBuilder<QuerySnapshot>(
        stream: controller.getOrderlist(),
        builder: (context, snapshot) {},
      ),*/
    );
  }
}
