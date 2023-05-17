import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:pharmacy/consts/colors.dart';
import 'package:pharmacy/consts/styles.dart';
import 'package:pharmacy/services/firestore_services.dart';
import 'package:pharmacy/views/spash_screen/category_screen/item_details.dart';
import 'package:pharmacy/widgets_common/loading_indicator.dart';
import 'package:velocity_x/velocity_x.dart';

class SearchScreen extends StatelessWidget {
  final String? title;
  const SearchScreen({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: title!.text.color(darkFontGrey).make(),
          backgroundColor: whiteColor,
        ),
        body: FutureBuilder(
          future: FireStoreServices.searchProducts(title),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "No products found".text.makeCentered();
            } else {
              var data = snapshot.data!.docs;
              var filtered = data
                  .where((element) => element["p_name"]
                      .toString()
                      .toLowerCase()
                      .contains(title!.toLowerCase()))
                  .toList();

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 300,
                            crossAxisSpacing: 8),
                    children: filtered
                        .mapIndexed((currentValue, index) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  filtered[index]["p_imgs"][0],
                                  width: 130,
                                  height: 130,
                                  fit: BoxFit.cover,
                                ),
                                10.heightBox,
                                "${filtered[index]["p_name"]}"
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                10.heightBox,
                                "${filtered[index]["p_price"]}"
                                    .numCurrencyWithLocale(locale: "tr_TR")
                                    .text
                                    .color(redColor)
                                    .fontFamily(bold)
                                    .size(16)
                                    .make()
                              ],
                            )
                                .box
                                .white
                                .outerShadowMd
                                .rounded
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 4))
                                .padding(const EdgeInsets.all(8))
                                .make()
                                .onTap(() {
                              Get.to(() => ItemDetails(
                                  data: filtered[index],
                                  title: "${filtered[index]['p_name']}"));
                            }))
                        .toList()),
              );
            }
          },
        ));
  }
}
