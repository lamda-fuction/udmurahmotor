import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../../model/searchModel.dart';

class Searchserv {
  Future<Search> search(keyword) async {
    var url = "https://endpoindud.devmee.tech/searchbarang?keyword=${keyword}";
    var get = await http.get(Uri.parse(url));
    if (get.statusCode == 200) {
      var decode = convert.jsonDecode(get.body);
      return Search.fromjson(decode);
    }
    var decode = convert.jsonDecode(get.body);
    return Search.fromjson(decode);
  }
}
