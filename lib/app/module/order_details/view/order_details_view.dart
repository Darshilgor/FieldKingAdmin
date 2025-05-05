import 'package:field_king_admin/app/module/order_details/controller/order_details_controller.dart';
import 'package:field_king_admin/packages/config.dart';
import 'package:field_king_admin/packages/screen.dart';
import 'package:field_king_admin/services/app_button.dart';
import 'package:field_king_admin/services/app_color/app_colors.dart';
import 'package:field_king_admin/services/common_code.dart';
import 'package:field_king_admin/services/custom_app_bar.dart';
import 'package:field_king_admin/services/date_utils.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';

class OrderDetailsView extends StatelessWidget {
  OrderDetailsView({super.key});

  final controller = Get.put(OrderDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: CustomAppBar(
        title: Text(
          'Order Details',
        ),
        isLeading: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              child: Container(
                width: Get.width,
                decoration: ContainerDecoration.decoration(),
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Order Details',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColor.blackColor,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Order Time : ',
                        ),
                        Text(
                          DateUtilities.formatFirestoreDate(
                            controller.order.value?['createdAt'],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Order Id : ',
                        ),
                        Text(
                          controller.order.value?['orderId'],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Order Meter :',
                        ),
                        Text(
                          controller.order.value?['totalOrderMeter'],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Order Amount :',
                        ),
                        Text(
                          controller.order.value?['totalOrderAmout'],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Payment type :',
                        ),
                        Text(
                          controller.order.value?['paymentType'],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Payment status :',
                        ),
                        Text(
                          (controller.order.value?['paymentStatus'] ?? false)
                              .toString(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
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
                    Text(
                      'Order Details',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColor.blackColor,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                          ),
                          child: extendedImage(
                            imageUrl: controller.order.value?['userDetails']
                                ['profilePhoto'],
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Gap(10),
                        Text(
                          '${controller.order.value?['userDetails']['firstName']}${controller.order.value?['userDetails']['lastName']}',
                          style: TextStyle(
                            fontSize: 20,
                            color: AppColor.blackColor,
                          ),
                        ),
                      ],
                    ),
                    Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'User Id :',
                        ),
                        Text(
                          controller.order.value?['userDetails']['userId'],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Phone No : ',
                        ),
                        Text(
                          controller.order.value?['userDetails']['phoneNo'],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Location : ',
                        ),
                        Text(
                          controller.order.value?['userDetails']['location'],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Brand Name : ',
                        ),
                        Text(
                          controller.order.value?['userDetails']['brandName'],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Text(
                'Order List',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColor.blackColor,
                ),
              ),
            ),
            Gap(10),
           Obx(()=> Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: List.generate(
               controller.order.value?['order'].length ?? 0,
                   (index) {
                 final item = controller.order.value?['order'][index];
                 return Padding(
                   padding: const EdgeInsets.symmetric(
                     vertical: 10,
                     horizontal: 20,
                   ),
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
                         Text(
                           '${item?['size']} ${item?['type'].toString().capitalize}${(item?['type'] == 'flat' && item?['size'] != '1 MM') ? '(${item?['flat']})' : ''} Cable',
                         ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text('Sub Order Id : '),
                             Text(item['subOrderId']),
                           ],
                         ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text('Gej : '),
                             Text(item['gej']),
                           ],
                         ),
                         Visibility(
                           visible: item['isWithGST'] != 'With GST',
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text('Price : '),
                               Text(item['PPMOO1']),
                             ],
                           ),
                         ),
                         Visibility(
                           visible: item?['isWithGST'] == 'With GST' ||
                               item?['isWithGST'] == '50%',
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text('GST Price : '),
                               Text(item['PPMOO2']),
                             ],
                           ),
                         ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text('Order Type : '),
                             Text(item['isWithGST']),
                           ],
                         ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text('Order Status : '),
                             Text(item['orderStatus']),
                           ],
                         ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text('Order Meter : '),
                             Text(item['totalMeter']),
                           ],
                         ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text('Order Amount : '),
                             Text(item['totalAmount']),
                           ],
                         ),
                         Gap(20),
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
                                             if (item['orderStatus'] !=
                                                 'Pending') {
                                               controller.updateStatus(
                                                 status: 'Pending',
                                                 userId: controller
                                                     .order.value?['userDetails']
                                                 ['userId'],
                                                 subOrderId:
                                                 item['subOrderId'],
                                                 mainOrderId: controller
                                                     .order.value?['orderListId'],
                                                 userOrderCollectionId:
                                                 controller
                                                     .order.value?['orderId'],
                                                 index: index,
                                               );
                                             }
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
                                                 color: item['orderStatus'] ==
                                                     'Pending'
                                                     ? Colors.grey
                                                     : AppColor.blackColor,
                                               ),
                                             ),
                                           ),
                                         ),
                                         GestureDetector(
                                           onTap: () {
                                             if (item['orderStatus'] !=
                                                 'In Progress') {
                                               controller.updateStatus(
                                                 status: 'In Progress',
                                                 userId: controller
                                                     .order.value?['userDetails']
                                                 ['userId'],
                                                 subOrderId:
                                                 item['subOrderId'],
                                                 mainOrderId: controller
                                                     .order.value?['orderListId'],
                                                 userOrderCollectionId:
                                                 controller
                                                     .order.value?['orderId'],
                                                 index: index,
                                               );
                                             }
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
                                                 color: item['orderStatus'] ==
                                                     'In Progress'
                                                     ? Colors.grey
                                                     : AppColor.blackColor,
                                               ),
                                             ),
                                           ),
                                         ),
                                         GestureDetector(
                                           onTap: () {
                                             if (item['orderStatus'] !=
                                                 'Production Done') {
                                               controller.updateStatus(
                                                 status: 'Production Done',
                                                 userId: controller
                                                     .order.value?['userDetails']
                                                 ['userId'],
                                                 subOrderId:
                                                 item['subOrderId'],
                                                 mainOrderId: controller
                                                     .order.value?['orderListId'],
                                                 userOrderCollectionId:
                                                 controller
                                                     .order.value?['orderId'],
                                                 index: index,
                                               );
                                             }
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
                                                 color: item['orderStatus'] ==
                                                     'Production Done'
                                                     ? Colors.grey
                                                     : AppColor.blackColor,
                                               ),
                                             ),
                                           ),
                                         ),
                                         GestureDetector(
                                           onTap: () {
                                             if (item['orderStatus'] !=
                                                 'Dispatched') {
                                               controller.updateStatus(
                                                 status: 'Dispatched',
                                                 userId: controller
                                                     .order.value?['userDetails']
                                                 ['userId'],
                                                 subOrderId:
                                                 item['subOrderId'],
                                                 mainOrderId: controller
                                                     .order.value?['orderListId'],
                                                 userOrderCollectionId:
                                                 controller
                                                     .order.value?['orderId'],
                                                 index: index,
                                               );
                                             }
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
                                                 color: item['orderStatus'] ==
                                                     'Dispatched'
                                                     ? Colors.grey
                                                     : AppColor.blackColor,
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
                 );
               },
             ),
           ),),
          ],
        ),
      ),
    );
  }
}
