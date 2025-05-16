import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:field_king_admin/app/module/chat_screen/controller/chat_screen_controller.dart';
import 'package:field_king_admin/app/module/chat_screen/image_gallery_view.dart';
import 'package:field_king_admin/app/module/chat_screen/pdf_preview_screen.dart';
import 'package:field_king_admin/packages/config.dart';
import 'package:field_king_admin/packages/screen.dart';
import 'package:field_king_admin/services/app_color/app_colors.dart';
import 'package:field_king_admin/services/close_keyboard.dart';
import 'package:field_king_admin/services/common_code.dart';
import 'package:field_king_admin/services/custom_app_bar.dart';
import 'package:field_king_admin/services/date_utils.dart';
import 'package:field_king_admin/services/show_loader.dart';
import 'package:field_king_admin/services/text_form_field.dart';
import 'package:field_king_admin/services/typing_lottie_file.dart';
import 'package:gap/gap.dart';

class ChatScreenView extends StatefulWidget {
  ChatScreenView({super.key});

  @override
  State<ChatScreenView> createState() => _ChatScreenViewState();
}

class _ChatScreenViewState extends State<ChatScreenView>
    with WidgetsBindingObserver {
  final controller = Get.put(ChatScreenController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    controller.scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    if (bottomInset > 0.0) {
      controller.scrollToBottom();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.isShowDeleteButton.value = false;
      },
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        /*appBar: Row(
          children: [],
        ),*/
        body: SafeArea(
          child: Column(
            children: [
              Container(
                height: 60,
                width: Get.width,
                child: Obx(
                  () => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: controller.isOnline.value
                                      ? Colors.green
                                      : Colors.transparent,
                                  width: controller.isOnline.value ? 2.5 : 0,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: extendedImage(
                                imageUrl: controller.userProfileImage.value,
                                height: 45,
                                width: 45,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Gap(
                              controller.isOnline.value ? 10 : 7.5,
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${controller.userFirstName.value} ${controller.userLastName.value}',
                                ),
                                Text(
                                  controller.isOnline.value == true
                                      ? 'Online'
                                      : DateUtilities.userLastActive(
                                          controller.lastActive.value,
                                        ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: StreamBuilder<DocumentSnapshot>(
                stream: controller.getUserDetails(),
                builder: (context, userSnapshot) {
                  return StreamBuilder<QuerySnapshot>(
                    stream: controller.getChat(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      var chats = snapshot.data?.docs;
                      if ((chats ?? []).isEmpty) {
                        return const Center(
                          child: Text(
                            "No chats available",
                          ),
                        );
                      }
                      if (snapshot.hasData) {
                        WidgetsBinding.instance.addPostFrameCallback(
                          (_) {
                            controller.scrollToBottom();
                          },
                        );

                        return ListView.builder(
                          itemCount: (chats ?? []).length,
                          controller: controller.scrollController,
                          padding: const EdgeInsets.all(10),
                          itemBuilder: (context, index) {
                            var chat =
                                chats?[index].data() as Map<String, dynamic>;
                            bool isSender =
                                chat['senderId'] == Preference.userId;

                            final isSelected =
                                controller.selectedMessageId.value ==
                                    chat['id'];

                            return Align(
                              alignment: isSender
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: 5,
                                  bottom: 5,
                                  left: isSender ? 50 : 10,
                                  right: isSender ? 10 : 50,
                                ),
                                child: chat['messageType'] == 'text'
                                    ? Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(
                                              isSender ? 10 : 0,
                                            ),
                                            bottomRight: Radius.circular(
                                              isSender ? 0 : 10,
                                            ),
                                            topLeft: Radius.circular(
                                              10,
                                            ),
                                            topRight: Radius.circular(
                                              10,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          chat['message'] ?? '',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    : chat['messageType'] == 'image'
                                        ? GestureDetector(
                                            onTap: () {
                                              closeKeyboard();
                                              final imageMessages =
                                                  (chats ?? [])
                                                      .where((e) =>
                                                          (e.data() as Map<
                                                                  String,
                                                                  dynamic>)[
                                                              'messageType'] ==
                                                          'image')
                                                      .toList();

                                              final currentImageIndex =
                                                  imageMessages.indexWhere(
                                                (e) =>
                                                    (e.data() as Map<String,
                                                        dynamic>)['mediaUrl'] ==
                                                    chat['mediaUrl'],
                                              );

                                              Get.to(
                                                () => ImageGalleryView(
                                                  imageUrls: imageMessages
                                                      .map((e) => (e.data()
                                                              as Map<String,
                                                                  dynamic>)[
                                                          'mediaUrl'] as String)
                                                      .toList(),
                                                  initialIndex:
                                                      currentImageIndex,
                                                ),
                                              );
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(
                                                    10,
                                                  ),
                                                  topRight: Radius.circular(
                                                    10,
                                                  ),
                                                  bottomLeft: Radius.circular(
                                                    isSender ? 10 : 0,
                                                  ),
                                                  bottomRight: Radius.circular(
                                                    isSender ? 0 : 10,
                                                  ),
                                                ),
                                                border: Border.all(
                                                  color: AppColor.blackColor,
                                                ),
                                              ),
                                              child: extendedImage(
                                                onLongPress: () {
                                                  controller.isShowDeleteButton
                                                          .value =
                                                      !controller
                                                          .isShowDeleteButton
                                                          .value;
                                                },
                                                imageUrl: chat['mediaUrl'],
                                                height: Get.height * 0.2,
                                                width: Get.width * 0.7,
                                                fit: BoxFit.fitWidth,
                                                boxShap: BoxShape.rectangle,
                                                catchHeight: 2000,
                                                catchWidth: 2000,
                                                circularProcessPadding:
                                                    const EdgeInsets.all(
                                                  100,
                                                ),
                                                BorderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(
                                                    9,
                                                  ),
                                                  topLeft: Radius.circular(
                                                    9,
                                                  ),
                                                  bottomLeft: Radius.circular(
                                                    isSender ? 9 : 0,
                                                  ),
                                                  bottomRight: Radius.circular(
                                                    isSender ? 0 : 9,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : GestureDetector(
                                            onLongPress: () {
                                              controller.longPressed.value =
                                                  true;
                                              controller.isShowDeleteButton
                                                      .value =
                                                  !controller
                                                      .isShowDeleteButton.value;
                                              Future.delayed(
                                                const Duration(
                                                    milliseconds: 300),
                                                () {
                                                  controller.longPressed.value =
                                                      false;
                                                },
                                              );
                                            },
                                            onTap: () {
                                              if (controller.longPressed.value)
                                                return;
                                              closeKeyboard();
                                              Get.to(
                                                () => PdfViewerScreen(
                                                  pdfUrl: chat['mediaUrl'],
                                                ),
                                              );
                                            },
                                            child: Container(
                                              width: 200,
                                              padding: const EdgeInsets.all(
                                                10,
                                              ),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: AppColor.blackColor,
                                                ),
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(
                                                    10,
                                                  ),
                                                  topRight: Radius.circular(
                                                    10,
                                                  ),
                                                  bottomLeft: Radius.circular(
                                                    isSender ? 10 : 0,
                                                  ),
                                                  bottomRight: Radius.circular(
                                                    isSender ? 0 : 10,
                                                  ),
                                                ),
                                                color: Colors.white,
                                              ),
                                              child: const Row(
                                                children: [
                                                  Icon(Icons.picture_as_pdf,
                                                      color: Colors.red,
                                                      size: 40),
                                                  SizedBox(width: 10),
                                                  Expanded(
                                                    child: Text(
                                                      "View PDF",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                              ),
                            );
                          },
                        );
                      } else {
                        return Container();
                      }
                    },
                  );
                },
              )),
              Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => Visibility(
                        visible: controller.isTyping.value,
                        child: const TypingIndicator(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        bottom: 10,
                        top: 5,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColor.blackColor,
                          ),
                          borderRadius: BorderRadius.circular(
                            20,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: InputField(
                                controller: controller.messageController.value,
                                hintText: 'Type a message...',
                                textInputAction: TextInputAction.done,
                                validator: (value) {},
                                onChange: (value) {
                                  controller.messageController.refresh();
                                  controller.updateTypingStatus(
                                    isTyping:
                                        (value ?? '').isNotEmpty ? true : false,
                                    userId: controller.adminId.value,
                                  );
                                },
                                minLine: 1,
                                maxLine: 3,
                                border: InputBorder.none,
                                disableBorder: InputBorder.none,
                                enableBorder: InputBorder.none,
                                focusBorder: InputBorder.none,
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    openBottomSheet();
                                  },
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.grey,
                                    size: 30,
                                  ),
                                ),
                                const Gap(5),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    right: 5,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.scrollToBottom();
                                      controller.sendMessage(
                                        adminId: controller.adminId.value,
                                        message: controller
                                            .messageController.value.text,
                                        userId: controller.userId.value,
                                      );
                                    },
                                    child: Icon(
                                      Icons.send,
                                      size: 25,
                                      color: controller.messageController.value
                                              .text.isNotEmpty
                                          ? Colors.blue
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  openBottomSheet() {
    return showModalBottomSheet(
      context: Get.context!,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.attach_file, color: Colors.blue),
                title: const Text("Choose a File"),
                onTap: () {
                  Get.back();
                  controller.pickDocument();
                },
              ),
              ListTile(
                leading: const Icon(Icons.image, color: Colors.green),
                title: const Text("Pick from Gallery"),
                onTap: () {
                  Get.back();
                  controller.pickImageFromGallery();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.red),
                title: const Text("Take a Photo"),
                onTap: () {
                  Get.back();
                  controller.takePhoto();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
