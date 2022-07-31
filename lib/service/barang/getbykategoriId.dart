import '../../model/getbarangbykategoriId.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class GetbykategoriId {
  Future<GetbarangbykategoriId> getbarangbykategoriid(id) async {
    var url = "https://endpoindud.devmee.tech/usergetbarangbykategoryid/${id}";
    var get = await http.get(Uri.parse(url));
    if (get.statusCode == 200) {
      return GetbarangbykategoriId.fromjson(convert.jsonDecode(get.body));
    } else {
      return GetbarangbykategoriId.fromjson(convert.jsonDecode(get.body));
    }
  }
}
