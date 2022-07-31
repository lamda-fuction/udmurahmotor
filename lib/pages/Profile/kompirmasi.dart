import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:udmurahmotor/FuctionHelper/flusbar.dart';

import 'kompirmasiState.dart';

class Kompimasi extends StatefulWidget {
  const Kompimasi({Key? key}) : super(key: key);

  @override
  State<Kompimasi> createState() => _KompimasiState();
}

class _KompimasiState extends State<Kompimasi> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Komfirmasistate komfirmasistate = Get.put(Komfirmasistate());

    return Obx(
      () => (komfirmasistate.isLoading.isTrue)
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.amber,
              ),
            )
          : ListView.builder(
              itemCount: komfirmasistate.lisdata.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 5,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 5,
                        width: MediaQuery.of(context).size.width / 2.3,
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                                image: NetworkImage(komfirmasistate
                                    .lisdata[index].barang!.thumnails
                                    .toString()),
                                fit: BoxFit.cover)),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              komfirmasistate.lisdata[index].barang!.namabarang
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              "Rp.${komfirmasistate.lisdata[index].barang?.harga}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber),
                            ),
                            Text(
                              "ORDER CODE",
                              style: TextStyle(color: Colors.white54),
                            ),
                            InkWell(
                              onTap: () {
                                flusbartop(
                                    context,
                                    " copy order code to clipboard",
                                    Colors.green);
                                Clipboard.setData(ClipboardData(
                                    text: komfirmasistate
                                        .lisdata[index].ordercode));
                              },
                              child: Text(
                                komfirmasistate.lisdata[index].ordercode
                                    .toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                            ),
                            Material(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.amber,
                              child: InkWell(
                                onTap: () async {
                                  var kom = await komfirmasistate
                                      .kofirditerima(
                                          komfirmasistate.lisdata[index].id)
                                      .then((value) {
                                    if (komfirmasistate.diterima.isTrue) {
                                      flusbartop(
                                          context,
                                          "terimaksih atas kepercayaan anda",
                                          Colors.green);
                                      komfirmasistate.getapi();
                                    }
                                  });
                                  print(kom);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(7),
                                  child: Text(
                                    "barang sudah di terima",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }
}
