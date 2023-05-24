import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pharmacy/consts/colors.dart';
import 'package:pharmacy/consts/firebase_consts.dart';
import 'package:pharmacy/consts/images.dart';
import 'package:pharmacy/consts/lists.dart';
import 'package:pharmacy/consts/styles.dart';
import 'package:pharmacy/controller/auth_controller.dart';
import 'package:pharmacy/controller/profile_controller.dart';
import 'package:pharmacy/services/firestore_services.dart';
import 'package:pharmacy/views/spash_screen/auth_screen/login_screen.dart';
import 'package:pharmacy/views/spash_screen/chat_screen/messaging_screen.dart';
import 'package:pharmacy/views/spash_screen/orders_screen/orders_screen.dart';
import 'package:pharmacy/views/spash_screen/profile_screen/edit_profile_screen.dart';
import 'package:pharmacy/views/wishlist_screen/wishlist_screen.dart';
import 'package:pharmacy/widgets_common/bg_widget.dart';
import 'package:pharmacy/widgets_common/loading_indicator.dart';
import 'package:velocity_x/velocity_x.dart';
import 'components/details_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return bgWidget(
        child: Scaffold(
      body: StreamBuilder(
          stream: FireStoreServices.getUser(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              );
            } else {
              var data = snapshot.data!.docs[0];

              return SafeArea(
                child: Column(children: [
                  //edit profile button
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Align(
                        alignment: Alignment.topRight,
                        child: Icon(
                          Icons.edit,
                          color: whiteColor,
                        )).onTap(() {
                      controller.nameController.text = data["name"];

                      Get.to(() => EditProfileScreen(
                            data: data,
                          ));
                    }),
                  ),
                  //users details section

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        data['imageUrl'] == ''
                            ? Image.asset(
                                imgProfile2,
                                width: 130,
                                fit: BoxFit.cover,
                              ).box.roundedFull.clip(Clip.antiAlias).make()
                            : Image.network(
                                data['imageUrl'],
                                width: 100,
                                fit: BoxFit.cover,
                              )
                          ..box.roundedFull.clip(Clip.antiAlias).make(),
                        10.widthBox,
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "${data['name']}"
                                .text
                                .fontFamily(semibold)
                                .white
                                .make(),
                            5.heightBox,
                            "${data['email']}".text.white.make(),
                          ],
                        )),
                        MaterialButton(
                            onPressed: () async {
                              await Get.put(AuthController())
                                  .signoutMethod(context: context);
                              Get.offAll(() => const LoginScreen());
                            },
                            child: const Text("Çıkış Yap"))
                      ],
                    ),
                  ),
                  20.heightBox,
                  FutureBuilder(
                      future: FireStoreServices.getCounts(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: loadingIndicator(),
                          );
                        } else {
                          var countData = snapshot.data;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              detailsCard(
                                  count: countData[0].toString(),
                                  title: "in your cart",
                                  width: context.screenWidth / 3.4),
                              detailsCard(
                                  count: countData[1].toString(),
                                  title: "presctiptions",
                                  width: context.screenWidth / 3.4),
                              detailsCard(
                                  count: countData[2].toString(),
                                  title: "in your orders",
                                  width: context.screenWidth / 3.4)
                            ],
                          );
                        }
                      }),

                  ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) {
                            return const Divider(
                              color: lightGrey,
                            );
                          },
                          itemCount: profileButtonsList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              onTap: () {
                                switch (index) {
                                  case 0:
                                    Get.to(() => const OrdersScreen());
                                    break;
                                  case 1:
                                    Get.to(() => const PrescriptionScreen());
                                    break;
                                  case 2:
                                    Get.to(() => const MessagesScreen());
                                    break;
                                  default:
                                }
                              },
                              leading: Image.asset(
                                profileButtonsIcon[index],
                                width: 22,
                              ),
                              title: profileButtonsList[index]
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .make(),
                            );
                          })
                      .box
                      .white
                      .rounded
                      .padding(const EdgeInsets.symmetric(horizontal: 16))
                      .margin(const EdgeInsets.all(12))
                      .shadowSm
                      .make()
                      .box
                      .color(redColor)
                      .make()
                ]),
              );
            }
          }),
    ));
  }
}
