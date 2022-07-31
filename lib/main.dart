// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udmurahmotor/pages/Detail/detail.dart';
import 'package:udmurahmotor/pages/Login/login.dart';
import 'package:udmurahmotor/pages/cart/cart.dart';
import 'package:udmurahmotor/pages/dasboard/dasbard.dart';
import 'package:udmurahmotor/pages/dasboard/rol/rool.dart';
import 'package:udmurahmotor/pages/kategori/kategori.dart';
import 'package:udmurahmotor/pages/mainpage.dart';
import 'package:udmurahmotor/pages/searchdelegate/searchPage.dart';

import 'pages/Login/cekstatuslogin.dart';
import 'pages/Profile/profile.dart';
import 'pages/Register/register.dart';
import 'pages/dasboard/barang/barang.dart';
import 'pages/dasboard/barangdisetujui/orderdisetujuidasboard.dart';
import 'pages/dasboard/kategoribarang/kategribar.dart';
import 'pages/dasboard/komfirmasibayar/komfirmasi.dart';
import 'pages/dasboard/orderdasboard/orderdasboard.dart';
import 'pages/dasboard/user/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const Cekstatuslogin(),
        '/Mainpage': (context) => const Mainpage(),
        // '/Detail': (context) => const Detail(),
      },
      onGenerateRoute: (RouteSettings settings) {
        var routename = settings.name;
        switch (routename) {
          case '/search':
            return MaterialPageRoute(builder: (_) => SearchPage());
          case '/Login':
            return MaterialPageRoute(builder: (_) => Login());
          case '/Dasbord':
            return MaterialPageRoute(builder: (_) => Dasbord());
          case '/Orderdasboard':
            return MaterialPageRoute(builder: (_) => Orderdatboard());
          case '/disetui':
            return MaterialPageRoute(builder: (_) => Orderdisetujui());
          case '/profile':
            return MaterialPageRoute(builder: (_) => Profile());
          case '/Kategori':
            return MaterialPageRoute(
                builder: (_) => Kategori(
                      params: settings.arguments,
                    ));
          case '/Cart':
            return MaterialPageRoute(builder: (_) => Cart());
          case '/Details':
            return MaterialPageRoute(
                builder: (_) => Detail(
                      params: settings.arguments,
                    ));
          case '/Rool':
            return MaterialPageRoute(builder: (_) => Rool());
          case '/Komfirmasi':
            return MaterialPageRoute(builder: (_) => Komfirmasi());
          case '/Barang':
            return MaterialPageRoute(builder: (_) => Barang());
          case '/Usermanage':
            return MaterialPageRoute(builder: (_) => Usermanage());
          case '/Kategoribarang':
            return MaterialPageRoute(builder: (_) => Kategoribarang());
          case "/Register":
            return MaterialPageRoute(builder: (_) => Register());
        }
      },
    );
  }
}
