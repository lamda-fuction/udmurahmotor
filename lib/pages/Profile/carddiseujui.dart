import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:udmurahmotor/FuctionHelper/flusbar.dart';
import 'package:udmurahmotor/pages/Profile/bayar.dart';

import '../../service/cekstatuspembayaran/satatusenquirirequest.dart';
import '../../service/order/deleterder.dart';
import 'suksbayarmitrans.dart';

class Disetujui extends StatelessWidget {
  var data;
  Disetujui({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var enquiri = Equerystatus();
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width / 2.3,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2.3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                    image: NetworkImage(data.barang!.thumnails),
                    fit: BoxFit.cover)),
          ),
          Container(
            margin: EdgeInsets.only(left: 2),
            // color: Colors.blue,
            width: MediaQuery.of(context).size.width / 2,
            padding: EdgeInsets.only(bottom: 10, top: 3, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  data.barang!.namabarang,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "oderan anda disetujui segera lakukan pembayaran",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.start,
                ),
                Text(
                  "Rp.${data.barang.harga}",
                  style: TextStyle(fontSize: 20, color: Colors.amber),
                  textAlign: TextAlign.start,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        Deleteorder deleteorder = Deleteorder();
                        deleteorder.deleteorders(data.id).then((value) {
                          print(value["mesage"]);
                          if (value["mesage"] == "delete data sucsess") {
                            navigator?.pushReplacementNamed("/Mainpage");
                          }
                        });
                      },
                      child: Container(
                          padding: EdgeInsets.only(
                              top: 7, bottom: 7, right: 10, left: 10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(50)
                              // color: Colors.amber,
                              ),
                          child: Text(
                            "batalkan",
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          )),
                    ),
                    InkWell(
                      onTap: () {
                        print(data.ordercode);
                        print(data.id);

                        enquiri.Cekenquiri(data.ordercode, data.id)
                            .then((value) {
                          print(value["mesage"]);
                          if (value["mesage"] == "yes") {
                            cardinfo(context, value);
                          } else {
                            Get.to(Bayar(data: data),
                                transition: Transition.noTransition);
                          }
                        });
                      },
                      child: Container(
                          padding: EdgeInsets.only(
                              top: 7, bottom: 7, right: 10, left: 10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(50)
                              // color: Colors.amber,
                              ),
                          child: Text(
                            "bayar sekarang",
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          )),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<dynamic> cardinfo(BuildContext context, value) {
    return showDialog(
        context: context,
        builder: (context) => Material(
              color: Color.fromARGB(0, 0, 0, 0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                // color: Colors.amber,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: Icon(
                                Icons.close,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(9),
                      width: MediaQuery.of(context).size.width / 1.3,
                      height: MediaQuery.of(context).size.height / 1.7,
                      color: Color.fromARGB(255, 255, 255, 255),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "lakukan pembayar melalu virtual accoun ",
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(height: 5),
                          Text("bank : ${value["bank"]}"),
                          Text("total_tagihan : Rp: ${value["total_tagihan"]}"),
                          SizedBox(height: 5),
                          Text(
                            "va_number",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 23),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${value["va_number"]}",
                                style: TextStyle(
                                    color: Colors.amber,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 23),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Material(
                                child: InkWell(
                                  splashColor: Colors.amber,
                                  onTap: () {
                                    Clipboard.setData(ClipboardData(
                                        text: value["va_number"]));
                                    flusbartop(context, "copy va number",
                                        Colors.amber);
                                  },
                                  child: Row(
                                    children: [Icon(Icons.copy), Text("copy")],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ));
  }
}
