import 'package:cloud_firestore/cloud_firestore.dart';

class OrderHistoryModel {
  final Timestamp? createdAt;
  final List<OrderHistoryItem>? order;
  final String? orderId;
  final bool? paymentStatus;
  final String? paymentType;
  final String? totalOrderAmout;
  final String? totalOrderMeter;
  final OrderHistoryUserDetails? userDetails;

  OrderHistoryModel({
    this.createdAt,
    this.order,
    this.orderId,
    this.paymentStatus,
    this.paymentType,
    this.totalOrderAmout,
    this.totalOrderMeter,
    this.userDetails,
  });

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    return OrderHistoryModel(
      createdAt: json['createdAt'],
      order: (json['order'] as List<dynamic>?)
          ?.map((e) => OrderHistoryItem.fromJson(e))
          .toList(),
      orderId: json['orderId'],
      paymentStatus: json['paymentStatus'],
      paymentType: json['paymentType'],
      totalOrderAmout: json['totalOrderAmout'],
      totalOrderMeter: json['totalOrderMeter'],
      userDetails: json['OrderHistoryUserDetails'] != null
          ? OrderHistoryUserDetails.fromJson(json['OrderHistoryUserDetails'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt,
      'order': order?.map((e) => e.toJson()).toList(),
      'orderId': orderId,
      'paymentStatus': paymentStatus,
      'paymentType': paymentType,
      'totalOrderAmout': totalOrderAmout,
      'totalOrderMeter': totalOrderMeter,
      'userDetails': userDetails?.toJson(),
    };
  }
}

class OrderHistoryItem {
  final String? PPMOO1;
  final String? PPMOO2;
  final String? flat;
  final String? gej;
  final bool? isDelete;
  final String? isWithGST;
  final String? orderStatus;
  final String? size;
  final String? subOrderId;
  final String? totalAmount;
  final String? totalMeter;
  final String? type;
  final Timestamp? deliverDate;

  OrderHistoryItem({
    this.PPMOO1,
    this.PPMOO2,
    this.flat,
    this.gej,
    this.isDelete,
    this.isWithGST,
    this.orderStatus,
    this.size,
    this.subOrderId,
    this.totalAmount,
    this.totalMeter,
    this.type,
    this.deliverDate,
  });

  factory OrderHistoryItem.fromJson(Map<String, dynamic> json) {
    return OrderHistoryItem(
      PPMOO1: json['PPMOO1'],
      PPMOO2: json['PPMOO2'],
      flat: json['flat'],
      gej: json['gej'],
      isDelete: json['isDelete'],
      isWithGST: json['isWithGST'],
      orderStatus: json['orderStatus'],
      size: json['size'],
      subOrderId: json['subOrderId'],
      totalAmount: json['totalAmount'],
      totalMeter: json['totalMeter'],
      type: json['type'],
      deliverDate: json['deliverDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'PPMOO1': PPMOO1,
      'PPMOO2': PPMOO2,
      'flat': flat,
      'gej': gej,
      'isDelete': isDelete,
      'isWithGST': isWithGST,
      'orderStatus': orderStatus,
      'size': size,
      'subOrderId': subOrderId,
      'totalAmount': totalAmount,
      'totalMeter': totalMeter,
      'type': type,
      'deliverDate': deliverDate,
    };
  }
}

class OrderHistoryUserDetails {
  final String? brandName;
  final String? firstName;
  final String? lastName;
  final String? location;
  final String? phoneNo;

  OrderHistoryUserDetails({
    this.brandName,
    this.firstName,
    this.lastName,
    this.location,
    this.phoneNo,
  });

  factory OrderHistoryUserDetails.fromJson(Map<String, dynamic> json) {
    return OrderHistoryUserDetails(
      brandName: json['brandName'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      location: json['location'],
      phoneNo: json['phoneNo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'brandName': brandName,
      'firstName': firstName,
      'lastName': lastName,
      'location': location,
      'phoneNo': phoneNo,
    };
  }
}
