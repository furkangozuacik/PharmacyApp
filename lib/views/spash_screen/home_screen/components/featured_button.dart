import 'package:flutter/material.dart';
import 'package:pharmacy/consts/colors.dart';
import 'package:pharmacy/consts/consts.dart';
import 'package:pharmacy/consts/images.dart';
import 'package:pharmacy/consts/styles.dart';
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
      .margin(EdgeInsets.symmetric(horizontal: 4))
      .white
      .padding(EdgeInsets.all(4))
      .roundedSM
      .outerShadowSm
      .make();
}
