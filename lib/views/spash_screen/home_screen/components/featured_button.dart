import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy/consts/colors.dart';

import 'package:pharmacy/consts/styles.dart';
import 'package:pharmacy/controller/product_controller.dart';
import 'package:pharmacy/views/spash_screen/category_screen/category_details.dart';
import 'package:velocity_x/velocity_x.dart';

Widget featuredButton({String? title, icon}) {
  return Row(
    children: [
      Image.asset(icon, width: 40, fit: BoxFit.fill),
      10.widthBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make()
    ],
  )
      .box
      .width(200)
      .margin(const EdgeInsets.symmetric(horizontal: 4))
      .white
      .padding(const EdgeInsets.all(4))
      .roundedSM
      .outerShadowSm
      .make()
      .onTap(() {
    Get.to(() => CategoryDetails(title: title));
  });
}
