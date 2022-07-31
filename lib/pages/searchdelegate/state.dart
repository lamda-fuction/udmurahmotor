import 'package:get/get.dart';

import '../../model/searchModel.dart';
import '../../service/searcing/searcing.dart';

class Statesearch extends GetxController {
  var search = Searchserv();
  var isLoading = false.obs;
  List<Datasearch> data = <Datasearch>[].obs;

  getSearch(v) {
    isLoading(true);
    data.clear();
    search.search(v).then((value) {
      if (value.datasearch!.isNotEmpty) {
        value.datasearch!.forEach((element) {
          data.add(element);
        });
      }
      isLoading(false);
    }).catchError((e) {
      print(e);
    });
  }
}
