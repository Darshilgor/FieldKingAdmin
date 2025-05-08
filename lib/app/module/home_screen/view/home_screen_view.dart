import 'package:field_king_admin/app/model/get_product_model.dart';
import 'package:field_king_admin/app/module/home_screen/controller/home_screen_controller.dart';
import 'package:field_king_admin/app/module/tab_bar/controller/tab_bar_controller.dart';
import 'package:field_king_admin/packages/config.dart';
import 'package:field_king_admin/packages/screen.dart';
import 'package:field_king_admin/services/app_color/app_colors.dart';
import 'package:field_king_admin/services/app_icon.dart';
import 'package:field_king_admin/services/common_calculation.dart';
import 'package:field_king_admin/services/common_code.dart';
import 'package:field_king_admin/services/custom_app_bar.dart';
import 'package:field_king_admin/services/genera_controller.dart';
import 'package:field_king_admin/services/text_form_field.dart';
import 'package:field_king_admin/services/text_style/text_style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class HomeScreenView extends StatelessWidget {
  HomeScreenView({super.key});

  final controller = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: CustomAppBar(
        leadingWidget: Padding(
          padding: const EdgeInsets.all(
            8,
          ),
          child: GestureDetector(
            onTap: () {
              Get.find<TabBarController>().tabBarKey.currentState?.openDrawer();
            },
            child: SvgPicture.asset(
              Assets.drawerIcon,
              width: 15,
              height: 15,
              colorFilter: ColorFilter.mode(
                AppColor.blackColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        title: Text(
          'Field King',
        ),
        isLeading: false,
      ),
      body: Obx(
        () => ListView.separated(
          separatorBuilder: (context, index) {
            return Gap(20);
          },
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            Product product = controller.products[index];
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: index == 0 ? 10 : 0,
                bottom: index == controller.products.length - 1 ? 20 : 0,
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
                      '${product.size} ${product.type?.capitalize}${(product.type == 'flat' && product.size != '1 MM') ? '(${product.flat})' : ''} Cable',
                      style: TextStyle().medium18.textColor(
                            AppColor.blackColor,
                          ),
                    ),
                    Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Tar : ',
                              style: TextStyle().semiBold16.textColor(
                                    AppColor.blackColor,
                                  ),
                            ),
                            Text(
                              product.amp ?? '',
                              style: TextStyle().regular16.textColor(
                                    AppColor.blackColor,
                                  ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Amp : ',
                              style: TextStyle().semiBold16.textColor(
                                    AppColor.blackColor,
                                  ),
                            ),
                            Text(
                              product.amp ?? '',
                              style: TextStyle().regular16.textColor(
                                    AppColor.blackColor,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Gej : ',
                              style: TextStyle().semiBold16.textColor(
                                    AppColor.blackColor,
                                  ),
                            ),
                            Text(
                              '${product.gej} (${CommonCalculation.calculateGej(product.gej)})',
                              style: TextStyle().regular16.textColor(
                                    AppColor.blackColor,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Visibility(
                      visible: GeneralController.isShowWithOutGst.value,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Price : ',
                            style: TextStyle().semiBold16.textColor(
                                  AppColor.blackColor,
                                ),
                          ),
                          Text(
                            '${product.chipeshPrice} PM with out GST',
                            style: TextStyle().regular16.textColor(
                                  AppColor.blackColor,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Price : ',
                          style: TextStyle().semiBold16.textColor(
                                AppColor.blackColor,
                              ),
                        ),
                        Row(
                          children: [
                            Text(
                              '${product.price} PM ',
                              style: TextStyle().regular16.textColor(
                                    AppColor.blackColor,
                                  ),
                            ),
                            Visibility(
                              visible: GeneralController.isShowWithOutGst.value,
                              child: Text(
                                'with GST',
                                style: TextStyle().regular16.textColor(
                                      AppColor.blackColor,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Gap(5),
                    /* Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          for (int i = 0; i < controller.products.length; i++) {
                            if (controller.products[i].isExpanded == true) {
                              controller.products[i].isExpanded.value = false;
                            }
                          }
                          controller.orderMeterController.value.clear();
                          controller.products[index].isExpanded.value = true;
                        },
                        child: customContainer(
                          title: 'Add to cart',
                          width: Get.width * 0.3,
                        ),
                      ),
                    ),*/
                    /*Obx(
                      () => Visibility(
                        visible: controller.products[index].isExpanded.value,
                        child: Form(
                          key: controller.enterMeterFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Visibility(
                                visible:
                                    GeneralController.isShowWithOutGst.value,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Order type : ',
                                      style: TextStyle().regular18.textColor(
                                            AppColor.blackColor,
                                          ),
                                    ),
                                    Gap(3),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: List.generate(
                                        3,
                                        (index) {
                                          final options = [
                                            '50%',
                                            'With GST',
                                            'Without GST',
                                          ];
                                          return Row(
                                            children: [
                                              Radio<String>(
                                                materialTapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                                visualDensity: VisualDensity(
                                                  horizontal: -4,
                                                  vertical: -4,
                                                ),
                                                value: options[index],
                                                groupValue: controller
                                                    .gstRadioButtonValue.value,
                                                onChanged: (value) {
                                                  controller.gstRadioButtonValue
                                                      .value = value!;
                                                },
                                              ),
                                              Gap(5),
                                              Text(
                                                options[index],
                                                style: TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Gap(10),
                              InputField(
                                controller:
                                    controller.orderMeterController.value,
                                labelText: 'Order Meter',
                                prefixIconColor: AppColor.blackColor,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if ((value ?? '').isEmpty) {
                                    return 'Pelase enter order meter';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              Gap(20),
                              customContainer(
                                title: 'Add',
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),*/
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
