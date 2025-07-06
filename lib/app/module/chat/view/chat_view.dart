import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:field_king_admin/app/module/chat/controller/chat_controller.dart';
import 'package:field_king_admin/app/module/tab_bar/controller/tab_bar_controller.dart';
import 'package:field_king_admin/packages/config.dart';
import 'package:field_king_admin/packages/screen.dart';
import 'package:field_king_admin/services/app_color/app_colors.dart';
import 'package:field_king_admin/services/app_icon.dart';
import 'package:field_king_admin/services/common_code.dart';
import 'package:field_king_admin/services/custom_app_bar.dart';
import 'package:field_king_admin/services/date_utils.dart';
import 'package:field_king_admin/services/text_form_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class ChatView extends StatelessWidget {
  ChatView({super.key});

  final controller = Get.put(ChatController());

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
          'Chat',
        ),
        isLeading: false,
      ),
      body: Column(
        children: [
          Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: InputField(
                controller: controller.searchController.value,
                labelText: 'Search',
                hintText: 'Gor',
                isPngPrefixIcon: false,
                prefixIcon: Assets.searchIcon,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.search,
                validator: (value) {
                  return null;
                },
                onChange: (value) {
                  controller.searchQuery.value =
                      (value ?? '').trim().toLowerCase();
                },
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: controller.getUserList(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(child: CircularProgressIndicator());

                var user = snapshot.data!.docs;
                return Obx(() {
                  final query = controller.debouncedQuery.value;

                  var filteredUsers = user.where((doc) {
                    final firstName =
                        (doc['firstName'] ?? '').toString().toLowerCase();
                    final lastName =
                        (doc['lastName'] ?? '').toString().toLowerCase();
                    final fullName = "$firstName $lastName";

                    return firstName.contains(query) ||
                        lastName.contains(query) ||
                        fullName.contains(query);
                  }).toList();

                  if (filteredUsers.isEmpty) {
                    return const Center(child: Text('No users found.'));
                  }
                  return ListView.builder(
                    itemCount: filteredUsers.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            Routes.chatScreenView,
                            arguments: {
                              'userId': user[index]['userId'],
                            },
                          );
                        },
                        child: Container(
                          width: Get.width,
                          color: Colors.transparent,
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
                                              color: user?[index]['isOnline'] ??
                                                      false
                                                  ? Colors.green
                                                  : Colors.transparent,
                                              width: user?[index]['isOnline'] ??
                                                      false
                                                  ? 2.5
                                                  : 0,
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                          child: extendedImage(
                                            imageUrl: user?[index]
                                                    ['profilePhoto'] ??
                                                '',
                                            height: 40,
                                            width: 40,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Gap(10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${user?[index]['firstName']} ${user?[index]['lastName']}',
                                            ),
                                            Text(
                                              (user?[index]['isOnline'] ??
                                                          false) ==
                                                      true
                                                  ? 'Online'
                                                  : DateUtilities
                                                      .userLastActive(
                                                      user?[index]
                                                          ['lastActive'],
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
                        ),
                      );
                    },
                  );
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
