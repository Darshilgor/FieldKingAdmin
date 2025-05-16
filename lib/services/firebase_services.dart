import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:field_king_admin/app/model/get_product_model.dart';
import 'package:field_king_admin/services/genera_controller.dart';
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

  static getOrderList() {
    return firebaseFirestore.collection('OrderList').snapshots();
  }

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

  static updateOrderStatus(
      {String? status,
      String? subOrderId,
      String? userId,
      String? mainOrderId,
      String? userOrderCollectionId}) async {
    /// update oreder list collection.
    final docRef =
        await firebaseFirestore.collection('OrderList').doc(mainOrderId);
    final docSnapshot = await docRef.get();

    if (docSnapshot.exists) {
      List<dynamic> subOrders = docSnapshot.data()?['order'] ?? [];

      for (var i = 0; i < subOrders.length; i++) {
        if (subOrders[i]['subOrderId'] == subOrderId) {
          subOrders[i]['orderStatus'] = status;
        }
      }
      await docRef.update(
        {
          'order': subOrders,
        },
      );
    }

    /// update particular user order collection.
    final orderCollectionRef = await firebaseFirestore
        .collection('Users')
        .doc(userId)
        .collection('Order')
        .doc(userOrderCollectionId);

    final orderCollectionRefSnapshot = await orderCollectionRef.get();

    if (orderCollectionRefSnapshot.exists) {
      List<dynamic> listOrderCollection = docSnapshot.data()?['order'] ?? [];

      for (var i = 0; i < listOrderCollection.length; i++) {
        if (listOrderCollection[i]['subOrderId'] == subOrderId) {
          listOrderCollection[i]['orderStatus'] = status;
        }
      }
      await orderCollectionRef.update(
        {
          'order': listOrderCollection,
        },
      );
    }
    return;
  }

  static updateAllSubOrderStatus({
    String? userId,
    String? orderListId,
    String? orderCollectionId,
    String? status,
  }) async {
    /// update order list collection.
    final ref =
        await firebaseFirestore.collection('OrderList').doc(orderListId);

    final documentReference = await ref.get();

    if (documentReference.exists) {
      List<dynamic> listOrderCollection =
          documentReference.data()?['order'] ?? [];

      listOrderCollection.forEach(
        (e) {
          e['orderStatus'] = status;
        },
      );
      ref.update(
        {
          'order': listOrderCollection,
        },
      );
    }

    /// update user order collection status.
    final orderCollectionRef = await firebaseFirestore
        .collection('Users')
        .doc(userId)
        .collection('Order')
        .doc(orderCollectionId);

    final orderCollectionSnapshot = await orderCollectionRef.get();
    if (orderCollectionSnapshot.exists) {
      List<dynamic> orderList = orderCollectionSnapshot.data()?['order'];

      orderList.forEach((e) {
        e['orderStatus'] = status;
      });
      orderCollectionRef.update(
        {
          'order': orderList,
        },
      );
    }
    return;
  }

  static updateOrderListStatus({String? orderId}) async {
    await firebaseFirestore.collection('OrderList').doc(orderId).update(
      {
        'isOrderDelivered': true,
      },
    );
  }

  static getUserList() {
    return firebaseFirestore
        .collection('Users')
        .where(
          'userType',
          isEqualTo: 'User',
        )
        .snapshots();
  }

  static getChatHistory({String? userId, String? adminId}) {
    try {
      String chatId = '$adminId$userId';

      return firebaseFirestore
          .collection('Chats')
          .doc(chatId)
          .collection('Messages')
          .orderBy('timestamp', descending: false)
          .snapshots();
    } catch (e) {
      print("Error fetching chat history: $e");
      return const Stream.empty();
    }
  }

  static addChatWelcomeMessage({
    String? adminId,
    String? userId,
  }) async {
    String chatId = '$adminId$userId';
    DocumentReference document = await firebaseFirestore
        .collection('Chats')
        .doc(chatId)
        .collection('Messages')
        .add(
      {
        'isRead': false,
        'mediaUrl': '',
        'message': 'Welcome to Field King',
        'messageType': 'text',
        'receiverId': userId,
        'senderId': adminId,
        'timestamp': DateTime.now(),
      },
    );
    await document.update(
      {
        'id': document.id,
      },
    );
    DocumentReference secondDocument = await firebaseFirestore
        .collection('Chats')
        .doc(chatId)
        .collection('Messages')
        .add(
      {
        'isRead': false,
        'mediaUrl': '',
        'message': 'How can we help you!',
        'messageType': 'text',
        'receiverId': userId,
        'senderId': adminId,
        'timestamp': DateTime.now(),
      },
    );
    await secondDocument.update(
      {
        'id': secondDocument.id,
      },
    );
  }

  static sendMessage({
    String? adminId,
    String? userId,
    String? message,
    String? messageType,
    bool? senderIsAdmin = false,
  }) async {
    String chatId = '$adminId$userId';

    DocumentReference document = await firebaseFirestore
        .collection('Chats')
        .doc(chatId)
        .collection('Messages')
        .add(
      {
        'isRead': false,
        'mediaUrl': '',
        'message': message,
        'messageType': messageType,
        'receiverId': userId,
        'senderId': adminId,
        'timestamp': DateTime.now(),
      },
    );
    await document.update(
      {
        'id': document.id,
      },
    );
  }

  static updateIsTypingStatus({bool? isTyping, String? userId}) async {
    print('doc id is $userId');
    await firebaseFirestore.collection('Users').doc(userId).update(
      {
        'isTyping': isTyping,
      },
    );
  }

  static updateUserActiveStatus({
    String? userId,
    bool? online,
  }) async {
    await firebaseFirestore.collection('Users').doc(userId).update(
      {
        'isOnline': online,
        'lastActive': FieldValue.serverTimestamp(),
      },
    );
  }

  static Stream<QuerySnapshot> getChatUserDetails({
    String? userId,
  }) {
    return firebaseFirestore
        .collection('Users')
        .where(
          'userId',
          isEqualTo: userId,
        )
        .snapshots();
  }

  static Future getProductList() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('Products').get();

    return snapshot.docs.map(
      (doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Product.fromMap(doc.id, data);
      },
    ).toList();
  }

  static Future<void> getIsShowWithOutGst() async {
    var isShowWithOutGst;
    DocumentSnapshot snapshot = await firebaseFirestore
        .collection('IsShowWithOutGST')
        .doc('IsShowWithOutGST')
        .get();
    isShowWithOutGst = snapshot.data();
    if (isShowWithOutGst['IsShowWithOutGST'] != null) {
      GeneralController.isShowWithOutGst.value =
          isShowWithOutGst['IsShowWithOutGST'];
    } else {
      GeneralController.isShowWithOutGst.value = false;
    }
  }

  static Future<DocumentSnapshot> getUserDetails({String? userId}) async {
    return await firebaseFirestore.collection('Users').doc(userId).get();
  }
}
