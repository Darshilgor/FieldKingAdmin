import 'package:field_king_admin/app/module/user_order_history/controller/user_order_history_controller.dart';
import 'package:field_king_admin/packages/config.dart';
import 'package:field_king_admin/packages/screen.dart';
import 'package:field_king_admin/services/app_button.dart';
import 'package:field_king_admin/services/app_color/app_colors.dart';
import 'package:field_king_admin/services/common_code.dart';
import 'package:field_king_admin/services/custom_app_bar.dart';
import 'package:field_king_admin/services/date_utils.dart';
import 'package:gap/gap.dart';

class UserOrderHistoryView extends StatelessWidget {
  UserOrderHistoryView({super.key});

  final controller = Get.put(UserOrderHistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: CustomAppBar(
        title: Text(
          'User Order List',
        ),
        isLeading: true,
      ),
      body: Obx(
        () {
          return ListView.builder(
            itemCount: controller.orderList.length,
            itemBuilder: (context, index) {
              var order = controller.orderList[index];

              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(
                      Routes.userOrderhistoryDetailsView,
                      arguments: {
                        'orderHistory': order['order'],
                      },
                    );
                  },
                  child: Container(
                    width: Get.width,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 12,
                    ),
                    decoration: ContainerDecoration.decoration(),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Order Id : ',
                              style: TextStyle(
                                color: AppColor.blackColor,
                              ),
                            ),
                            Text(
                              order['orderId'] ?? '',
                              style: TextStyle(
                                color: AppColor.blackColor,
                              ),
                            ),
                          ],
                        ),
                        Gap(5),
                        Row(
                          children: [
                            Text(
                              'Order date : ',
                              style: TextStyle(
                                color: AppColor.blackColor,
                              ),
                            ),
                            Text(
                              DateUtilities.formatFirestoreDate(
                                order['createdAt'],
                              ),
                              style: TextStyle(
                                color: AppColor.blackColor,
                              ),
                            ),
                          ],
                        ),
                        Gap(5),
                        Row(
                          children: [
                            Text(
                              'Total sub order : ',
                              style: TextStyle(
                                color: AppColor.blackColor,
                              ),
                            ),
                            Text(
                              (order['order'] ?? []).length.toString(),
                              style: TextStyle(
                                color: AppColor.blackColor,
                              ),
                            ),
                          ],
                        ),
                        Gap(5),
                        Row(
                          children: [
                            Text(
                              'Total order meter : ',
                              style: TextStyle(
                                color: AppColor.blackColor,
                              ),
                            ),
                            Text(
                              order['totalOrderMeter'] ?? '',
                              style: TextStyle(
                                color: AppColor.blackColor,
                              ),
                            ),
                          ],
                        ),
                        Gap(5),
                        Row(
                          children: [
                            Text(
                              'Total order amount : ',
                              style: TextStyle(
                                color: AppColor.blackColor,
                              ),
                            ),
                            Text(
                              order['totalOrderAmout'] ?? '',
                              style: TextStyle(
                                color: AppColor.blackColor,
                              ),
                            ),
                          ],
                        ),
                        Gap(5),
                        Row(
                          children: [
                            Text(
                              'Payment type : ',
                              style: TextStyle(
                                color: AppColor.blackColor,
                              ),
                            ),
                            Text(
                              order['paymentType'] ?? '',
                              style: TextStyle(
                                color: AppColor.blackColor,
                              ),
                            ),
                          ],
                        ),
                        Gap(5),
                        Row(
                          children: [
                            Text(
                              'Payment status : ',
                              style: TextStyle(
                                color: AppColor.blackColor,
                              ),
                            ),
                            Text(
                              order['paymentStatus'].toString(),
                              style: TextStyle(
                                color: AppColor.blackColor,
                              ),
                            ),
                          ],
                        ),
                        Gap(20),
                        CommonAppButton(
                          text: 'Update Payment Status',
                          buttonType: ButtonType.enable,
                          onTap: () async {
                            bool currentStatus = order['paymentStatus'] == true;
                            await controller.updatePaymentStatus(
                              orderId: order['orderId'],
                              userId: controller.userId.value,
                              paymentStatus: !currentStatus,
                            );
                            controller.orderList[index]['paymentStatus'] =
                                !currentStatus;

                            controller.orderList.refresh();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
