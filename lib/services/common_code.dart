import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:field_king_admin/packages/config.dart';
import 'package:field_king_admin/packages/screen.dart';
import 'package:field_king_admin/services/app_color/app_colors.dart';
import 'package:field_king_admin/services/app_icon.dart';
import 'package:field_king_admin/services/toast_message.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';



final ImagePicker picker = ImagePicker();

ExtendedImage extendedImage({
  required String imageUrl,
  final double? width,
  final double? height,
  final BoxFit? fit,
  final BoxShape? boxShap,
  final int? catchWidth,
  final int? catchHeight,
  final EdgeInsetsGeometry? circularProcessPadding,
  final BorderRadius? BorderRadius,
}) {
  return ExtendedImage.network(
    imageUrl,
    width: width,
    height: height,
    fit: fit ?? BoxFit.cover,
    shape: boxShap ?? BoxShape.circle,
    cache: true,
    borderRadius: BorderRadius,
    mode: ExtendedImageMode.gesture,
    cacheHeight: catchHeight ?? 300,
    cacheWidth: catchWidth ?? 300,
    clearMemoryCacheWhenDispose: true,
    clearMemoryCacheIfFailed: true,
    loadStateChanged: (ExtendedImageState state) {
      switch (state.extendedImageLoadState) {
        case LoadState.loading:
          return Padding(
            padding: circularProcessPadding ??
                const EdgeInsets.all(
                  20,
                ),
            child: CircularProgressIndicator(
              color: AppColor.blackColor,
              strokeWidth: 1,
            ),
          );
        case LoadState.completed:
          return state.completedWidget;
        case LoadState.failed:
          return Image.asset(
            Assets.defaultProfileImage,
            width: width,
            height: height,
            fit: BoxFit.cover,
          );
      }
    },
  );
}

Widget editProfileExtendedImage(
    {String? profileImage,
      double? width,
      double? height,
      File? selectedProfileImage}) {
  if (selectedProfileImage != null) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: Image.file(
          selectedProfileImage,
          fit: BoxFit.cover,
          width: width ?? 100.0,
          height: height ?? 100.0,
        ),
      ),
    );
  } else if ((profileImage ?? '').isNotEmpty) {
    return extendedImage(
      imageUrl: profileImage ?? '',
      width: width ?? 44,
      height: height ?? 44,
    );
  } else {
    return Image.asset(
      Assets.defaultProfileImage,
      fit: BoxFit.cover,
      width: width ?? 44.0,
      height: height ?? 44.0,
    );
  }
}



Future pickImage(ImageSource source, {bool? canBack = false}) async {
  XFile? pickedFile = await picker.pickImage(
    source: source,
    imageQuality: 50,
  );
  print('picked file is');
  print(pickedFile);
  if (pickedFile != null) {
    CroppedFile? croppedFile = await cropImage(pickedFile.path);

    if (croppedFile != null) {
      double sizeInMB = await getImageSizeInMB(croppedFile.path);
      if (sizeInMB > 5) {
        ToastMessage.getSnackToast(
            message:
            "File size is too large and can't be uploaded. Allowed maximum size is 5 MB",
            colorText: Colors.white,
            backgroundColor: Colors.red,
            withButton: false);
        return null;
      } else {
        return File(croppedFile.path);
      }
    }
  }
}Future<double> getImageSizeInMB(String filePath) async {
  File imageFile = File(filePath);
  int bytes = await imageFile.length();
  double kilobytes = bytes / 1024;
  double megabytes = kilobytes / 1024;
  return double.parse(megabytes.toStringAsFixed(2));
}

Future<CroppedFile?> cropImage(String filePath) async {
  try {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: filePath,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 50,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: AppColor.whiteColor,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Crop Image',
        ),
      ],
    );
    return croppedFile;
  } catch (e) {
    if (kDebugMode) {
      print('e  $e');
    }
  }
  return null;
}


class ContainerDecoration {
  static BoxDecoration decoration({Color? color}) {
    return BoxDecoration(
      color: AppColor.whiteColor,
      boxShadow: [
        BoxShadow(
          blurRadius: 2,
          offset: Offset(1.5, 0.5),
          spreadRadius: .5,
          color: Colors.grey.withOpacity(0.5),
        ),
      ],
      borderRadius: BorderRadius.circular(
        20,
      ),
    );
  }
}