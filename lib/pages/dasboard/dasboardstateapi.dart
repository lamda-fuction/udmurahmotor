import 'package:get/get.dart';

import '../../service/dasboardvalues/dasboardvalues.dart';

class Dasboardstateapi extends GetxController {
  Dasboardvalueservice dasboardvalueservice = Dasboardvalueservice();
  var alluser = "".obs;
  var allbarang = "".obs;
  var allterjualterkopir = "".obs;
  var allterjualbelumterkopir = "".obs;

  var isloading = false.obs;
  getData() {
    isloading(true);
    try {
      dasboardvalueservice.dasboardval().then((value) {
        if (value.mesage == "get data sucsess") {
          alluser(value.datadasboardvalues?.alluser.toString());
          allbarang(value.datadasboardvalues?.allbarang.toString());
          allterjualterkopir(
              value.datadasboardvalues?.barangterjualterkompir.toString());
          allterjualbelumterkopir(
              value.datadasboardvalues?.barangterjualbelumdikompir.toString());
          isloading(false);
        }
        isloading(false);
      });
    } catch (e) {
      print(e);
      isloading(false);
    }
  }
}
