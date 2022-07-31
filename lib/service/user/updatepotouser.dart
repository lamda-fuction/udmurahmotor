import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../../FuctionHelper/shared/shared.dart';

class Postpotobprofile {
  Future postfrofile(id, poto) async {
    var shared = Shared();
    var token = await shared.getstring("token");
    var header = {"authorization": "bearer ${token}"};
    var url = "https://endpoindud.devmee.tech/updateuserpoto/${id}";
    var post = http.MultipartRequest("POST", Uri.parse(url));
    post.headers.addAll(header);
    // post.fields["BarangId"] = barangId.toString();
    post.files.add(await http.MultipartFile.fromPath("userprofile", poto.path));

    var response = await post.send();
    var responsd = await http.Response.fromStream(response);
    final resdata = convert.json.decode(responsd.body);

    if (response.statusCode == 200) {
      print(resdata["mesage"]);
      return resdata;
    }
  }
}
