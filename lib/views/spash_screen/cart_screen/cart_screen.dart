import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pharmacy/consts/colors.dart';
import 'package:pharmacy/consts/firebase_consts.dart';
import 'package:pharmacy/consts/styles.dart';
import 'package:pharmacy/controller/cart_controller.dart';
import 'package:pharmacy/services/firestore_services.dart';
import 'package:pharmacy/views/spash_screen/cart_screen/shipping_screen.dart';
import 'package:pharmacy/widgets_common/loading_indicator.dart';
import 'package:pharmacy/widgets_common/our_button.dart';
import 'package:velocity_x/velocity_x.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
        bottomNavigationBar: SizedBox(
            height: 60,
            child: ourButton(
                color: redColor,
                onPress: () {
                  Get.to(() => ShippingDetails());
                },
                textColor: whiteColor,
                title: "Proceed to shipping")),
        backgroundColor: whiteColor,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: "Shopping Cart"
                .text
                .color(darkFontGrey)
                .fontFamily(semibold)
                .make()),
        body: StreamBuilder(
          stream: FireStoreServices.getCart(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: loadingIndicator());
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: "Cart is empty".text.color(darkFontGrey).make(),
              );
            } else {
              var data = snapshot.data!.docs;
              controller.calculate(data);
              controller.productSnapshot = data;
              return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Expanded(
                          child: Container(
                              child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: Image.network("${data[index]['img']}",width: 80,fit: BoxFit.cover,),
                            
                            title:
                                "${data[index]['title']} x${data[index]['qty']}"
                                    .text
                                    .fontFamily(semibold)
                                    .size(16)
                                    .make(),
                            subtitle: "${data[index]['tprice']}"
                                .numCurrencyWithLocale(locale: "tr_TR")
                                .text
                                .color(redColor)
                                .fontFamily(semibold)
                                .make(),
                            trailing: const Icon(
                              Icons.delete,
                              color: redColor,
                            ).onTap(() {
                              FireStoreServices.deleteDocument(data[index].id);
                            }),
                          );
                        },
                      ))),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "Total price"
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make(),
                          Obx(
                            () => "${controller.totalP.value}"
                                .numCurrencyWithLocale(locale: "tr_TR")
                                .text
                                .fontFamily(semibold)
                                .color(redColor)
                                .make(),
                          ),
                          10.heightBox,
                          // SizedBox(
                          //     child: ourButton(
                          //         color: redColor,
                          //         onPress: () {},
                          //         textColor: whiteColor,
                          //         title: "Proceed to shipping"))
                        ],
                      )
                          .box
                          .padding(const EdgeInsets.all(12))
                          .color(lightGolden)
                          .roundedSM
                          .make()
                    ],
                  ));
            }
          },
        ));
  }
}
