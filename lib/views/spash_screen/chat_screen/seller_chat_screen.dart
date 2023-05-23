import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pharmacy/consts/colors.dart';
import 'package:pharmacy/consts/firebase_consts.dart';
import 'package:pharmacy/consts/styles.dart';
import 'package:pharmacy/controller/chats_controller.dart';
import 'package:pharmacy/services/firestore_services.dart';
import 'package:pharmacy/views/spash_screen/chat_screen/components/sender_bubble.dart';
import 'package:pharmacy/widgets_common/loading_indicator.dart';
import 'package:velocity_x/velocity_x.dart';

class SellerChatScreen extends StatelessWidget {
  const SellerChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatsController());
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "${controller.friendName}"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(children: [
          Obx(
            () => controller.isLoading.value
                ? Center(
                    child: loadingIndicator(),
                  )
                : Expanded(
                    child: StreamBuilder(
                    stream: FireStoreServices.getChatMessages(
                        controller.chatDocId.toString()),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: loadingIndicator(),
                        );
                      } else if (snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: "Send a message..."
                              .text
                              .color(darkFontGrey)
                              .make(),
                        );
                      } else {
                        return ListView(
                          children: snapshot.data!.docs
                              .mapIndexed((currentValue, index) {
                            var data = snapshot.data!.docs[index];
                            return Align(
                                alignment: data["uid"] == currentUser!.uid
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: senderBubble(data));
                          }).toList(),
                        );
                      }
                    },
                  )),
          ),
          10.heightBox,
          Row(
            children: [
              Expanded(
                  child: TextFormField(
                controller: controller.msgController,
                decoration: const InputDecoration(
                    hintText: "Type a message...",
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: textfieldGrey)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: textfieldGrey))),
              )),
              IconButton(
                  onPressed: () {
                    controller.sendMsg(controller.msgController.text);
                    controller.msgController.clear();
                  },
                  icon: const Icon(
                    Icons.send,
                    color: redColor,
                  ))
            ],
          )
              .box
              .height(80)
              .padding(const EdgeInsets.all(12))
              .margin(const EdgeInsets.only(bottom: 8))
              .make()
        ]),
      ),
    );
  }
}
