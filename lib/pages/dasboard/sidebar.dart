import 'package:flutter/material.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  Widget build(BuildContext context) {
    var Mediawidth = MediaQuery.of(context).size.width;
    var Mediaheight = MediaQuery.of(context).size.height;
    return Drawer(
      child: ListView(
        children: [
          Container(
            color: Colors.black,
            height: Mediaheight / 5,
            child: Column(
              children: [
                Container(
                  height: Mediaheight / 13,
                  // color: Colors.indigo,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: Mediawidth / 1.8,
                        // color: Colors.amber,
                        child: Center(
                          child: Text(
                            "UD MM",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.white,
                          )),
                      // menu
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/Dasbord");
                  },
                  child: Container(
                    child: ListTile(
                      title: Text("Dasboard"),
                      leading: Icon(Icons.dashboard_customize_outlined),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/Orderdasboard');
                  },
                  child: Container(
                    child: ListTile(
                      title: Text("Order"),
                      leading: Icon(Icons.handshake),
                    ),
                  ),
                ),
                Container(
                  child: ExpansionTile(
                    // expandedAlignment: Alignment.topRight,
                    textColor: Colors.amber,
                    iconColor: Colors.amber,
                    title: Text("menejemen"),
                    leading: Icon(Icons.manage_accounts_rounded),
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/Usermanage');
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 20),
                          child: ListTile(
                            leading: Icon(Icons.person),
                            title: Text("user"),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/Barang");
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 20),
                          child: ListTile(
                            leading: Icon(Icons.motorcycle_outlined),
                            title: Text("barang"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/disetui");
                  },
                  child: Container(
                    child: ListTile(
                        title: Text("Diserujui"),
                        leading: Icon(
                          Icons.check_circle,
                        )),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/Kategoribarang");
                  },
                  child: Container(
                    child: ListTile(
                        title: Text("Kategoribarang"),
                        leading: Icon(Icons.category)),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/Komfirmasi");
                  },
                  child: Container(
                    child: ListTile(
                        title: Text("kontak"), leading: Icon(Icons.category)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
