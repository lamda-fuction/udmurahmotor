import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:udmurahmotor/model/getorderbystatus_and%20_userid.dart';
import 'package:udmurahmotor/pages/Profile/kompirmasi.dart';
import 'package:udmurahmotor/pages/Profile/statevariable.dart';
import 'package:udmurahmotor/pages/Profile/wigetfuction.dart';

import '../../FuctionHelper/shared/shared.dart';
import '../../service/order/getorder.dart';
import '../../service/user/updatepotouser.dart';
import 'bayar.dart';
import 'carddiseujui.dart';

import 'cardmenunggupersetujuan.dart';
import 'dataprofileuserstateservice.dart';
import 'kompirmasiState.dart';
import 'urllauch.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // final Statevariable statevariable = Get.put(Statevariable());
  var getorder = Getorder();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DataUser(),
            Orderan(getorder: getorder),
          ],
        ),
      ),
    );
  }
}

class Orderan extends StatelessWidget {
  const Orderan({
    Key? key,
    required this.getorder,
  }) : super(key: key);

  final Getorder getorder;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 5,
        child: DefaultTabController(
          initialIndex: 0,
          length: 3,
          child: Container(
            // height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                tabartitle(),
                Container(
                  height: MediaQuery.of(context).size.height / 1.7,
                  child: TabBarView(children: <Widget>[
                    //tabarview1
                    Container(
                        child: FutureBuilder<List<Dataorder>>(
                      future: getorder.getorder(2),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              final d = snapshot.data?[index];
                              return Menugupersetujuan(
                                data: snapshot.data?[index],
                              );
                            },
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.amber,
                            ),
                          );
                        }
                      },
                    )),
                    //tabarview2
                    Container(
                        // height: MediaQuery.of(context).size.height / 1.4,
                        // color: Colors.amber,
                        child: FutureBuilder<List<Dataorder>>(
                      future: getorder.getorder(3),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              final d = snapshot.data?[index];
                              return Disetujui(
                                data: snapshot.data![index],
                              );
                            },
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.amber,
                            ),
                          );
                        }
                      },
                    )),
                    //tabarview3
                    Container(
                        padding: EdgeInsets.only(top: 5), child: Kompimasi())
                  ]),
                )
              ],
            ),
          ),
        ));
  }

  Container tabartitle() {
    return Container(
      child: TabBar(
        labelColor: Colors.black,
        unselectedLabelColor: Colors.black,
        indicatorColor: Colors.amber,
        tabs: [
          Tab(
            text: "orderan saya",
          ),
          Tab(
            text: "Disetujui",
          ),
          Tab(
            text: "konfirmasi",
          )
        ],
      ),
    );
  }
}

class DataUser extends StatefulWidget {
  const DataUser({
    Key? key,
  }) : super(key: key);

  @override
  State<DataUser> createState() => _DataUserState();
}

class _DataUserState extends State<DataUser> {
  Shared shared = Shared();
  var nama = "";
  var username = "";
  var email = "";
  var nomer = "";
  var id;

  getshered() async {
    nama = await shared.getstring("nama");
    email = await shared.getstring("email");
    username = await shared.getstring("username");
    nomer = await shared.getstring("no_telpon");
    id = await shared.getint("id");
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getshered();
  }

  @override
  Widget build(BuildContext context) {
    Dataprofileuserservice dataprofileuserservice =
        Get.put(Dataprofileuserservice());
    dataprofileuserservice.getuserdata();
    Postpotobprofile postpotobprofile = Postpotobprofile();
    return Obx(
      () => Expanded(
          flex: 2,
          child: Container(
            color: Colors.black,
            child: Container(
              margin: EdgeInsets.only(
                left: 10,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      dataprofileuserservice.userpoto.toString(),
                    ),
                    radius: 40,
                    child: Container(
                      alignment: Alignment.bottomRight,
                      child: CircleAvatar(
                          backgroundColor: Color.fromARGB(0, 255, 193, 7),
                          radius: 15,
                          child: IconButton(
                              color: Colors.white,
                              iconSize: 30,
                              onPressed: () async {
                                print("object");
                                Shared shared = Shared();
                                var iduser = await shared.getint("id");
                                final ImagePicker _picker = ImagePicker();
                                final XFile? image = await _picker.pickImage(
                                    source: ImageSource.gallery);
                                if (image != null) {
                                  postpotobprofile
                                      .postfrofile(iduser, image)
                                      .then((value) {
                                    if (value["mesage"] ==
                                        "update data sucsess") {
                                      dataprofileuserservice.getuserdata();
                                    }
                                  });
                                }
                              },
                              icon: Icon(
                                Icons.camera,
                              ))),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.4,
                    margin: EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // margin: EdgeInsets.only(right: 1),
                          width: MediaQuery.of(context).size.width / 1.3,
                          child: Text(
                            nama,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  top: 5, bottom: 5, left: 10, right: 10),
                              decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                "member",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            dasboard(),
                            logout(),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          username,
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          email,
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          nomer,
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
