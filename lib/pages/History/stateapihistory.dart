import 'package:get/get.dart';

import '../../model/getorderbystatus_and _userid.dart';
import '../../service/order/getorder.dart';

class Steapihistory extends GetxController {
  var getorder = Getorder();
  var isLoading = false.obs;
  var iseror = false.obs;
  List<Dataorder> lisdata = <Dataorder>[].obs;
  getapi() async {
    try {
      isLoading(true);
      lisdata.clear();

      await getorder.getorder(5).then((value) {
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
}
