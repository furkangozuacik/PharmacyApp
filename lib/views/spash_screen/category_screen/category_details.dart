import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:pharmacy/consts/colors.dart';
import 'package:pharmacy/consts/images.dart';
import 'package:pharmacy/consts/lists.dart';
import 'package:pharmacy/controller/product_controller.dart';
import 'package:pharmacy/views/spash_screen/category_screen/item_details.dart';
import 'package:pharmacy/widgets_common/bg_widget.dart';
import "package:pharmacy/consts/consts.dart";
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
      body: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: List.generate(
                        controller.subcat.length,
                        (index) => "${controller.subcat[index]}"
                            .text
                            .size(12)
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .makeCentered()
                            .box
                            .white
                            .rounded
                            .size(120, 60)
                            .margin(EdgeInsets.symmetric(horizontal: 4))
                            .make())),
              ),
              20.heightBox,
              Expanded(
                  child: Container(
                      color: lightGrey,
                      child: GridView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 6,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisExtent: 250,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8),
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  imgP5,
                                  height: 150,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                                ",Ağrı Kesici"
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                10.heightBox,
                                "₺ 20.00"
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
                                .margin(EdgeInsets.symmetric(horizontal: 4))
                                .padding(EdgeInsets.all(12))
                                .make()
                                .onTap(() {
                              Get.to(() => ItemDetails(title: "dummy item"));
                            });
                          })))
            ],
          )),
    ));
  }
}
