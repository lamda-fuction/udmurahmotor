import 'package:flutter/material.dart';
import 'package:udmurahmotor/FuctionHelper/flusbar.dart';
import 'package:udmurahmotor/pages/Profile/statevariable.dart';
import 'package:udmurahmotor/pages/Profile/suksbayarmitrans.dart';
import 'package:udmurahmotor/pages/Profile/urllauch.dart';
import 'package:get/get.dart';

import '../../FuctionHelper/iternetchek.dart';
import '../../model/getkategoribarangbyid.dart';
import '../../model/getkelengkapan.dart';
import '../../service/kategori/kategoribarang.dart';

import 'dart:async';

import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../service/kelengkapan.dart';
import '../../service/mitranst/bayarwithmitrans.dart';

class Bayar extends StatefulWidget {
  final data;
  String? via;
  Bayar({Key? key, this.data, this.via}) : super(key: key);

  @override
  State<Bayar> createState() => _BayarState();
}

class _BayarState extends State<Bayar> {
  final Statevariable statevariable = Get.put(Statevariable());
  var state = Statevariable();
  var midrans = Mutranst();
  bool chekvalue = true;

  var _kategoriserv = Kategoribarangserv();
  var _kelengkapanserv = Kelengkapanservice();
  var _jenis;
  List<Datakelengkapan> _kelekapan = [];

