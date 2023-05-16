import 'package:get/get.dart';
import 'package:pharmacy/consts/firebase_consts.dart';

class HomeController extends GetxController {
  var currentNavIndex = 0.obs;
  var username = "";
  void onInit() {
    getUsername();
    super.onInit();
  }

  getUsername() async {
    var n = await firestore
        .collection(usersCollection)
        .where("id", isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single["name"];
      }
    });

    username = n;
  }
}
