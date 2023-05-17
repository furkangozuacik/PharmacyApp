import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pharmacy/consts/colors.dart';

import 'package:pharmacy/controller/product_controller.dart';
import 'package:pharmacy/services/firestore_services.dart';
import 'package:pharmacy/views/spash_screen/category_screen/item_details.dart';
import 'package:pharmacy/widgets_common/bg_widget.dart';
import 'package:pharmacy/widgets_common/loading_indicator.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../consts/styles.dart';

class CategoryDetails extends StatelessWidget {
  final String? title;
  const CategoryDetails({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return bgWidget(
        child: Scaffold(
            appBar: AppBar(title: title!.text.fontFamily(bold).white.make()),
            body: StreamBuilder(
              stream: FireStoreServices.getProducts(title),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: loadingIndicator(),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: "No products found".text.color(darkFontGrey).make(),
                  );
                } else {
                  var data = snapshot.data!.docs;
                  return Container(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          20.heightBox,
                          Expanded(
                              child: Container(
                                  color: lightGrey,
                                  child: GridView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: data.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              mainAxisExtent: 250,
                                              mainAxisSpacing: 8,
                                              crossAxisSpacing: 8),
                                      itemBuilder: (context, index) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Image.network(
                                              data[index]["p_imgs"][0],
                                              height: 150,
                                              width: 200,
                                              fit: BoxFit.cover,
                                            ),
                                            "${data[index]['p_name']}"
                                                .text
                                                .fontFamily(semibold)
                                                .color(darkFontGrey)
                                                .make(),
                                            10.heightBox,
                                            "${data[index]['p_price']}"
                                                .numCurrencyWithLocale(
                                                    locale: 'tr_TR')
                                                .text
                                                .color(redColor)
                                                .fontFamily(bold)
                                                .size(16)
                                                .make()
                                          ],
                                        )
                                            .box
                                            .white
                                            .roundedSM
                                            .outerShadowSm
                                            .margin(const EdgeInsets.symmetric(
                                                horizontal: 4))
                                            .padding(const EdgeInsets.all(12))
                                            .make()
                                            .onTap(() {
                                          controller.checkIfFav(data[index]);
                                          Get.to(() => ItemDetails(
                                              title: "${data[index]['p_name']}",
                                              data: data[index]));
                                        });
                                      })))
                        ],
                      ));
                }
              },
            )));
  }
}
