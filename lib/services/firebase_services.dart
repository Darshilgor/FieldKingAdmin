import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:field_king_admin/services/get_storage/get_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthServices {
  final FirebaseAuth auth = FirebaseAuth.instance;

  static Future<void> verifyOTP({
    required String verificationId,
    required String otp,
    required Function(User? user) onVerified,
    required Function(FirebaseAuthException e) onError,
  }) async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
      print('credential $credential');
      UserCredential userCredential =
          await auth.signInWithCredential(credential);
      print('userCredential $userCredential');
      onVerified(userCredential.user);
    } on FirebaseAuthException catch (e) {
      onError(e);
    }
  }

  static Future<void> sendOTP({
    required String phoneNumber,
    required Function(String verificationId) onCodeSent,
    required Function(FirebaseAuthException e) onError,
  }) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) {
        auth.signInWithCredential(credential).then(
          (user) {
            print(
                "Phone number automatically verified and user signed in: ${user.user?.uid}");
          },
        );
      },
      verificationFailed: (FirebaseAuthException e) {
        onError(e);
      },
      codeSent: (String verificationId, int? resendToken) {
        print("Verification ID: $verificationId");
        onCodeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print("Verification code retrieval timed out: $verificationId");
      },
    );
  }
}

class FirebaseFirestoreService {
  static final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  static Future<void> addUserDetails({
    String? brandName,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? address,
  }) async {
    Map<String, dynamic> user = {
      'brandName': brandName,
      'createdAt': FieldValue.serverTimestamp(),
      'deviceId': Preference.fcmToken,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNo': phoneNumber,
      'profilePhoto': '',
      'totalOrderAmount': '',
      'totalOrderMeter': '',
      'userId': '',
      'address': address,
      'userType': (phoneNumber == '9409529203' || phoneNumber == '9426781202')
          ? 'Admin'
          : 'User',
      'contactList': [],
    };
    DocumentReference documentref =
        await firebaseFirestore.collection('Users').add(user);
    await documentref.update({'userId': documentref.id});
    Preference.userId = documentref.id;
  }

  static getOrderList() {}



  /// update profile.
  static Future<void> updateProfile({
    String? profileImage,
    String? firstName,
    String? lastName,
    String? brandName,
    String? phoneNumber,
  }) async {
    await firebaseFirestore.collection('Users').doc(Preference.userId).update({
      'profilePhoto': profileImage,
      'firstName': firstName,
      'lastName': lastName,
      'brandName': brandName,
      'phoneNo': phoneNumber,
    }).then(
          (value) {
        Preference.firstName = firstName;
        Preference.lastName = lastName;
        Preference.brandName = brandName;
        Preference.phoneNumber = phoneNumber;
        Preference.profileImage = profileImage;
      },
    );
  }
}
