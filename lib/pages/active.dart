import 'dart:async';

import 'package:car_gps/pages/language.dart';
import 'package:flutter/material.dart';
import 'package:sendsms/sendsms.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';

class ActivePage extends StatefulWidget {
  @override
  _ActivePageState createState() => _ActivePageState();
}

class _ActivePageState extends State<ActivePage> {
  String gpsNumber;

  String userPhoneNumber;

  GlobalKey<FormState> formKey = GlobalKey();

  _save(BuildContext context) async {
    if (!formKey.currentState.validate()) {
      return;
    }

    formKey.currentState.save();

    await gpsRef
        .document(auth.user.email)
        .collection("customer")
        .document(gpsNumber)
        .setData({
      "userId": auth.user.uid,
      "gpsNumber": gpsNumber,
      "userPhoneNumber": userPhoneNumber,
      "dateTime": DateTime.now(),
    });
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("gpsNumber", gpsNumber);

    var message = "#admin#123456#$userPhoneNumber#";

    await Sendsms.onGetPermission().then((isPermission) async {
      if (isPermission) {
        await Sendsms.onSendSMS(gpsNumber, message).then((value) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (ctx) => ChooseLanguage()));
          prefs.setBool("isLogin", true);
        });
      }
    });

    if (await Sendsms.hasPermission()) {
      Timer(Duration(seconds: 2), () async {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(50.0),
      child: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  child: FittedBox(
                    child: Text(
                      "Active Your\nGPS",
                      style: TextStyle(
                          fontSize: 40, color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: "GPS Number"),
                        validator: (val) {
                          if (val.isEmpty) {
                            return "please enter the number";
                          }
                        },
                        onSaved: (val) {
                          gpsNumber = val;
                        },
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration:
                            InputDecoration(labelText: "User Phone Number"),
                        validator: (val) {
                          if (val.isEmpty) {
                            return "please enter the number";
                          }
                        },
                        onSaved: (val) {
                          userPhoneNumber = val;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                RaisedButton(
                  onPressed: () {
                    _save(context);
                  },
                  color: Color.fromRGBO(0, 126, 122, 1),
                  child: Text(
                    "Done",
                    style: TextStyle(
                      locale: Locale("AR"),
                      color: Colors.white,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ],
            ),
          )),
    ));
  }
}
