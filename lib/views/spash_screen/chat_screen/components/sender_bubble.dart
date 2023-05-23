// ignore_for_file: depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy/consts/colors.dart';
import 'package:pharmacy/consts/firebase_consts.dart';
import 'package:velocity_x/velocity_x.dart';
import "package:intl/intl.dart" as intl;

Widget senderBubble(DocumentSnapshot data) {
  var t =
      data["created_on"] == null ? DateTime.now() : data["created_on"].toDate();
  var localTime = t.toLocal();
  var time = intl.DateFormat("h:mma").format(localTime);

  return Directionality(
    textDirection:
        data["uid"] == currentUser!.uid ? TextDirection.ltr : TextDirection.rtl,
    child: Container(
      margin:const EdgeInsets.only(bottom: 8),
      padding:const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: data["uid"] == currentUser!.uid ? redColor : darkFontGrey,
          borderRadius:const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          "${data['msg']}".text.white.size(16).make(),
          10.heightBox,
          time.text.color(whiteColor.withOpacity(0.5)).make()
        ],
      ),
    ),
  );
}
