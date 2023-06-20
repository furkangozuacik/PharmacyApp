import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy/consts/firebase_consts.dart';
import 'package:pharmacy/controller/home_controller.dart';

class CartController extends GetxController {
  var totalP = RxInt(0);

  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var postalcodeController = TextEditingController();
  var phoneController = TextEditingController();

  var paymentIndex = 0.obs;
  var products = [];
  var vendors = [];

  var placingOrder = false.obs;
  late dynamic productSnapshot;
  calculate(data) {
    for (var i = 0; i < data.length; i++) {
      totalP.value = totalP.value + int.parse(data[i]["tprice"].toString());
    }
  }

  changePaymentIndex(index) {
    paymentIndex.value = index;
  }

  placeMyOrder({required orderPaymentMethod, required totalAmount}) async {
    placingOrder(true);
    await getProductDetails();

    await firestore.collection(ordersCollection).doc().set({
      "order_code": "233981237",
      "order_by": currentUser!.uid,
      "order_by_name": Get.find<HomeController>().username,
      "order_by_email": currentUser!.email,
      "order_by_address": addressController.text,
      "order_by_state": stateController.text,
      "order_by_city": cityController.text,
      "order_by_phone": phoneController.text,
      "order_by_postalcode": postalcodeController.text,
      "shipping_method": "Home Delivery",
      "payment_method": orderPaymentMethod,
      "order_placed": true,
      "order_date": FieldValue.serverTimestamp(),
      "order_confirmed": false,
      "order_delivered": false,
      "order_on_delivery": false,
      "total_amount": totalAmount,
      "orders": FieldValue.arrayUnion(products),
    });
    placingOrder(false);
  }

  getProductDetails() {
    products.clear();
    vendors.clear();
    for (var i = 0; i < productSnapshot.length; i++) {
      products.add({
        "color": productSnapshot[i]["color"],
        "img": productSnapshot[i]["img"],
        "vendor_id": productSnapshot[i]["vendor_id"],
        "tprice": productSnapshot[i]["tprice"],
        "qty": productSnapshot[i]["qty"],
        "title": productSnapshot[i]["title"]
      });
      vendors.add(productSnapshot[i]["vendor_id"]);
    }
  }

  clearCart() {
    for (var i = 0; i < productSnapshot.length; i++) {
      firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();
    }
  }
}
