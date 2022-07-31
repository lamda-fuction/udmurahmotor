import '../../FuctionHelper/shared/shared.dart';
import '../../model/getorderbystatus_and _userid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Getorder {
  Future<List<Dataorder>> getorder(status) async {
    var shered = Shared();

    var userid = await shered.getint("id");

    List<Dataorder> data = [];
    var url =
        "https://endpoindud.devmee.tech/getorderbystatus_and_userid?userid=${userid}&status=${status}";
    var get = await http.get(Uri.parse(url));
    if (get.statusCode == 200) {
      var decode = convert.jsonDecode(get.body);
      Orders orderdata = Orders.fromjson(decode);
      orderdata.data?.forEach((v) {
        data.add(v);
      });

      return data;
    } else {
      return data;
    }
  }

  Future<List<Dataorder>> getorderbystatus(status) async {
    List<Dataorder> data = [];
    var url =
        "https://endpoindud.devmee.tech/getorderbystatus?status=${status}";
    var get = await http.get(Uri.parse(url));
    if (get.statusCode == 200) {
      var decode = convert.jsonDecode(get.body);
      Orders orderdata = Orders.fromjson(decode);
      orderdata.data?.forEach((v) {
        data.add(v);
      });

      return data;
    } else {
      return data;
    }
  }
}
