import 'package:field_king_admin/app/model/get_product_model.dart';
import 'package:field_king_admin/packages/config.dart';
import 'package:field_king_admin/packages/screen.dart';
import 'package:field_king_admin/services/firebase_services.dart';

class HomeScreenController extends GetxController {
  RxList<Product> products = <Product>[].obs;
  Rx<TextEditingController> orderMeterController = TextEditingController().obs;
  final enterMeterFormKey = GlobalKey<FormState>();
  RxString gstRadioButtonValue = RxString('50%');

  @override
  void onInit() {
    getProducts();
    super.onInit();
  }

  getProducts() async {
    try {
      List<Product> productList =
          await FirebaseFirestoreService.getProductList();
      products.addAll(productList);
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }
}
