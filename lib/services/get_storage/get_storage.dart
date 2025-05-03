import 'package:get_storage/get_storage.dart';

class Preference {
  static GetStorage? box;

  static const fcmTokenKey = "fcmToken";
  static const sbPreference = "field_king_admin_preference";
  static const isLoginKey = "is-login";
  static const isOtpVerifyKey = "isOtpVerify";
  static const phoneNumberKey = "phoneNumberKey";
  static const userIdKey = "userIdKey";
  static const brandNameKey = "brandNameKey";
  static const firstNameKey = "firstNameKey";
  static const lastNameKey = "lastNameKey";
  static const addresssKey = "addressKey";
  static const userTypeKey = "userTypeKey";
  static const profileImageKey = 'profileImageKey';








  init() async {
    await GetStorage.init(sbPreference);
    box = GetStorage(sbPreference);
  }

  static String? get fcmToken => box?.read<String>(fcmTokenKey);
  static set fcmToken(String? token) => box?.write(fcmTokenKey, token);

  // Is Login.
  static bool? get isLogin => box?.read<bool>(isLoginKey);
  static set isLogin(bool? value) => box?.write(isLoginKey, value);



  // OTP Verification Status
  static bool? get isOtpVerified => box?.read<bool>(isOtpVerifyKey);
  static set isOtpVerified(bool? value) => box?.write(isOtpVerifyKey, value);


  // Phone Number.
  static String? get phoneNumber => box?.read<String>(phoneNumberKey);
  static set phoneNumber(String? number) => box?.write(phoneNumberKey, number);


  // User ID
  static String? get userId => box?.read<String>(userIdKey);
  static set userId(String? id) => box?.write(userIdKey, id);




  // Brand Name
  static String? get brandName => box?.read<String>(brandNameKey);
  static set brandName(String? name) => box?.write(brandNameKey, name);
  // First Name
  static String? get firstName => box?.read<String>(firstNameKey);
  static set firstName(String? name) => box?.write(firstNameKey, name);


  // Last Name
  static String? get lastName => box?.read<String>(lastNameKey);
  static set lastName(String? name) => box?.write(lastNameKey, name);


  // Address.
  static String? get address => box?.read<String>(addresssKey);
  static set address(String? number) => box?.write(addresssKey, number);



  // User Type
  static String? get userType => box?.read<String>(userTypeKey);
  static set userType(String? type) => box?.write(userTypeKey, type);


  // profile Photo.
  static String? get profileImage => box?.read<String>(profileImageKey);
  static set profileImage(String? profileImage) =>
      box?.write(profileImageKey, profileImage);
}
