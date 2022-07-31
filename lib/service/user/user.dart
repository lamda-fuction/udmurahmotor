import '../../FuctionHelper/shared/shared.dart';
import '../../model/getalluser.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../../model/getoneuser.dart';

class Userservice {
  Future<Getuserall> getuserall() async {
    // List<Userdatall> datauser = [];
    var shared = Shared();
    var token = await shared.getstring("token");
    var header = {"authorization": "bearer ${token}"};
    var url = "https://endpoindud.devmee.tech/getalluser";
    var get = await http.get(Uri.parse(url), headers: header);

    if (get.statusCode == 200) {
      var decode = convert.jsonDecode(get.body);
      Getuserall datausr = Getuserall.fromjson(decode);
      // datausr.data?.forEach((v) {
      //   datauser.add(v);
      // });

      return datausr;
    } else {
      var decode = convert.jsonDecode(get.body);
      Getuserall datausr = Getuserall.fromjson(decode);
      return datausr;
    }
  }

  Future<Getuserone> getuserby(user) async {
    var url =
        "https://endpoindud.devmee.tech/getuserbynamerusernameemail/${user}";
    var get = await http.get(
      Uri.parse(url),
    );
    if (get.statusCode == 200) {
      var decode = convert.jsonDecode(get.body);
      // print(decode);
      Getuserone dataone = Getuserone.fromjson(decode);
      return dataone;
    } else {
      var decode = convert.jsonDecode(get.body);
      Getuserone dataone = Getuserone.fromjson(decode);
      return dataone;
    }
  }

  Future updateuserrol(id, rolid) async {
    var shared = Shared();
    var token = await shared.getstring("token");
    var header = {"authorization": "bearer ${token}"};
    var body = {"RoltableId": rolid};
    var url = "https://endpoindud.devmee.tech/updateuserrol/${id}";
    var update = await http.post(Uri.parse(url), body: body, headers: header);
    if (update.statusCode == 200) {
      var decode = convert.jsonDecode(update.body);
      return decode;
    } else {
      return convert.jsonDecode(update.body);
    }
  }
}
