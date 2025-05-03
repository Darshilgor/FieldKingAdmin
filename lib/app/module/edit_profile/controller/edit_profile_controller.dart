import 'dart:io';

import 'package:field_king_admin/app/module/profile/controller/profile_controller.dart';
import 'package:field_king_admin/packages/config.dart';
import 'package:field_king_admin/packages/screen.dart';
import 'package:field_king_admin/services/firebase_services.dart';
import 'package:field_king_admin/services/toast_message.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EditProfileController extends GetxController {
  Rx<TextEditingController> firstNameController = TextEditingController().obs;
  Rx<TextEditingController> lastNameController = TextEditingController().obs;
  Rx<TextEditingController> brandNameController = TextEditingController().obs;
  Rx<TextEditingController> phoneNumberController = TextEditingController().obs;
  Rx<File?> profileImage = Rx<File?>(null);
  RxBool isButtonLoading = RxBool(false);
  RxString profilePhoto = RxString('');

  @override
  void onInit() {
    getUserData();
    super.onInit();
  }

  getUserData() {
    firstNameController.value.text = Preference.firstName ?? '';
    lastNameController.value.text = Preference.lastName ?? '';
    brandNameController.value.text = Preference.brandName ?? '';
    phoneNumberController.value.text = Preference.phoneNumber ?? '';
    profilePhoto.value = Preference.profileImage ?? '';
  }

  Future<void> updateProfile() async {
    if (profileImage.value == null) {
      print("No image selected.");
      return;
    }

    String? newImageUrl =
        await uploadProfileImageToFirebaseStorage(profileImage.value!);

    if (newImageUrl != null) {
      FirebaseFirestoreService.updateProfile(
        brandName: brandNameController.value.text.trim(),
        firstName: firstNameController.value.text.trim(),
        lastName: lastNameController.value.text.trim(),
        phoneNumber: phoneNumberController.value.text.trim(),
        profileImage: newImageUrl,
      ).then((value) {
        Get.find<ProfileController>().updateProfileImage();
        Get.back();
      });
    } else {
      ToastMessage.getSnackToast(
        message: 'Something went wrong while uploading image.',
      );
    }
  }

  Future<String?> uploadProfileImageToFirebaseStorage(File file) async {
    try {
      final String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child(fileName);

      final metadata = SettableMetadata(contentType: 'image/jpeg');

      UploadTask uploadTask = storageRef.putFile(file, metadata);

      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      print('Upload failed: $e');
      return null;
    }
  }
}
