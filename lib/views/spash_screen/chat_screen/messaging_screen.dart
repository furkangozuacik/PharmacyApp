import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy/consts/colors.dart';
import 'package:pharmacy/consts/styles.dart';
import 'package:pharmacy/services/firestore_services.dart';
import 'package:pharmacy/views/spash_screen/chat_screen/seller_chat_screen.dart';
import 'package:pharmacy/views/spash_screen/chatscreen.dart';
import 'package:pharmacy/widgets_common/loading_indicator.dart';
import 'package:velocity_x/velocity_x.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title:
            "My Messages".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
          stream: FireStoreServices.getAllMessages(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "No messages yet!".text.color(darkFontGrey).makeCentered();
            } else {
              var data = snapshot.data!.docs;
              return Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: redColor,
                                  child: Icon(
                                    Icons.person,
                                    color: whiteColor,
                                  ),
                                ),
                                onTap: () {
                                  Get.to(() => SellerChatScreen(), arguments: [
                                    data[index]["friend_name"],
                                    data[index]["toId"]
                                  ]);
                                },
                                title: "${data[index]['friend_name']}"
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                subtitle:
                                    "${data[index]['last_msg']}".text.make(),
                              ),
                            );
                          }))
                ],
              );
            }
          }),
    );
  }
}
