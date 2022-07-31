// ignore_for_file: prefer_const_constructors
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:udmurahmotor/FuctionHelper/appbar.dart';

import '../../model/getkategoribarang.dart';
import '../../service/barang/getbarang.dart';
import '../../service/kategori/kategoribarang.dart';
import '../searchdelegate/searchPage.dart';
import 'cardbarang.dart';
import 'crosel.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var barang = Getbarang();
  var kategori = Kategoribarangserv();
  List<Widget> databarang = [];
  var limit = 10;
  var offset = 0;
  bool isloading = false;

  _getdatabarang() {
    barang.getdatabarang(limit, offset).then((value) {
      if (value.mesage == "All Data") {
        value.data!.forEach((v) {
          setState(() {
            databarang.add(Cardbarang(
              id: v.id,
              nama: v.namabarang,
              thumnails: v.thumnails,
              harga: v.harga,
              keterangan: v.keterangan,
            ));
          });
        });
      }
    });
  }

  _getdatabaranglast() {
    barang.getdatabarang(limit, offset).then((value) {
      if (value.mesage == "All Data") {
        setState(() {
          isloading = false;
        });
        // databarang.removeAt(databarang.length - 1);

        value.data!.forEach((v) {
          setState(() {
            databarang.add(Cardbarang(
              id: v.id,
              nama: v.namabarang,
              thumnails: v.thumnails,
              harga: v.harga,
              keterangan: v.keterangan,
            ));
          });
        });
      }
    }).catchError((e) {
      setState(() {
        offset = 0;
      });
    });
  }

  Container _loadbutton() {
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
          margin: EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 10),
          padding: EdgeInsets.only(top: 10, bottom: 10),
          width: MediaQuery.of(context).size.width,
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

  List<Datakategori> kategoribarang = [];

  _getkate() {
    kategori.getkatebarang().then((value) {
      if (value.isNotEmpty) {
        value.forEach((v) {
          setState(() {
            kategoribarang.add(v);
          });
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getdatabarang();
    _getkate();
  }

  @override
  Widget build(BuildContext context) {
    var Mediaquerywidth = MediaQuery.of(context).size.width;
    var Mediaqueryhight = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: appbar(context, Mediaquerywidth, Mediaqueryhight, false),
      body: Container(
        // padding: EdgeInsets.only(left: 12, right: 10),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              // collapsedHeight: 50,
              elevation: 0,
              pinned: true,
              floating: true,
              // shadowColor: Colors.white,
              foregroundColor: Colors.white,
              backgroundColor: Colors.black12,

              expandedHeight: 200.0,
              // toolbarHeight: 100,
              flexibleSpace: FlexibleSpaceBar(
                background: Crosell(),
              ),
              title: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        // Get.to(SearchPage());
                        Get.toNamed("/search");
                        // Navigator.pushNamed(context, "/search");
                      },
                      // showSearch(context: context, delegate: Search()),
                      child: Container(
                        width: Mediaquerywidth / 1.4,
                        height: Mediaqueryhight / 20,
                        padding: EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text(
                              "Search . . .",
                              style: TextStyle(color: Colors.black45),
                            ),
                            Icon(
                              Icons.search,
                              size: 30,
                              color: Colors.black,
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.white,
                              width: 1,
                            )),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 22,
                      child: IconButton(
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pushNamed(context, "/Cart");
                          },
                          icon: Icon(
                            Icons.shopping_cart_outlined,
                            size: 30,
                            color: Colors.black,
                          )),
                    )
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 10, bottom: 5),
                      padding: EdgeInsets.only(left: 15),
                      child: Text("Kategori"))
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.only(left: 10),
                width: Mediaquerywidth,
                height: Mediaqueryhight / 19,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: kategoribarang.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/Kategori', arguments: {
                            "id": kategoribarang[index].id,
                            "namakategori": kategoribarang[index].namakategori
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 5, right: 5),
                          padding: EdgeInsets.only(
                              top: 3, bottom: 3, right: 30, left: 30),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: Text(
                              kategoribarang[index].namakategori.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 7, bottom: 2),
                      padding: EdgeInsets.only(left: 15),
                      child: Text("Barang",
                          style: TextStyle(fontWeight: FontWeight.bold)))
                ],
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(left: 10, right: 10),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  // maxCrossAxisExtent: 200.0,

                  maxCrossAxisExtent: 200,
                  mainAxisSpacing: 10.0,
                  // crossAxisSpacing: 10.0,
                  crossAxisSpacing: 9,
                  // childAspectRatio: 4.0,
                  childAspectRatio: 3.2 / 5,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return databarang[index];
                    // return Container(
                    //   alignment: Alignment.center,
                    //   color: Colors.teal[100 * (index % 9)],
                    //   child: Text('grid item $index'),
                    // );
                  },
                  childCount: databarang.length,
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              _loadbutton()
              // Container(
              //   child: InkWell(
              //     onTap: () {
              //       setState(() {
              //         isloading = true;
              //       });
              //       setState(() {
              //         offset = offset + 10;
              //       });
              //       _getdatabaranglast();
              //     },
              //     child: Container(
              //       margin: EdgeInsets.only(
              //           top: 10, left: 10, right: 10, bottom: 20),
              //       padding: EdgeInsets.only(top: 10, bottom: 10),
              //       width: 50,
              //       decoration: BoxDecoration(
              //           color: Colors.black,
              //           border: Border.all(),
              //           borderRadius: BorderRadius.circular(5)),
              //       child: Center(
              //           child: (isloading == false)
              //               ? Text(
              //                   "LOADMORE",
              //                   style: TextStyle(
              //                       fontWeight: FontWeight.bold,
              //                       color: Colors.white),
              //                 )
              //               : CircularProgressIndicator(
              //                   color: Colors.amber,
              //                 )),
              //     ),
              //   ),
              // )
            ]))
          ],
        ),
      ),
    );
  }
}
