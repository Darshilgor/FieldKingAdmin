import 'package:field_king_admin/app/module/user_details_view/controller/user_details_controller.dart';
import 'package:field_king_admin/packages/config.dart';
import 'package:field_king_admin/packages/screen.dart';
import 'package:field_king_admin/services/app_button.dart';
import 'package:field_king_admin/services/app_color/app_colors.dart';
import 'package:field_king_admin/services/app_icon.dart';
import 'package:field_king_admin/services/common_code.dart';
import 'package:field_king_admin/services/custom_app_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class UserDetailsView extends StatelessWidget {
  UserDetailsView({super.key});

  final controller = Get.put(UserDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: CustomAppBar(
        title: Text(
          'User Details',
        ),
        isLeading: true,
      ),
      body: Obx(() {
        final userData = controller.user.value;

        if (userData == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Column(
            children: [
              Gap(10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
                child: extendedImage(
                  imageUrl: userData['profilePhoto'],
                  height: 135,
                  width: 135,
                  fit: BoxFit.cover,
                ),
              ),
              Gap(30),
              Row(
                children: [
                  Text(
                    'Name : ',
                  ),
                  Text(
                    '${userData['firstName']} ${userData['lastName']}',
                  ),
                ],
              ),
              Gap(10),
              Row(
                children: [
                  Text(
                    'Brand name : ',
                  ),
                  Text(
                    userData['brandName'],
                  ),
                ],
              ),
              Gap(10),
              Row(
                children: [
                  Text(
                    'Phone No : ',
                  ),
                  Text(
                    userData['phoneNo'],
                  ),
                ],
              ),
              Gap(10),
              Row(
                children: [
                  Text(
                    'Phone No : ',
                  ),
                  Text(
                    userData['phoneNo'],
                  ),
                ],
              ),
              Gap(10),
              Row(
                children: [
                  Text(
                    'Total order meter : ',
                  ),
                  Text(
                    userData['totalOrderMeter'],
                  ),
                ],
              ),
              Gap(10),
              Row(
                children: [
                  Text(
                    'Total order amount : ',
                  ),
                  Text(
                    userData['totalOrderAmount'],
                  ),
                ],
              ),
              CommonAppButton(
                text: 'Order Details',
                buttonType: ButtonType.enable,
                onTap: () {
                  Get.toNamed(
                      Routes.userOrderHistoryView,
                    arguments: {
                      'userId': controller.userId.value,
                    },
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
