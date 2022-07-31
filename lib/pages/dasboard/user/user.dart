import 'package:flutter/material.dart';
import 'package:udmurahmotor/FuctionHelper/flusbar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../../../model/getalluser.dart';
import '../../../model/getoneuser.dart';
import '../../../model/getrool.dart';
import '../../../service/roluser.dart';
import '../../../service/user/user.dart';

class Usermanage extends StatefulWidget {
  const Usermanage({Key? key}) : super(key: key);

  @override
  State<Usermanage> createState() => _UsermanageState();
}

class _UsermanageState extends State<Usermanage> {
  final searcktexfielecontroller = TextEditingController();
  bool ischeck = false;
  var userserv = Userservice();
  var rool = Roolservice();

  List<Userdatall> userdata = [];
  List<Userdatone> datauserone = [];
  _getuserby(user) {
    userserv.getuserby(user).then((value) {
      if (value.mesage == "All Data User") {
        // print(value.data?.nama);
        datauserone.clear();
        setState(() {
          datauserone.add(value.data as Userdatone);
        });
      } else {
        print(value);
        flusbartop(context, "tidak di temukan", Colors.amber);
      }
    });
  }

  _getuser() {
    userserv.getuserall().then((value) {
      if (value.mesage == "All Data User") {
        value.data?.forEach((v) {
          setState(() {
            userdata.add(v);
          });
        });
      }
    });
  }

  String? selectedValue;
  List<Datarool> items = [];

  _getrool() {
    rool.getrool().then((value) {
      if (value.isNotEmpty) {
        value.forEach((v) {
          setState(() {
            items.add(v);
          });
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getuser();
    _getrool();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.black,
          pinned: true,
          title: Row(children: [
            Container(
              width: MediaQuery.of(context).size.width / 1.5,
              height: MediaQuery.of(context).size.height / 19,
              child: TextFormField(
                controller: searcktexfielecontroller,
                // controller: textformfieldrool,
                style: TextStyle(color: Colors.white, fontSize: 15),
                onChanged: (v) {
                  if (searcktexfielecontroller.text.isEmpty) {
                    setState(() {
                      datauserone.clear();
                    });
                  }
                },
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          if (searcktexfielecontroller.text.isNotEmpty) {
                            _getuserby(searcktexfielecontroller.text);
                          }
                        },
                        icon: Icon(
                          Icons.search,
                          color: Colors.white,
                        )),
                    suffixStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    fillColor: Colors.white,
                    hintText: "Username atau email",
                    hintStyle: TextStyle(color: Colors.white),
                    labelText: "cari",
                    labelStyle: TextStyle(color: Colors.white)),
              ),
            ),
          ]),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return (datauserone.isEmpty)
              ? carduser(context, index, userdata, Colors.white)
              : carduser(context, index, datauserone,
                  Color.fromARGB(255, 255, 255, 255));
        },
                // childCount: userdata.length
                childCount: (datauserone.isEmpty)
                    ? userdata.length
                    : datauserone.length))
      ],
    ));
  }

  Container carduser(BuildContext context, int index, data, color) {
    return Container(
      // height: MediaQuery.of(context).size.height / 7,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 5, right: 5, left: 5),
      decoration: BoxDecoration(
          color: color,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black45))),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            // width: MediaQuery.of(context).size.width / 2.3,
            margin: EdgeInsets.only(right: 5, left: 5),
            child: Row(
              children: [
                CircleAvatar(
                    backgroundColor: Colors.black12,
                    backgroundImage: (data[index].poto != null)
                        ? NetworkImage(data[index].poto.toString())
                        : NetworkImage("")),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  width: MediaQuery.of(context).size.width / 5,
                  child: Text("wahyu anugrah"),
                ),
              ],
            ),
          ),

          // Text("isadmin"),
          roolwiget(MediaQuery.of(context).size.width, data[index].RoltableId,
              data[index].id),
          // InkWell(
          //   onTap: () {},
          //   child: Container(
          //       padding: EdgeInsets.all(5),
          //       decoration: BoxDecoration(
          //           color: Colors.amber,
          //           borderRadius: BorderRadius.circular(10)),
          //       child: Text("toadmin")),
          // ),
          // IconButton(onPressed: () {}, icon: Icon(Icons.create)),
          // IconButton(onPressed: () {}, icon: Icon(Icons.delete_outline))
        ],
      ),
    );
  }

  Container roolwiget(double Mediaqueriheight, rolnow, id) {
    return (items.isEmpty)
        ? Container()
        : Container(
            // padding: EdgeInsets.all(0),
            // margin: EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
                border: Border.all(), borderRadius: BorderRadius.circular(5)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                isExpanded: true,
                hint: Row(
                  children: const [
                    // Icon(
                    //   Icons.list,
                    //   size: 16,
                    //   color: Colors.black,
                    // ),
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(
                        child: Text(
                      "pilih roll",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    )),
                  ],
                ),
                items: items
                    .map((item) => DropdownMenuItem<String>(
                          value: item.id.toString(),
                          // value: rolnow.toString(),
                          child: Text(
                            item.rolname.toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                    .toList(),
                // value: selectedValue,
                value:
                    (selectedValue == null) ? rolnow.toString() : selectedValue,
                onChanged: (value) {
                  setState(() {
                    selectedValue = value as String;
                    print(selectedValue);
                    userserv.updateuserrol(id, selectedValue).then((value) {
                      print(value);
                      if (value["mesage"] == "update data sucsess") {
                        flusbartop(context, "update rool sukses", Colors.green);
                      } else {
                        flusbartop(context, "gagal update rool", Colors.amber);
                      }
                    });
                  });
                },
                // icon: const Icon(
                //   Icons.arrow_forward_ios_outlined,
                // ),
                iconSize: 14,
                iconEnabledColor: Colors.black,
                iconDisabledColor: Colors.grey,
                buttonHeight: Mediaqueriheight / 15,
                buttonWidth: 110,
                buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                buttonDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Colors.black26,
                  ),
                  // color: Colors.redAccent,
                ),
                // buttonElevation: 2,
                itemHeight: 40,
                itemPadding: const EdgeInsets.only(left: 14, right: 14),
                dropdownMaxHeight: Mediaqueriheight / 4.5,
                // dropdownWidth: 250,
                // dropdownPadding: EdgeInsets.all(5),
                dropdownDecoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(5),
                  // color: Colors.redAccent,
                ),
                dropdownElevation: 0,
                scrollbarRadius: const Radius.circular(2),
                scrollbarThickness: 6,
                scrollbarAlwaysShow: true,
                // offset: const Offset(-10, 0),
              ),
            ),
          );
  }
}
