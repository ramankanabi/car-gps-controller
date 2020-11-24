import 'package:car_gps/pages/home.dart';
import 'package:car_gps/pages/login_page.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(CarGps());
}

class CarGps extends StatefulWidget {
  @override
  _CarGpsState createState() => _CarGpsState();
}

class _CarGpsState extends State<CarGps> {
  bool isLoggin = false;
  @override
  void initState() {
    getPrefs();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();
  }

  getPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    bool n = prefs.getBool("isLogin");
    if (n != null) {
      setState(() {
        isLoggin = n;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "GPS Controller",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromRGBO(0, 126, 122, 1),
        accentColor: Color.fromRGBO(98, 140, 255, 1),
      ),
      home: isLoggin ? Home() : LoginPage(),
    );
  }
}
