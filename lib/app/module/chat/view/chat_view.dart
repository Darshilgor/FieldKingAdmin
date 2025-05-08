import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:field_king_admin/app/module/chat/controller/chat_controller.dart';
import 'package:field_king_admin/packages/config.dart';
import 'package:field_king_admin/packages/screen.dart';
import 'package:field_king_admin/services/app_color/app_colors.dart';
import 'package:field_king_admin/services/common_code.dart';
import 'package:field_king_admin/services/custom_app_bar.dart';
import 'package:field_king_admin/services/date_utils.dart';
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
              return GestureDetector(
                onTap: () {
                  Get.toNamed(
                    Routes.chatScreenView,
                    arguments: {
                      'userId': user?[index]['userId'],
                    },
                  );
                },
                child: Column(
                  children: [
                    Container(
                      width: Get.width,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      // decoration: ContainerDecoration.decoration(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: user?[index]['isOnline']
                                        ? Colors.green
                                        : Colors.transparent,
                                    width: user?[index]['isOnline'] ? 2.5 : 0,
                                  ),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${user?[index]['firstName']} ${user?[index]['lastName']}',
                                  ),
                                  Text(
                                    user?[index]['isOnline'] == true
                                        ? 'Online'
                                        : DateUtilities.userLastActive(
                                            user?[index]['lastActive'],
                                          ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: (user?.length ?? 0) - 1 != index,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Divider(
                          color: Colors.grey,
                          height: 1,
                          thickness: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
