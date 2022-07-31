import 'package:http/http.dart' as http;

import 'dart:convert' as convert;

import '../../model/dasoardvalue.dart';

class Dasboardvalueservice {
  Future<Dasboardvalue> dasboardval() async {
    var url = "https://endpoindud.devmee.tech/dasboardvalue";
    var get = await http.get(Uri.parse(url));

    if (get.statusCode == 200) {
      var conv = convert.jsonDecode(get.body);
      return Dasboardvalue.fromjson(conv);
    }
    return Dasboardvalue.eror();
  }
}
