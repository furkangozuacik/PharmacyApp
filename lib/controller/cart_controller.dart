import 'package:get/get.dart';

class CartController extends GetxController {
  var totalP = RxInt(0);

  calculate(data) {
    for (var i = 0; i < data.length; i++) {
      totalP.value = totalP.value + int.parse(data[i]["tprice"].toString());
    }
  }
}
