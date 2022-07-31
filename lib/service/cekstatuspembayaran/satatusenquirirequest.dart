import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Equerystatus {
  Future Cekenquiri(ordercode, id) async {
    try {
      var body = {
        "ordercode": ordercode,
      };
      var url = "https://endpoindud.devmee.tech/cekorderenquiristatus/${id}";
      var get = await http.post(Uri.parse(url), body: body);

      if (get.statusCode == 200) {
        return convert.jsonDecode(get.body);
      }
    } catch (e) {
      print(e);
    }
  }
}
