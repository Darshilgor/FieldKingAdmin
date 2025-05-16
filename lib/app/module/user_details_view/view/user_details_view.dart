import 'package:field_king_admin/app/module/user_details_view/controller/user_details_controller.dart';
import 'package:field_king_admin/packages/config.dart';
import 'package:field_king_admin/packages/screen.dart';
import 'package:field_king_admin/services/app_color/app_colors.dart';
import 'package:field_king_admin/services/app_icon.dart';
import 'package:field_king_admin/services/custom_app_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      body: Column(
        children: [],
      ),
    );
  }
}
