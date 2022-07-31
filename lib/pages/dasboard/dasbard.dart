import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udmurahmotor/pages/dasboard/sidebar.dart';

import '../../service/komfirmasibayar/komfirmasi.dart';
import 'appbar.dart';
import 'dasboardstateapi.dart';
import 'usercomfir/usercomfir.dart';

class Dasbord extends StatefulWidget {
  const Dasbord({Key? key}) : super(key: key);

  @override
  State<Dasbord> createState() => _DasbordState();
}

class _DasbordState extends State<Dasbord> {
  @override
  Widget build(BuildContext context) {
    Dasboardstateapi dasboardstateapi = Get.put(Dasboardstateapi());
    dasboardstateapi.getData();
    return Scaffold(
      drawer: Sidebar(),
      appBar: dsboardappbar(context),
      body: Container(
        padding: EdgeInsets.all(5),
        child: Obx(
          () => ListView(
            children: [
              //user komfir
              Userkmfir(),
              cardcount(
                  context, dasboardstateapi.allbarang, "jumlah semua barang"),
              cardcount(context, dasboardstateapi.alluser, "jumlah semua user"),
              cardcount(context, dasboardstateapi.allterjualterkopir,
                  "barang terjual dan terkomfirmasi"),
              cardcount(context, dasboardstateapi.allterjualbelumterkopir,
                  "barang terjual dan belum terkomfirmasi")
            ],
          ),
        ),
      ),
    );
  }

  Container cardcount(BuildContext context, dasboardstateapi, title) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      margin: EdgeInsets.only(top: 30),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 20)),
          Text(
            dasboardstateapi.toString(),
            style: TextStyle(fontSize: 80),
          )
        ],
      ),
    );
  }
}
