import 'package:flutter/material.dart';

import '../../../model/getbarang.dart';
import '../../../service/barang/deletebarang.dart';
import '../../../service/barang/getbarang.dart';
import '../appbar.dart';
import '../sidebar.dart';
import 'detailbarang.dart';
import 'form.dart';
import 'updateform.dart';

class Barang extends StatefulWidget {
  const Barang({Key? key}) : super(key: key);

  @override
  State<Barang> createState() => _BarangState();
}

class _BarangState extends State<Barang> {
  var barang = Getbarang();
  var deletebarang = Deletebarang();
  List<Widget> databarang = [];
  var limit = 10;
  var offset = 0;
  bool isloading = false;

  _getdatabarang() {
    barang.getrealdatabarang(limit, offset).then((value) {
      if (value.mesage == "All Data") {
        value.data!.forEach((v) {
          setState(() {
            databarang
                .add(Listbarang(MediaQuery.of(context).size.width, context, v));
          });
        });
        databarang.insert(
            databarang.length,
            _loadbutton(
                MediaQuery.of(context).size.width, value.limit, value.offset));
      }
    });
  }

  _getdatabaranglast() {
    barang.getdatabarang(limit, offset).then((value) {
      if (value.mesage == "All Data") {
        setState(() {
          isloading = false;
        });
        databarang.removeAt(databarang.length - 1);

        value.data!.forEach((v) {
          setState(() {
            databarang
                .add(Listbarang(MediaQuery.of(context).size.width, context, v));
          });
        });
        databarang.insert(
            databarang.length,
            _loadbutton(
                MediaQuery.of(context).size.width, value.limit, value.offset));
      }
    }).catchError((e) {
      setState(() {
        offset = 0;
      });
    });
  }

  Container Listbarang(
      double Mediaquerywidth, BuildContext context, DataBarang d) {
    return Container(
      padding: EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: Mediaquerywidth / 6.3,
            height: Mediaquerywidth / 7.3,
            margin: EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(d.thumnails.toString()),
                    fit: BoxFit.cover)),
          ),
          Container(
              width: Mediaquerywidth / 2.7,
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Detailbarang(
                                  namabarang: d.namabarang,
                                  thumnails: d.thumnails,
                                  harga: d.harga,
                                  keterangan: d.keterangan,
                                  kategoribarangId: d.kategoribarangId,
                                  no_plat: d.noPlat,
                                  id: d.id,
                                )));
                  },
                  child: Text(d.id.toString()))),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateForm(
                        id: d.id,
                        namabarang: d.namabarang,
                        harga: d.harga,
                        kategoribarangId: d.kategoribarangId,
                        keterangan: d.keterangan,
                        no_plat: d.noPlat,
                        thumnails: d.thumnails,
                      ),
                    ));
              },
              icon: Icon(Icons.update)),
          IconButton(
              onPressed: () {
                deletebarang.deletedatabarang(d.id.toString()).then((value) {
                  print(value);
                  if (value['mesage'] == "delete data sucsess") {
                    Navigator.pushReplacementNamed(context, "/Barang");
                  } else {
                    print("eror");
                  }
                });
              },
              icon: Icon(Icons.delete))
        ],
      ),
    );
  }

  Container _loadbutton(widthbuton, lim, offs) {
    return Container(
      child: InkWell(
        onTap: () {
          setState(() {
            isloading = true;
          });
          setState(() {
            offset = offset + 10;
          });
          _getdatabaranglast();
        },
        child: Container(
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.only(top: 10, bottom: 10),
          width: widthbuton,
          decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(),
              borderRadius: BorderRadius.circular(5)),
          child: Center(
              child: (isloading == false)
                  ? Text(
                      "LOADMORE",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    )
                  : CircularProgressIndicator(
                      color: Colors.amber,
                    )),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getdatabarang();
  }

  @override
  Widget build(BuildContext context) {
    var Mediaquerywidth = MediaQuery.of(context).size.width;
    var Mediaqueryhight = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: Sidebar(),
      appBar: dsboardappbar(context),
      body: Container(
        margin: EdgeInsets.all(10),
        width: Mediaquerywidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //kategori
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => Forminputbarang()));
              },
              child: Container(
                width: Mediaquerywidth / 2,
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  // color: Colors.blue,
                  border: Border.all(),
                ),
                child: Row(
                  children: [
                    Text(
                      "Daftarkan Barang",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Icon(Icons.plus_one)
                  ],
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.all(10),
                width: Mediaquerywidth,
                height: Mediaqueryhight / 1.3,
                child: (databarang.isNotEmpty)
                    ? ListView.builder(
                        itemCount: databarang.length,
                        itemBuilder: (context, index) {
                          return databarang[index];
                        })
                    : Center(
                        child: CircularProgressIndicator(
                          color: Colors.amber,
                        ),
                      ))
          ],
        ),
      ),
    );
  }
}
