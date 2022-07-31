import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../FuctionHelper/shared/shared.dart';

class logout extends StatelessWidget {
  const logout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var shared = Shared();

    return InkWell(
      onTap: () {
        // Navigator.pushNamed(context, "/Dasbord");
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  "tindakan ini akan mengeluarkan akun anda dari aplikasi, setelah ini anda akan di minta untuk login jika ingin berselancar di aplikasi kami,klik ok untuk melanjutkan",
                  style: TextStyle(fontSize: 10),
                ),
                content: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                            padding: EdgeInsets.fromLTRB(30, 4, 30, 4),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              "cancle",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                      InkWell(
                        onTap: () {
                          shared.remove("id");
                          shared.remove("RoltableId");
                          shared.remove("nama");
                          shared.remove("username");
                          shared.remove("email");
                          shared.remove("no_telpon");
                          shared.remove("no_wa");
                          // shared.remove("statuslogin");
                          shared.setbool("statuslogin", false);
                          // flusbartop(context, "loginsukses", Colors.green);
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/', (route) => false);
                        },
                        child: Container(
                            padding: EdgeInsets.fromLTRB(30, 4, 30, 4),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              "ok",
                              style: TextStyle(color: Colors.white),
                            )),
                      )
                    ],
                  ),
                ),
              );
            });
      },
      child: Container(
        margin: EdgeInsets.only(left: 10),
        padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.white)),
        child: Text(
          "Logout",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class dasboard extends StatelessWidget {
  const dasboard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.pushNamed(context, "/Dasbord");
        Get.toNamed("/Dasbord");
      },
      child: Container(
        margin: EdgeInsets.only(left: 10),
        padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.white)),
        child: Text(
          "Dasboard",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
