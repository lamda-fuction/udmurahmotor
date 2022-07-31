import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../FuctionHelper/appbar.dart';
import '../../FuctionHelper/costumlisitem.dart';
import 'stateapihistory.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    var Mediaquerywidth = MediaQuery.of(context).size.width;
    var Mediaqueryhight = MediaQuery.of(context).size.height;
    Steapihistory instance = Get.put(Steapihistory());
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      instance.getapi();
    });
    return Scaffold(
        // appBar: appbar(context, Mediaquerywidth, Mediaqueryhight, false),
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("history pembelian anda"),
        ),
        body: Container(
          margin: EdgeInsets.only(left: 11, right: 10),
          child: Obx(
            () => (instance.isLoading.isTrue)
                ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.amber,
                    ),
                  )
                : ListView.builder(
                    itemCount: instance.lisdata.length,
                    itemBuilder: (context, index) {
                      // String image = d?.thumnails as String;
                      return InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/Details");
                          },
                          child: Card(
                            child: ListTile(
                              subtitle: Text(
                                  "Rp.${instance.lisdata[index].barang?.harga}"),
                              title: Text(instance
                                  .lisdata[index].barang!.namabarang
                                  .toString()),
                              leading: Image.network(instance
                                  .lisdata[index].barang!.thumnails
                                  .toString()),
                            ),
                          ));
                    }),
          ),
        ));
  }
}
