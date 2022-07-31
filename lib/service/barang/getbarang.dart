import '../../model/getbarang.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Getbarang {
  Future<GetBarang> getdatabarang(limit, offset) async {
    List<DataBarang> databarang = [];
    // var url = "https://endpoindud.devmee.tech/getbarang";
    var url = 
        "https://endpoindud.devmee.tech/getbarang?limit=${limit}&offset=${offset}";
    var get = await http.get(Uri.parse(url));
    if (get.statusCode == 200) {
      var responsejson = convert.jsonDecode(get.body);
      // GetBarang getdata = GetBarang.fromJson(responsejson);
      // getdata.data?.forEach((v) {
      //   databarang.add(v);
      // });
      return GetBarang.fromJson(responsejson);
    } else {
      return GetBarang.fromJson(convert.jsonDecode(get.body));
    }
  }

  Future<GetBarang> getrealdatabarang(limit, offset) async {
    List<DataBarang> databarang = [];
    // var url = "https://endpoindud.devmee.tech/getbarang";
    var url =
        "https://endpoindud.devmee.tech/getrealallbarang?limit=${limit}&offset=${offset}";
    var get = await http.get(Uri.parse(url));
    if (get.statusCode == 200) {
      var responsejson = convert.jsonDecode(get.body);
      // GetBarang getdata = GetBarang.fromJson(responsejson);
      // getdata.data?.forEach((v) {
      //   databarang.add(v);
      // });
      return GetBarang.fromJson(responsejson);
    } else {
      return GetBarang.fromJson(convert.jsonDecode(get.body));
    }
  }
}
