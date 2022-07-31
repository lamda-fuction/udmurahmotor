import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../../FuctionHelper/shared/shared.dart';
import '../../model/bayarwithmitrans.dart';

class Mutranst {
  Future<Bayarwithmitranst> bayarwithmitranst(
      bangname, ordercode, totalbayar, oderid) async {
    print("shared");
    var shered = Shared();
    var nama = await shered.getstring("nama");
    var email = await shered.getstring("email");

    var url = "https://endpoindud.devmee.tech/bayarwithmitrans/${oderid}";
    // var url = "http://192.168.168.15:3001/bayarwithmitrans/1";
    print("difined body and heder");
    var header = {"Content-Type": "application/json"};

    var body = {
      "payment_type": "bank_transfer",
      "bank_transfer": {"bank": bangname},
      "transaction_details": {
        "order_id": ordercode,
        "gross_amount": totalbayar
      },
      "nama": nama,
      "email": email,
      "from": "ud murah motor",
    };
    var bodydata = convert.json.encode(body);
    print("post data");
    // try {
    var post = await http.post(
      Uri.parse(url),
      body: bodydata,
      headers: header,
      // encoding: convert.Encoding.getByName("utf-8")
    );

    if (post.statusCode == 200) {
      // print(post.body);
      print("sukses post");

      // return convert.jsonDecode(post.body);
      final json = convert.jsonDecode(post.body);
      // print(json);
      return Bayarwithmitranst.frojson(json);
    } else {
      print("gagal post");
      final json = convert.jsonDecode(post.body);
      return Bayarwithmitranst.frojson(json);
    }
    // } catch (e) {
    //   print(e);
    // }
  }
}
