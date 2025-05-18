import 'package:field_king_admin/app/model/order_history_details_model.dart';
import 'package:field_king_admin/app/module/user_order_history_details/controller/user_order_history_details_controller.dart';
import 'package:field_king_admin/packages/config.dart';
import 'package:field_king_admin/packages/screen.dart';
import 'package:field_king_admin/services/app_color/app_colors.dart';
import 'package:field_king_admin/services/common_code.dart';
import 'package:field_king_admin/services/custom_app_bar.dart';
import 'package:field_king_admin/services/date_utils.dart';
import 'package:gap/gap.dart';

class UserOrderHistoryDetailssView extends StatelessWidget {
  UserOrderHistoryDetailssView({super.key});

  final controller = Get.put(UserOrderHistoryDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: CustomAppBar(
        title: Text(
          'User Order Details',
        ),
        isLeading: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        itemCount: controller.orderHistoryList.length,
        itemBuilder: (context, index) {
          OrderHistoryItem order = controller.orderHistoryList[index];
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Container(
              width: Get.width,
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              decoration: ContainerDecoration.decoration(),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        '${order.size} ${order.type?.capitalize} Cable',
                      ),
                    ],
                  ),
                  Gap(5),
                  Row(
                    children: [
                      Text('Sub order id : '),
                      Text(
                        order.subOrderId ?? '',
                      ),
                    ],
                  ),
                  Gap(5),
                  Row(
                    children: [
                      Text('Gej : '),
                      Text(
                        order.gej ?? '',
                      ),
                    ],
                  ),
                  Visibility(
                    visible: order.isWithGST != 'With GST',
                    child: Column(
                      children: [
                        Gap(5),
                        Row(
                          children: [
                            Text('Price : '),
                            Text(
                              order.PPMOO1 ?? '',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: order.isWithGST == 'With GST' ||
                        order.isWithGST == '50%',
                    child: Column(
                      children: [
                        Gap(5),
                        Row(
                          children: [
                            Text('GST price : '),
                            Text(
                              order.PPMOO2 ?? '',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Gap(5),
                  Row(
                    children: [
                      Text('Order type : '),
                      Text(
                        order.isWithGST == '50%'
                            ? '50% with GST'
                            : order.isWithGST ?? '',
                      ),
                    ],
                  ),
                  Gap(5),
                  Row(
                    children: [
                      Text('Order status : '),
                      Text(
                        order.orderStatus ?? '',
                      ),
                    ],
                  ),
                  Gap(5),
                  Row(
                    children: [
                      Text('Total order meter : '),
                      Text(
                        order.totalMeter ?? '',
                      ),
                    ],
                  ),
                  Gap(5),
                  Row(
                    children: [
                      Text('Total order amount : '),
                      Text(
                        order.totalAmount ?? '',
                      ),
                    ],
                  ),
                  Gap(5),
                  Row(
                    children: [
                      Text('Delivered Date : '),
                      Text(
                        DateUtilities.formatFirestoreDate(
                                  order.deliverDate,
                                ) ==
                                'Invalid Date'
                            ? 'Deliver soon!'
                            : DateUtilities.formatFirestoreDate(
                                order.deliverDate,
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
