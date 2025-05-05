import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:field_king_admin/app/module/order_list/controller/order_list_controller.dart';
import 'package:field_king_admin/packages/config.dart';
import 'package:field_king_admin/packages/screen.dart';
import 'package:field_king_admin/services/app_button.dart';
import 'package:field_king_admin/services/app_color/app_colors.dart';
import 'package:field_king_admin/services/common_code.dart';
import 'package:field_king_admin/services/custom_app_bar.dart';
import 'package:field_king_admin/services/date_utils.dart';
import 'package:gap/gap.dart';

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
      body: StreamBuilder<QuerySnapshot>(
        stream: controller.getOrderlist(),
        builder: (context, snapshot) {
          var order = snapshot.data?.docs;
          return ListView.builder(
            itemCount: order?.length,
            itemBuilder: (contex, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(
                      Routes.orderDetailsView,
                      arguments: {
                        'orderDetails': order?[index],
                      },
                    );
                  },
                  child: Container(
                    width: Get.width,
                    decoration: ContainerDecoration.decoration(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Order Date',
                            ),
                            Text(
                              DateUtilities.formatFirestoreDate(
                                order?[index]['createdAt'],
                              ),
                            ),
                          ],
                        ),
                        Gap(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Order Id',
                            ),
                            Text(
                              order?[index]['orderId'],
                            ),
                          ],
                        ),
                        Gap(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Order Meter',
                            ),
                            Text(
                              order?[index]['totalOrderMeter'],
                            ),
                          ],
                        ),
                        Gap(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Order Amount',
                            ),
                            Text(
                              order?[index]['totalOrderAmout'],
                            ),
                          ],
                        ),
                        Gap(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Payment Type',
                            ),
                            Text(
                              (order?[index]['paymentType'] ?? false)
                                  .toString(),
                            ),
                          ],
                        ),
                        Gap(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Payment Status',
                            ),
                            Text(
                              (order?[index]['paymentStatus'] ?? false)
                                  .toString(),
                            ),
                          ],
                        ),
                        Gap(15),
                        Text(
                          'User Details : ',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColor.blackColor,
                          ),
                        ),
                        Gap(15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Name',
                            ),
                            Text(
                              '${order?[index]['userDetails']['firstName']} ${order?[index]['userDetails']['lastName']}',
                            ),
                          ],
                        ),
                        Gap(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Phone No',
                            ),
                            Text(
                              order?[index]['userDetails']['phoneNo'],
                            ),
                          ],
                        ),
                        Gap(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Brand Name',
                            ),
                            Text(
                              order?[index]['userDetails']['brandName'],
                            ),
                          ],
                        ),
                        CommonAppButton(
                          text: 'Update Order Status',
                          buttonColor: AppColor.whiteColor,
                          isBorder: true,
                          textColor: AppColor.blackColor,
                          buttonType: ButtonType.enable,
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16)),
                              ),
                              builder: (context) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 20,
                                    horizontal: 20,
                                  ),
                                  child: Container(
                                    width: Get.width,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Update Order Status',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: AppColor.blackColor,
                                          ),
                                        ),
                                        Gap(10),
                                        GestureDetector(
                                          onTap: () {
                                            controller.updateStatus(
                                              status: 'Pending',
                                              userId: order?[index]
                                                  ['userDetails']?['userId'],
                                              mainOrderId: order?[index]
                                                  ['orderListId'],
                                              userOrderCollectionId:
                                                  order?[index]['orderId'],
                                              index: index,
                                            );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 10,
                                            ),
                                            width: Get.width,
                                            child: Text(
                                              'Pending',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: AppColor.blackColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            controller.updateStatus(
                                              status: 'In Progress',
                                              userId: order?[index]
                                                  ['userDetails']?['userId'],
                                              mainOrderId: order?[index]
                                                  ['orderListId'],
                                              userOrderCollectionId:
                                                  order?[index]['orderId'],
                                              index: index,
                                            );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 10,
                                            ),
                                            width: Get.width,
                                            child: Text(
                                              'In Progress',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: AppColor.blackColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            controller.updateStatus(
                                              status: 'Production Done',
                                              userId: order?[index]
                                                  ['userDetails']?['userId'],
                                              mainOrderId: order?[index]
                                                  ['orderListId'],
                                              userOrderCollectionId:
                                                  order?[index]['orderId'],
                                              index: index,
                                            );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 10,
                                            ),
                                            width: Get.width,
                                            child: Text(
                                              'Production Done',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: AppColor.blackColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            controller.updateStatus(
                                              status: 'Dispatched',
                                              userId: order?[index]
                                                  ['userDetails']?['userId'],
                                              mainOrderId: order?[index]
                                                  ['orderListId'],
                                              userOrderCollectionId:
                                                  order?[index]['orderId'],
                                              index: index,
                                            );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 10,
                                            ),
                                            width: Get.width,
                                            child: Text(
                                              'Dispatched',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: AppColor.blackColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Gap(10),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
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
