import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart'
    as call;
import 'package:sendsms/sendsms.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = false;
  String gpsNumber;
  GlobalKey<ScaffoldState> scafKey = GlobalKey();
  bool isPressed = false;
  String language;
  @override
  void initState() {
    getLanguage();
    getGpsNumber();

    super.initState();
  }

  @override
  void dispose() {
    gpsNumber = null;
    super.dispose();
  }

  getLanguage() async {
    setState(() {
      isLoading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      language = prefs.getString("language");
    });
  }

  getGpsNumber() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      gpsNumber = prefs.getString("gpsNumber");
    });
    setState(() {
      isLoading = false;
    });
  }

  showSnackBar() {
    return scafKey.currentState.showSnackBar(SnackBar(
      content: language == "english"
          ? Text("your request has been 6sent")
          : language == "kurdi"
              ? Text(
                  "داواکاریەکەت نێردرا",
                  textDirection: TextDirection.rtl,
                )
              : Text(
                  "تم ارسال طلبك",
                  textDirection: TextDirection.rtl,
                ),
      duration: Duration(seconds: 4),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.white,
        key: scafKey,
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.only(left: 50, right: 50, top: 50),
                child: Container(
                  height: height,
                  alignment: Alignment.center,
                  child: currentWidget(height),
                ),
              ));
  }

  currentWidget(double height) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Expanded(
          child: Container(
            height: height / 3.2,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("asset/images/car png.png"),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 60,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: RaisedButton(
                  onPressed: isPressed
                      ? () {}
                      : () async {
                          String message = "#smslink#123456#";
                          setState(() {
                            isPressed = true;
                          });
                          await Sendsms.onGetPermission();

                          if (await Sendsms.hasPermission()) {
                            await Sendsms.onSendSMS(gpsNumber, message);
                          }
                          Timer(Duration(seconds: 5), () {
                            setState(() {
                              isPressed = false;
                            });
                          });
                          showSnackBar();
                        },
                  color: Color.fromRGBO(0, 126, 122, 1),
                  child: FittedBox(
                    child: language == "kurdi"
                        ? _text("شوێنی ئۆتۆمبێل")
                        : language == "arabi"
                            ? _text("موقع السیارة")
                            : _text("Car Location"),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: RaisedButton(
                  onPressed: isPressed
                      ? () {}
                      : () async {
                          await call.FlutterPhoneDirectCaller.callNumber(
                              gpsNumber);
                        },
                  color: Color.fromRGBO(0, 126, 122, 1),
                  child: FittedBox(
                    child: language == "kurdi"
                        ? _text("پەیوەندی بکە به ئۆتۆمبێل")
                        : language == "arabi"
                            ? _text("الاتصال" + " gps ")
                            : _text("Call The Car"),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: RaisedButton(
                  onPressed: isPressed
                      ? () {}
                      : () async {
                          setState(() {
                            isPressed = true;
                          });
                          String message = "#supplyoil#123456#";

                          await Sendsms.onGetPermission();

                          if (await Sendsms.hasPermission()) {
                            await Sendsms.onSendSMS(gpsNumber, message);
                          }
                          Timer(Duration(seconds: 5), () {
                            setState(() {
                              isPressed = false;
                            });
                          });
                          showSnackBar();
                        },
                  color: Color.fromRGBO(0, 126, 122, 1),
                  child: FittedBox(
                    child: language == "kurdi"
                        ? _text("هەڵکردنی ئۆتۆمبێل")
                        : language == "arabi"
                            ? _text("تشغیل السیارة")
                            : _text("Engine On"),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: RaisedButton(
                  onPressed: isPressed
                      ? () {}
                      : () async {
                          setState(() {
                            isPressed = true;
                          });
                          String message = "#stopoil#123456#";

                          await Sendsms.onGetPermission();

                          if (await Sendsms.hasPermission()) {
                            await Sendsms.onSendSMS(gpsNumber, message);
                          }
                          Timer(Duration(seconds: 5), () {
                            setState(() {
                              isPressed = false;
                            });
                          });
                          showSnackBar();
                        },
                  color: Color.fromRGBO(0, 126, 122, 1),
                  child: FittedBox(
                    child: language == "kurdi"
                        ? _text("کوژاندنەوەی ئۆتۆمبێل")
                        : language == "arabi"
                            ? _text("طفی السیارة")
                            : _text("Engine Off"),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Devloped By Raman Kanabi",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 7),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ],
    );
  }

  _text(String title) {
    return Text(
      title,
      textDirection: TextDirection.rtl,
      style: TextStyle(
        locale: Locale("AR"),
        color: Colors.white,
        fontWeight: language != "english" ? FontWeight.bold : null,
      ),
    );
  }
}
