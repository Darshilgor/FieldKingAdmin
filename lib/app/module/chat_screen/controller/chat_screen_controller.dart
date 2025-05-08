import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:field_king_admin/app/module/chat/pdf_preview_screen.dart';
import 'package:field_king_admin/app/module/chat_screen/image_preview_screen.dart';
import 'package:field_king_admin/packages/config.dart';
import 'package:field_king_admin/packages/screen.dart';
import 'package:field_king_admin/services/firebase_services.dart';
import 'package:field_king_admin/services/show_loader.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreenController extends GetxController {
  RxString userId = RxString('');
  RxString adminId = RxString('');
  final ScrollController scrollController = ScrollController();
  Rx<TextEditingController> messageController = TextEditingController().obs;
  final ImagePicker picker = ImagePicker();
  RxString userFirstName = RxString('');
  RxString userLastName = RxString('');
  RxString userProfileImage = RxString('');
  RxBool isOnline = RxBool(false);
  Rx<Timestamp> lastActive = Timestamp.now().obs;

  @override
  void onInit() {
    getArgument();
    super.onInit();
  }

  getArgument() {
    var argument = Get.arguments;
    if (argument != null) {
      userId.value = argument['userId'];
      adminId.value = Preference.userId ?? '';
    }
  }

  getChat() {
    print('user id is ${userId.value}');
    print('admin id is ${adminId.value}');
    return FirebaseFirestoreService.getChatHistory(
      userId: userId.value,
      adminId: adminId.value,
    );
  }

  scrollToBottom() {
    Future.delayed(
      Duration(milliseconds: 100),
      () {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      },
    );
  }

  initialMessage({String? adminId, String? userId, String? message}) async {
    await FirebaseFirestoreService.addChatWelcomeMessage(
      adminId: adminId,
      userId: userId,
    );
  }

  sendMessage({
    String? adminId,
    String? userId,
    String? message,
  }) {
    messageController.value.clear();
    messageController.refresh();
    FirebaseFirestoreService.sendMessage(
      adminId: adminId,
      userId: userId,
      message: message,
      messageType: 'text',
      senderIsAdmin: true,
    );
  }

  Future<void> pickDocument() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null && result.files.isNotEmpty) {
        List<File> pdfFiles = [];

        for (var file in result.files) {
          if (file.path != null) {
            File selectedFile = File(file.path!);
            String ext = selectedFile.path.split('.').last.toLowerCase();

            // Check if the selected file is a PDF
            if (ext == 'pdf') {
              pdfFiles.add(selectedFile);
            }
          }
        }

        if (pdfFiles.isNotEmpty) {
          Get.to(() => PdfPreviewScreen(
                pdfFile: pdfFiles.first,
                onSend: () async {
                  ShowLoader.showEasyLoader();
                  await sendPdfInChat(pdfFiles.first);
                  EasyLoading.dismiss();
                  Get.back();
                },
              ));
        }
      } else {
        print("No file selected");
      }
    } catch (e) {
      print("Error picking document: $e");
    }
  }

  Future<void> sendPdfInChat(File pdfFile) async {
    try {
      if (userId.value == null || adminId.value.isEmpty) {
        print("User ID or Admin ID is null or empty. Cannot proceed.");
        return;
      }

      final docId = '${adminId.value}${userId.value}';
      final chatFolderName = '${adminId.value}${userId.value}';
      final chatPath = 'Chat/$chatFolderName';

      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final extension = pdfFile.path.split('.').last;
      final fullPath = '$chatPath/$fileName.$extension';

      final ref = FirebaseStorage.instance.ref().child(fullPath);
      final uploadTask = ref.putFile(
        pdfFile,
        SettableMetadata(contentType: 'application/pdf'),
      );
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('Chats')
          .doc(docId)
          .collection('Messages')
          .add(
        {
          'isRead': false,
          'senderId': adminId.value,
          'receiverId': userId.value,
          'timestamp': DateTime.now(),
          'messageType': 'pdf',
          'message': '',
          'mediaUrl': downloadUrl,
        },
      );

      print("✅ Chat message with PDF sent.");
    } catch (e) {
      print('❌ Error sending PDF: $e');
    }
  }

  Future<void> pickImageFromGallery() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.image,
      );

      if (result != null && result.files.isNotEmpty) {
        List<File> selectedImages = result.files
            .where((file) => file.path != null)
            .map((file) => File(file.path!))
            .toList();

        Get.to(
          () => ImagePreviewScreen(
            imageFiles: selectedImages,
            onSend: () async {
              ShowLoader.showEasyLoader();

              await sendImagesInChat(selectedImages);
              EasyLoading.dismiss();
              Get.back();
            },
          ),
        );
      } else {
        print("No image selected.");
      }
    } catch (e) {
      print("Error picking images: $e");
    }
  }

  Future<void> sendImagesInChat(List<File> images) async {
    try {
      if (userId.value == null || adminId.value.isEmpty) {
        print("User ID or Admin ID is null or empty. Cannot proceed.");
        return;
      }

      final docId = '${adminId.value}${userId.value}';
      final chatFolderName = '${adminId.value}${userId.value}';
      final chatPath = 'Chat/$chatFolderName';

      List<String> uploadedUrls = [];

      for (File file in images) {
        try {
          final fileName = DateTime.now().millisecondsSinceEpoch.toString();
          final extension = file.path.split('.').last;
          final fullPath = '$chatPath/$fileName.$extension';

          final ref = FirebaseStorage.instance.ref().child(fullPath);
          final uploadTask = ref.putFile(
            file,
            SettableMetadata(),
          );
          final snapshot = await uploadTask;
          final downloadUrl = await snapshot.ref.getDownloadURL();

          uploadedUrls.add(downloadUrl);
        } catch (e, stackTrace) {
          print("Error uploading file: $e");
        }
      }

      for (String url in uploadedUrls) {
        try {
          await FirebaseFirestore.instance
              .collection('Chats')
              .doc(docId)
              .collection('Messages')
              .add({
            'isRead': false,
            'senderId': adminId.value,
            'receiverId': userId.value,
            'timestamp': DateTime.now(),
            'messageType': 'image',
            'message': '',
            'mediaUrl': url,
          });
        } catch (e) {
          print("Error writing to Firestore: $e");
        }
      }
      print("✅ Chat message with images sent.");
    } catch (e) {
      Get.back();
      print('❌ Main error: $e');
    }
  }

  Future<void> takePhoto() async {
    try {
      if (userId.value == null || adminId.value.isEmpty) {
        print("User ID or Admin ID is null or empty. Cannot proceed.");
        return;
      }

      final docId = '${adminId.value}${userId.value}';
      final chatPath = 'Chat/$docId';

      final XFile? photo = await picker.pickImage(source: ImageSource.camera);

      ShowLoader.showEasyLoader();

      if (photo != null) {
        File imageFile = File(photo.path);

        final fileName = DateTime.now().millisecondsSinceEpoch.toString();
        final extension = imageFile.path.split('.').last;
        final fullPath = '$chatPath/$fileName.$extension';

        final ref = FirebaseStorage.instance.ref().child(fullPath);

        final uploadTask = ref.putFile(
          imageFile,
          SettableMetadata(),
        );

        final snapshot = await uploadTask;
        final downloadUrl = await snapshot.ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('Chats')
            .doc(docId)
            .collection('Messages')
            .add({
          'isRead': false,
          'senderId': adminId.value,
          'receiverId': userId.value,
          'timestamp': DateTime.now(),
          'messageType': 'image',
          'message': '',
          'mediaUrl': downloadUrl,
        });

        print("✅ Chat message with image sent.");
      } else {
        print("No photo captured.");
      }
      EasyLoading.dismiss();
    } catch (e) {
      Get.back();
      print("❌ Error taking photo and uploading: $e");
    }
  }

  updateTypingStatus({bool? isTyping, String? userId}) {
    FirebaseFirestoreService.updateIsTypingStatus(
      isTyping: isTyping,
      userId: userId,
    );
  }

  getUserDetails() {
    FirebaseFirestoreService.getChatUserDetails(userId: userId.value)
        .listen((snapshot) {
      final data = snapshot.docs.first.data() as Map<String, dynamic>;

      userFirstName.value = data['firstName'] ?? '';
      userLastName.value = data['lastName'] ?? '';
      userProfileImage.value = data['profilePhoto'] ?? '';
      isOnline.value = data['isOnline'] ?? false;
      lastActive.value = data['lastActive'] ?? Timestamp.now();
    });
  }
}
