import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udmurahmotor/FuctionHelper/appbar.dart';

import 'stategetkategori.dart';

class Kategori extends StatefulWidget {
  const Kategori({Key? key, this.id, this.kategoriname, this.params})
      : super(key: key);
  final id;
  final kategoriname;
  final params;
  @override
  State<Kategori> createState() => _KategoriState();
}

class _KategoriState extends State<Kategori> {
  @override
  Widget build(BuildContext context) {
    var Mediaquerywidth = MediaQuery.of(context).size.width;
    var Mediaqueryhight = MediaQuery.of(context).size.height;
    Stategetkategori stategetkategori = Get.put(Stategetkategori());
    stategetkategori.getdata(widget.params["id"]);
    return Scaffold(
      appBar: appbar(context, Mediaquerywidth, Mediaqueryhight, false),
      body: Container(
        padding: EdgeInsets.only(left: 15),
        width: Mediaquerywidth,
        height: Mediaqueryhight,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Text(
                "Kategori : ${widget.params["namakategori"]}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Obx(
              () => (stategetkategori.isloading.isTrue)
                  ? Container(
                      width: Mediaquerywidth,
                      height: Mediaqueryhight / 1.6,
                      child: const Center(
                        child: CircularProgressIndicator(color: Colors.amber),
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(top: 20, right: 12),
                      width: Mediaquerywidth,
                      height: Mediaqueryhight / 1.2,
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  childAspectRatio: 3.2 / 5,
                                  // childAspectRatio: 3 / 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          itemCount: stategetkategori.listdata.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/Details',
                                    arguments: {
                                      "id": stategetkategori.listdata[index].id,
                                      "nama": stategetkategori
                                          .listdata[index].namabarang,
                                      "harga": stategetkategori
                                          .listdata[index].harga,
                                      "thumnails": stategetkategori
                                          .listdata[index].thumnails,
                                      "keterangan": stategetkategori
                                          .listdata[index].keterangan
                                    });
                              },
                              child: Card(
                                child: Container(
                                  width: Mediaquerywidth / 2,
                                  height: Mediaqueryhight / 3,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(5)),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    "${stategetkategori.listdata[index].thumnails}"),
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          width: Mediaquerywidth,
                                          padding:
                                              EdgeInsets.only(top: 15, left: 7),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 15),
                                                  child: Text(
                                                    "${stategetkategori.listdata[index].namabarang}",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                              Text(
                                                "Rp.${stategetkategori.listdata[index].harga}",
                                                style: TextStyle(
                                                    color: Colors.amber,
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
