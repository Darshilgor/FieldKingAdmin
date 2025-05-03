import 'package:field_king_admin/packages/config.dart';
import 'package:field_king_admin/packages/screen.dart';
import 'package:field_king_admin/services/app_color/app_colors.dart';
import 'package:field_king_admin/services/text_style/text_style.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: CustomAppBar(
        title: Text(
          'Profile',
        ),
        isLeading: true,
        action: [
          Padding(
            padding: const EdgeInsets.only(
              right: 20,
            ),
            child: GestureDetector(
              onTap: () {
                Get.toNamed(
                  Routes.editProfile,
                );
              },
              child: Text(
                'Edit',
                style: TextStyle().regular16.textColor(
                  AppColor.blackColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
