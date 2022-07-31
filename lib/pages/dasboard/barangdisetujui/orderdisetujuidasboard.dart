// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import '../../../model/getorderbystatus_and _userid.dart';
import '../../../service/order/deleterder.dart';
import '../../../service/order/getorder.dart';
import '../../../service/order/updatestatus.dart';
import '../appbar.dart';
import '../sidebar.dart';

class Orderdisetujui extends StatefulWidget {
  const Orderdisetujui({Key? key}) : super(key: key);

  @override
  State<Orderdisetujui> createState() => _OrderdisetujuiState();
}

class _OrderdisetujuiState extends State<Orderdisetujui> {
  final textformfieldrool = TextEditingController();
  final order = Getorder();
  final updatestatus = Updatestatus();
  Deleteorder deleteorder = Deleteorder();

  List<Dataorder> filter = [];

  _getfilter(code) {
    filter.clear();
    order.getorderbystatus(3).then((value) {
      if (value.isNotEmpty) {
        for (int i = 0; i < value.length; i++) {
          final String? ordercode = value[i].ordercode;
          if (ordercode == code) {
            setState(() {
              filter.add(value[i]);
            });
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var Mediawidth = MediaQuery.of(context).size.width;
    var Mediaheight = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: Sidebar(),
      appBar: dsboardappbar(context),
      body: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // search
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text("Cari order"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: Mediawidth / 1.5,
                  height: Mediaheight / 15,
                  child: TextFormField(
                    onChanged: (v) {
                      _getfilter(v);
                    },
                    // onFieldSubmitted: _getfilter(textformfieldrool.text),
                    controller: textformfieldrool,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        hintText: "orderID . . .",
                        labelText: "Cari orders",
                        labelStyle: TextStyle(color: Colors.black)),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _getfilter(textformfieldrool.text);
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    margin: EdgeInsets.only(left: 5),
                    height: Mediaheight / 15,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        "create",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
            //default
            Container(
              height: 200,
              width: Mediaheight,
              //fututre
              child: (filter.isNotEmpty)
                  ? filterview(Mediawidth, Mediaheight)
                  : futerofdata(Mediawidth, Mediaheight),
              //end future
            )
            //end default
          ],
        ),
      ),
    );
  }

  filterview(double Mediawidth, double Mediaheight) {
    return ListView.builder(
      // scrollDirection: Axis.horizontal,
      itemCount: filter.length,
      itemBuilder: (context, index) {
        final d = filter[index];
        return InkWell(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      content: Container(
                        width: Mediawidth,
                        height: Mediaheight / 4,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text("namabarang:"),
                                Text(d.barang!.namabarang.toString())
                              ],
                            ),
                            Row(
                              children: [
                                Text("codeorder:"),
                                Text(d.ordercode.toString())
                              ],
                            ),
                            Row(
                              children: [
                                Text("no-plat:"),
                                Text(d.barang!.no_plat!.toString())
                              ],
                            ),
                            Row(
                              children: [
                                Text("harga:"),
                                Text(d.barang!.harga.toString())
                              ],
                            ),
                            Row(
                              children: [
                                Text("tgl_order:"),
                                Text(d.orderdate.toString())
                              ],
                            ),
                            Row(
                              children: [
                                Text("alamat kirim:"),
                                Text(d.alamatkirim.toString())
                              ],
                            )
                          ],
                        ),
                      ),
                    ));
          },
          child: Container(
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 1, color: Colors.black))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: Mediawidth / 8,
                  height: Mediawidth / 7,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(d.barang!.thumnails.toString()))),
                ),
                Container(
                  margin: EdgeInsets.only(left: 2),
                  child: Text(d.barang!.namabarang!.toString()),
                ),
                InkWell(
                  onTap: () {
                    deleteorder.deleteorders(d.id).then((value) {
                      if (value["mesage"] == "delete data sucsess") {
                        Navigator.pushReplacementNamed(context, "/disetui");
                      }
                    });
                  },
                  child: Container(
                    width: Mediawidth / 7,
                    // height: Mediaheight / 9,
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: Center(
                      child: Text(
                        "batalkan",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5)),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  FutureBuilder<List<Dataorder>> futerofdata(
      double Mediawidth, double Mediaheight) {
    return FutureBuilder<List<Dataorder>>(
      future: order.getorderbystatus(3),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //listviewbuild
          return ListView.builder(
            // scrollDirection: Axis.horizontal,
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              final d = snapshot.data?[index];
              return InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            content: Container(
                              width: Mediawidth,
                              height: Mediaheight / 4,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text("namabarang:"),
                                      Text(d!.barang!.namabarang!.toString())
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("codeorder:"),
                                      Text(d.ordercode.toString())
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("no-plat:"),
                                      Text(d.barang!.no_plat!.toString())
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("harga:"),
                                      Text(d.barang!.harga.toString())
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("tgl_order:"),
                                      Text(d.orderdate.toString())
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("alamat kirim:"),
                                      Text(d.alamatkirim.toString())
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ));
                },
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1, color: Colors.black))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: Mediawidth / 8,
                        height: Mediawidth / 7,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    d!.barang!.thumnails.toString()))),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 2),
                        child: Text(d.barang!.namabarang!.toString()),
                      ),
                      InkWell(
                        onTap: () {
                          deleteorder.deleteorders(d.id).then((value) {
                            if (value["mesage"] == "delete data sucsess") {
                              Navigator.pushReplacementNamed(
                                  context, "/disetui");
                            }
                          });
                        },
                        child: Container(
                          width: Mediawidth / 7,
                          // height: Mediaheight / 9,
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          child: Center(
                            child: Text(
                              "batalkan",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(5)),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
          //end listviewbuild
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.amber,
            ),
          );
        }
      },
    );
  }
}
