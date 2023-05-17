import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:pharmacy/consts/colors.dart';
import 'package:pharmacy/consts/styles.dart';
import 'package:pharmacy/services/firestore_services.dart';
import 'package:pharmacy/views/spash_screen/orders_screen/orders_details.dart';
import 'package:pharmacy/widgets_common/loading_indicator.dart';
import 'package:velocity_x/velocity_x.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My Orders".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
          stream: FireStoreServices.getAllOrders(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "No orders yet!".text.color(darkFontGrey).makeCentered();
            } else {
              var data = snapshot.data!.docs;
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: "${index + 1}"
                          .text
                          .fontFamily(bold)
                          .color(darkFontGrey)
                          .xl
                          .make(),
                      tileColor: lightGrey,
                      title: data[index]["order_code"]
                          .toString()
                          .text
                          .color(redColor)
                          .fontFamily(semibold)
                          .make(),
                      subtitle: data[index]["total_amount"]
                          .toString()
                          .numCurrencyWithLocale(locale: "tr_TR")
                          .text
                          .fontFamily(bold)
                          .make(),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: darkFontGrey,
                        ),
                        onPressed: () {
                          Get.to(() => OrdersDetails(
                                data: data[index],
                              ));
                        },
                      ),
                    );
                  });
            }
          }),
    );
  }
}
