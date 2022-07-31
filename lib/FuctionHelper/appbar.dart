import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppBar appbar(BuildContext context, double Mediaquerywidth,
    double Mediaqueryhight, bool iscart) {
  return AppBar(
    automaticallyImplyLeading: false,
    elevation: 0,
    backgroundColor: Colors.white,
    title: Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            // onTap: () => showSearch(context: context, delegate: Search()),
            onTap: () => Get.toNamed("/search"),
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
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  )),
            ),
          ),
          (iscart == true)
              ? IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.person_sharp,
                    color: Colors.black,
                    size: 30,
                  ))
              : IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/Cart");
                  },
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    size: 40,
                    color: Colors.black,
                  ))
        ],
      ),
    ),
  );
}
