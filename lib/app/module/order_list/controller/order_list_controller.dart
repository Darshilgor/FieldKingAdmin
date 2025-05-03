import 'package:field_king_admin/packages/config.dart';
import 'package:field_king_admin/services/firebase_services.dart';

class OrderListController extends GetxController
{
  getOrderlist() {

    FirebaseFirestoreService.getOrderList();
  }

}