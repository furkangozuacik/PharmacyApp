import "package:flutter/material.dart";
import "package:pharmacy/consts/colors.dart";
import "package:pharmacy/consts/consts.dart";
import "package:pharmacy/consts/styles.dart";
import "package:velocity_x/velocity_x.dart";

Widget detailsCard({width, String? count, String? title}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.fontFamily(bold).color(darkFontGrey).size(16).make(),
      5.heightBox,
      title!.text.color(darkFontGrey).make()
    ],
  ).box.white.rounded.width(width).height(80).padding(EdgeInsets.all(4)).make();
}
