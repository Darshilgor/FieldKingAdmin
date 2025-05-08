// class Product {
//   final String documentId; // This comes from the Firestore field
//   final Map<String, Cable> cables; // Cable map for 1MM, 1.5MM, etc.

//   Product({required this.documentId, required this.cables});

//   factory Product.fromMap(Map<String, dynamic> data) {
//     final docId = data['documentId'] as String? ?? '';

//     final cables = <String, Cable>{};
//     data.forEach((key, value) {
//       if (key != 'documentId' && value is Map<String, dynamic>) {
//         cables[key] = Cable.fromMap(value);
//       }
//     });

//     return Product(
//       documentId: docId,
//       cables: cables,
//     );
//   }
// }

// class Cable {
//   final Map<String, Map<String, String>> subCable;

//   Cable({required this.subCable});

//   factory Cable.fromMap(Map<String, dynamic> data) {
//     final subCable = <String, Map<String, String>>{};
//     data.forEach((key, value) {
//       if (value is Map<String, dynamic>) {
//         subCable[key] = value.map((subKey, subValue) =>
//             MapEntry(subKey, subValue.toString()));
//       }
//     });

//     return Cable(
//       subCable: subCable,
//     );
//   }
// }

import 'package:field_king_admin/packages/config.dart';

class Product {
  String? amp;
  String? chipeshPrice;
  String? flat;
  String? gej;
  String? id;
  String? price;
  String? size;
  String? type;
  RxBool isExpanded;

  Product({
    this.id,
    this.amp,
    this.price,
    this.chipeshPrice,
    this.size,
    this.type,
    this.flat,
    this.gej,
    RxBool? isExpanded,
  }) : isExpanded = isExpanded ?? RxBool(false);

  factory Product.fromMap(String id, Map<String, dynamic> data) {
    return Product(
      id: id,
      amp: data['amp'],
      price: data['price'],
      chipeshPrice: data['chipestPrice'],
      size: data['size'],
      type: data['type'],
      flat: data['flat'],
      gej: data['gej'],
    );
  }
}
