import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy/consts/firebase_consts.dart';
import "package:pharmacy/models/category_model.dart";
import 'package:flutter/services.dart';
import 'package:pharmacy/views/spash_screen/category_screen/item_details.dart';
import 'package:pharmacy/views/wishlist_screen/wishlist_screen.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductController extends GetxController {
  var subcat = [];
  var quantity = 0.obs;
  var colorIndex = 0.obs;
  var totalPrice = 0.obs;
  var isFav = false.obs;
  var barcodeId = "";
  var scannedBarcode = "";
  void handleBarcodeScan(String scannedBarcode) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    QuerySnapshot querySnapshot = await firestore
        .collection('products')
        .where('p_barcode', isEqualTo: scannedBarcode)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // Barkod eşleşen ürün bulundu
      barcodeId = querySnapshot.docs.first['p_barcode'] ?? "1005632parol";

      Get.to(() => WishlistScreen());

      print('Barcode ID: $barcodeId');

      // İstediğiniz işlemi gerçekleştirin
    } else {
      // Barkod eşleşen ürün bulunamadı

      print("else içine girdik");
      // İstediğiniz işlemi gerçekleştirin veya hata durumunu yönetin
    }
  }

  getSubCategories(title) async {
    subcat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decoded = categoryModelFromJson(data);
    var s =
        decoded.categories.where((element) => element.name == title).toList();

    for (var e in s[0].subcategory) {
      subcat.add(e);
    }
  }

  changeColorIndex(index) {
    colorIndex = index;
  }

  increaseQuantity(totalQuantity) {
    if (quantity.value < totalQuantity) {
      quantity.value++;
    }
  }

  decreaseQuantity() {
    if (quantity.value > 0) {
      quantity.value--;
    }
  }

  calculateTotalPrice(price) {
    totalPrice.value = price * quantity.value;
  }

  addToCart(
      {title, img, sellername, color, qty, tprice, context, vendorID}) async {
    await firestore.collection(cartCollection).doc().set({
      "title": title,
      "img": img,
      "sellername": sellername,
      "color": color,
      "qty": qty,
      "vendor_id": vendorID,
      "tprice": tprice,
      "added_by": currentUser!.uid
    }).catchError((error) {
      VxToast.show(context, msg: error.toString());
    });
  }

  resetValues() {
    totalPrice.value = 0;
    quantity.value = 0;
    colorIndex.value = 0;
  }

  addToWishList(docId, context) async {
    await firestore.collection(productsCollection).doc(docId).set({
      "p_wishlist": FieldValue.arrayUnion([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(true);
    VxToast.show(context, msg: "Added favorite");
  }

  removeFromWishList(docId, context) async {
    await firestore.collection(productsCollection).doc(docId).set({
      "p_wishlist": FieldValue.arrayRemove([currentUser!.uid])
    }, SetOptions(merge: true));

    isFav(false);
    VxToast.show(context, msg: "Removed favorite");
  }

  checkIfFav(data) async {
    if (data["p_wishlist"].contains(currentUser!.uid)) {
      isFav(true);
    } else {
      isFav(false);
    }
  }
}
