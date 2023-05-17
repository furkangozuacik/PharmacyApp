import 'package:flutter/material.dart';
import 'package:pharmacy/consts/colors.dart';
import 'package:velocity_x/velocity_x.dart';

Widget orderStatus({color, icon, title, showDone}) {
  return ListTile(
    leading: Icon(icon, color: color)
        .box
        .border(color: color)
        .roundedSM
        .padding(const EdgeInsets.all(4))
        .make(),
    trailing: SizedBox(
      height: 100,
      width: 120,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        "$title".text.color(darkFontGrey).make(),
        showDone
            ? const Icon(
                Icons.done,
                color: redColor,
              )
            : Container(),
      ]),
    ),
  );
}
