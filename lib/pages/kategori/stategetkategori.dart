import 'package:get/get.dart';

import '../../model/getbarangbykategoriId.dart';
import '../../service/barang/getbykategoriId.dart';

class Stategetkategori extends GetxController {
  GetbykategoriId getbykategoriId = GetbykategoriId();
  List<LisbarangbykategoriId> listdata = <LisbarangbykategoriId>[].obs;
  var isloading = false.obs;
  var iseror = false.obs;
  getdata(id) {
    isloading(true);
    listdata.clear();
    try {
      getbykategoriId.getbarangbykategoriid(id).then((v) {
        if (v.databarang!.isNotEmpty) {
          v.databarang?.forEach((x) {
            listdata.add(x);
          });
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
