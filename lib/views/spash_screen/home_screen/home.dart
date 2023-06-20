import 'package:pharmacy/consts/consts.dart';
import 'package:pharmacy/consts/images.dart';
import 'package:pharmacy/consts/styles.dart';
import 'package:pharmacy/controller/home_controller.dart';
import 'package:pharmacy/views/spash_screen/cart_screen/cart_screen.dart';
import 'package:pharmacy/views/spash_screen/category_screen/category_screen.dart';
import 'package:pharmacy/views/spash_screen/dialogflow_screen/dialogflow_screen.dart';
import 'package:pharmacy/views/spash_screen/home_screen/home_screen.dart';
import 'package:pharmacy/views/spash_screen/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pharmacy/widgets_common/exit_dialog.dart';

import '../../../consts/colors.dart';
import '../chatscreen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    //init home controller

    var controller = Get.put(HomeController());
    var navbarItem = [
      BottomNavigationBarItem(
          icon: Image.asset(
            icHome,
            width: 26,
          ),
          label: home),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.favorite,
            color: redColor,
          ),
          label: "Favorites"),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProfile,
            width: 26,
          ),
          label: account),
      BottomNavigationBarItem(
          icon: Image.asset(
            icAi,
            width: 46,
          ),
          label: ai),
    ];

    var navBody = [
      const HomeScreen(),
      const CartScreen(),
      const ProfileScreen(),
      const ChatScreen()
    ];
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => exitDialog(context));
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Obx(
              () => Expanded(
                child: navBody.elementAt(controller.currentNavIndex.value),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            selectedItemColor: redColor,
            selectedLabelStyle: const TextStyle(fontFamily: semibold),
            type: BottomNavigationBarType.fixed,
            items: navbarItem,
            backgroundColor: whiteColor,
            onTap: (value) {
              controller.currentNavIndex.value = value;
            },
          ),
        ),
      ),
    );
  }
}
