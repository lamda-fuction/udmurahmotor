import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:udmurahmotor/pages/dasboard/sidebar.dart';

import '../../../FuctionHelper/flusbar.dart';
import '../../../FuctionHelper/progres.dart';
import '../../../model/getkategoribarang.dart';
import '../../../model/getrool.dart';
import '../../../service/kategori/kategoribarang.dart';
import '../../../service/roluser.dart';
import '../appbar.dart';

class Kategoribarang extends StatefulWidget {
  const Kategoribarang({
    Key? key,
  }) : super(key: key);

  @override
  State<Kategoribarang> createState() => _KategoribarangState();
}

class _KategoribarangState extends State<Kategoribarang> {
  var rool = Roolservice();
  var kategoriservice = Kategoribarangserv();
  final textformfieldrool = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var Mediawidth = MediaQuery.of(context).size.width;
    var Mediaheight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: Sidebar(),
      appBar: dsboardappbar(context),
      body: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 20),
        // margin: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text("Buat Kategori"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: Mediawidth / 1.5,
                  height: Mediaheight / 15,
                  child: TextFormField(
                    controller: textformfieldrool,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        hintText: "Nama Kategori . . .",
                        labelText: "Nama Kategori",
                        labelStyle: TextStyle(color: Colors.black)),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (textformfieldrool.text.isNotEmpty) {
                      show(context);
                      var createroll = kategoriservice
                          .postkategori(textformfieldrool.text)
                          .then((value) {
                        if (value["mesage"] == "create data sucsess") {
                          print(value);

                          Navigator.pushReplacementNamed(
                              context, '/Kategoribarang');
                          successcreated(context);
                        } else {
                          postfaild(context);
                        }
                      });
                    } else {
                      emtyform(context);
                    }
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
            Container(
              width: Mediawidth,
              height: Mediaheight / 1.4,
              margin: EdgeInsets.only(top: 10),
              child: FutureBuilder<List<Datakategori>>(
                future: kategoriservice.getkatebarang(),
                builder: (context, snapshot) {
                  return (snapshot.hasData)
                      ? ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            var data = snapshot.data![index];
                            return Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1, color: Colors.black))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      width: Mediawidth / 2,
                                      child:
                                          Text(data.namakategori.toString())),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.update)),
                                  IconButton(
                                      onPressed: () {
                                        show(context);
                                        kategoriservice
                                            .deletekategori(data.id)
                                            .then((value) {
                                          if (value["mesage"] ==
                                              "delete data sucsess") {
                                            Navigator.pushReplacementNamed(
                                                context, '/Kategoribarang');
                                            succesdeleted(context);
                                          } else {
                                            Navigator.pushReplacementNamed(
                                                context, '/Kategoribarang');
                                            postfaild(context);
                                          }
                                        });
                                      },
                                      icon: Icon(Icons.delete))
                                ],
                              ),
                            );
                          },
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
