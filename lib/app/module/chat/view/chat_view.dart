import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:field_king_admin/app/module/chat/controller/chat_controller.dart';
import 'package:field_king_admin/packages/config.dart';
import 'package:field_king_admin/packages/screen.dart';
import 'package:field_king_admin/services/app_color/app_colors.dart';
import 'package:field_king_admin/services/common_code.dart';
import 'package:field_king_admin/services/custom_app_bar.dart';
import 'package:gap/gap.dart';

class ChatView extends StatelessWidget {
  ChatView({super.key});

  final controller = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: CustomAppBar(
        title: Text(
          'Chat',
        ),
        isLeading: false,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: controller.getUserList(),
        builder: (context, snapshot) {
          var user = snapshot.data?.docs;
          return ListView.builder(
            itemCount: user?.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: GestureDetector(
                  onTap: () {

                    Get.toNamed(
                      Routes.chatScreenView,
                      arguments: {
                        'userId': user?[index]['userId'],
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
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                              ),
                              child: extendedImage(
                                imageUrl: user?[index]['profilePhoto'] ?? '',
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Gap(10),
                            Column(
                              children: [
                                Text(
                                  '${user?[index]['firstName']} ${user?[index]['lastName']}',
                                ),
                              ],
                            )
                          ],
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
