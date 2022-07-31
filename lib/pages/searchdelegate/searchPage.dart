import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udmurahmotor/pages/searchdelegate/state.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchcontroller = TextEditingController();
  final Statesearch statesearch = Get.put(Statesearch());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: EdgeInsets.only(top: 50, left: 10, right: 10),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(children: [
            //  search heder
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 20,
              padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  color: Color.fromARGB(96, 189, 188, 188),
                  borderRadius: BorderRadius.circular(5)),
              child: Container(
                height: 35,
                // color: Colors.amber,
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  scrollPadding: EdgeInsets.all(5),
                  // cursorHeight: 30,
                  textInputAction: TextInputAction.search,
                  controller: searchcontroller,
                  onFieldSubmitted: (v) async {
                    await statesearch.getSearch(v);
                  },
                  cursorColor: Colors.black,

                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search",
                    suffixIcon: IconButton(
                        onPressed: () {
                          searchcontroller.clear();
                        },
                        icon: Icon(
                          Icons.clear,
                          color: Colors.black,
                        )),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.2,
              child: (statesearch.isLoading.isTrue)
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: statesearch.data.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/Details',
                                arguments: {
                                  "id": statesearch.data[index].id,
                                  "nama": statesearch.data[index].namabarang,
                                  "harga": statesearch.data[index].harga,
                                  "thumnails":
                                      statesearch.data[index].thumnails,
                                  "keterangan":
                                      statesearch.data[index].keterangan
                                });
                          },
                          child: Card(
                            child: ListTile(
                              leading: Image.network(
                                  "${statesearch.data[index].thumnails}"),
                              title:
                                  Text("${statesearch.data[index].namabarang}"),
                              subtitle: Text(
                                "Rp.${statesearch.data[index].harga}",
                                style: TextStyle(color: Colors.amber),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            )
          ]),
        ),
      ),
    );
  }
}
