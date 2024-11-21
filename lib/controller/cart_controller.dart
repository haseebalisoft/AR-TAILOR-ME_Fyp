// lib/controller/cart_controller.dart
import 'package:get/get.dart';

class CartController extends GetxController {
  var cartItems = <String>[].obs;

  void addItem(String item) {
    cartItems.add(item);
  }
}
         