import 'package:get/get.dart';

import '../../model/getorderbystatus_and _userid.dart';
import '../../service/order/getorder.dart';
import '../../service/order/updatestatus.dart';

class Komfirmasistate extends GetxController {
  var getorder = Getorder();
  var isLoading = false.obs;
  var iseror = false.obs;
  List<Dataorder> lisdata = <Dataorder>[].obs;

  getapi() async {
    print("=============kommmm");

    try {
      isLoading(true);
      lisdata.clear();
      await getorder.getorder(4).then((value) {
        if (value.isNotEmpty) {
          isLoading(false);
          lisdata.assignAll(value);
        } else {
          isLoading(false);
        }
      });
    } catch (e) {
      iseror(true);
      isLoading(false);
      print(e);
    }
  }

  Updatestatus dpdatestatus = Updatestatus();
  var diterima = false.obs;
  kofirditerima(id) async {
    diterima(false);
    try {
      await dpdatestatus.updatestatusorder(5, id).then((value) {
        if (value["mesage"] == "update data sucsess") {
          diterima(true);
        } else {
          diterima(false);
        }
      });
    } catch (e) {
      print(e);
      diterima(false);
    }
  }
}