  _getkate() {
    statevariable.cardbankloading(true);
    _kategoriserv
        .getkategoribyid(widget.data.barang?.KategoribarangId)
        .then((v) {
      if (v.message == "All Data") {
        setState(() {
          _jenis = v.data?.namakategori;
          // statevariable.cardbankloading(false);
        });

        _kelengkapanserv.getkelengkapan(widget.data.BarangId).then((v) {
          if (v.isNotEmpty) {
            setState(() {
              _kelekapan.assignAll(v);
              statevariable.cardbankloading(false);
            });
          } else {
            statevariable.cardbankloading(false);
          }
        });

        print(v.data?.namakategori);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: null,
        backgroundColor: Colors.black,
        title: Text(
          widget.data.barang!.namabarang,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        color: Color.fromARGB(8, 0, 0, 0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(
          top: 50,
          right: 50,
          left: 50,
        ),
        child: ListView(
          children: [
            Text(
              "anda bisa melakukan pembayaran dengan mendatangin sorum kami atau hubungi kami melalui",
              textAlign: TextAlign.justify,
            ),
            _launcer(),
            Text(
              "Anda juga Dapat Melakukan Pembayaran Melalui virtual account Kami Pilih salah satu Dari bank berikut",
              textAlign: TextAlign.justify,
            ),
            Container(
                // color: Color.fromARGB(8, 0, 0, 0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.2,
                child: ListView(
                  children: [
                    cardbank(
                      context,
                      "BNI",
                      Image.asset("assets/bni.png", fit: BoxFit.contain),
                    ),
                    cardbank(
                      context,
                      "BRI",
                      Image.asset("assets/bri.png", fit: BoxFit.contain),
                    ),
                    cardbank(
                      context,
                      "BCA",
                      Image.asset("assets/bca.png", fit: BoxFit.contain),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return false; //<-- SEE HERE
  }

  Container cardbank(
    BuildContext context,
    bankname,
    image,
  ) {
    return Container(
        child: InkWell(
            onTap: () {
              cekonection().then(
                (value) {
                  if (value) {
                    _getkate();
                    showDialog(
                        context: context,
                        builder: (context) => Material(
                              color: Colors.black12,
                              child: Obx(() {
                                return (statevariable.cardbankloading == true)
                                    ? Container(
                                        width: MediaQuery.of(
                                          context,
                                        ).size.width,
                                        height: MediaQuery.of(
                                          context,
                                        ).size.height,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                              color: Colors.amber),
                                        ),
                                      )
                                    : WillPopScope(
                                        onWillPop: _onWillPop,
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          child: Center(
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.3,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              // color: Colors.white,
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      color: Colors.white,
                                                      // width:
                                                      //     MediaQuery.of(context).size.width / 1.2,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              2,
                                                      padding:
                                                          EdgeInsets.all(20),
                                                      child:
                                                          ListView(children: [
                                                        Text("DATA BARANG :"),
                                                        Text(
                                                            "nama barang: ${widget.data.barang!.namabarang}"),
                                                        Text(
                                                            " jenis barang: ${_jenis}"),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                "KELENGKAPAN:"),
                                                            Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  1.5,
                                                              height: 15,
                                                              child: ListView
                                                                  .builder(
                                                                scrollDirection:
                                                                    Axis.horizontal,
                                                                itemCount:
                                                                    _kelekapan
                                                                        .length,
                                                                itemBuilder:
                                                                    (context,
                                                                        index) {
                                                                  return (_kelekapan
                                                                          .isNotEmpty)
                                                                      ? Text(
                                                                          "${_kelekapan[index].dpkument},")
                                                                      : Text(
                                                                          "kosong");
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                            "ALAMAT PENGIRIMAN :"),
                                                        Text(
                                                            "${widget.data.alamatkirim}"),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text("PEMBAYARAN:"),
                                                        (bankname == "BNI")
                                                            ? Text(
                                                                "BNI VIRTUAL ACCOUNT")
                                                            : (bankname ==
                                                                    "BRI")
                                                                ? Text(
                                                                    "BRI VIRTUAL ACCOUNT")
                                                                : (bankname ==
                                                                        "PERMATA")
                                                                    ? Text(
                                                                        "PERMATA VIRTUAL ACCOUNT")
                                                                    : Text(
                                                                        "BCA VIRTUAL ACCOUNT")
                                                      ]),
                                                    ),
                                                    Container(
                                                      child: CheckboxListTile(
                                                          activeColor:
                                                              Colors.black,
                                                          checkColor:
                                                              Colors.amber,
                                                          value: statevariable
                                                              .checkbox(),
                                                          title: Text(
                                                            "anda menyetujui segala ketentuan yang berlaku",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .amber),
                                                          ),
                                                          onChanged: (v) {
                                                            // setState(() {
                                                            statevariable
                                                                .checkbox(v);
                                                            // });
                                                          }),
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              1.2,
                                                      // height: MediaQuery.of(context).size.height / 2.5,
                                                      margin: EdgeInsets.only(
                                                          top: 7),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context);
                                                              statevariable
                                                                  .checkbox(
                                                                      false);
                                                            },
                                                            child: Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            30,
                                                                        right:
                                                                            30,
                                                                        top: 10,
                                                                        bottom:
                                                                            10),
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .black,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            50)),
                                                                child: Text(
                                                                  "cancle",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20,
                                                                  ),
                                                                )),
                                                          ),
                                                          InkWell(
                                                            onTap: () async {
                                                              if (statevariable
                                                                      .checkbox ==
                                                                  true) {
                                                                if (statevariable
                                                                        .loadingbayar ==
                                                                    false) {
                                                                  //======service bayar==========
                                                                  await midrans
                                                                      .bayarwithmitranst(
                                                                          bankname,
                                                                          widget
                                                                              .data
                                                                              .ordercode,
                                                                          widget
                                                                              .data
                                                                              .barang
                                                                              ?.harga,
                                                                          widget
                                                                              .data
                                                                              .id)
                                                                      .then(
                                                                          (value) {
                                                                    print(value
                                                                        .data!
                                                                        .va_number![
                                                                            0]
                                                                        .va_numbers);
                                                                    Get.to(
                                                                        Suksesbayarwidhmitrans(
                                                                      bank: value
                                                                          .data!
                                                                          .va_number![
                                                                              0]
                                                                          .bank,
                                                                      tagihan: value
                                                                          .data!
                                                                          .gross_amount,
                                                                      vanumber: value
                                                                          .data!
                                                                          .va_number![
                                                                              0]
                                                                          .va_numbers,
                                                                    ));
                                                                  }).catchError(
                                                                          (e) {
                                                                    print(e);
                                                                  });
                                                                }
                                                              }
                                                            },
                                                            child: Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            50,
                                                                        right:
                                                                            50,
                                                                        top: 10,
                                                                        bottom:
                                                                            10),
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .black,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            50)),
                                                                child: Text(
                                                                  "Bayar",
                                                                  style:
                                                                      TextStyle(
                                                                    color: (statevariable.checkbox ==
                                                                            false)
                                                                        ? Colors
                                                                            .white24
                                                                        : Colors
                                                                            .white,
                                                                    fontSize:
                                                                        20,
                                                                  ),
                                                                )),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ]),
                                            ),
                                          ),
                                        ),
                                      );
                              }),
                            ));
                  } else {
                    flusbartop(context, "anda sedang off line", Colors.amber);
                  }
                },
              );
            },
            child: Container(
                // padding: EdgeInsets.all(5),
                margin: EdgeInsets.all(15),
                // color: Color.fromARGB(255, 221, 16, 16),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width / 5,
                child: image)));
  }

  Container _launcer() {
    return Container(
      margin: EdgeInsets.only(top: 30, bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Urllauch(
            title: "Whatshapp",
            icon: Image(
              image: AssetImage(
                "assets/watshap.png",
              ),
              fit: BoxFit.cover,
            ),
          ),
          Urllauch(
            title: "Email",
            icon: Image(image: AssetImage("assets/gmail.png")),
          ),
          Urllauch(
            title: "Panggil",
            icon: Image(image: AssetImage("assets/call.png")),
          )
        ],
      ),
    );
  }
}
