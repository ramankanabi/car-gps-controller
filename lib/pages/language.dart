import 'package:car_gps/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChooseLanguage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 40),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Theme.of(context).primaryColor,
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString("language", "kurdi");
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (ctx) => Home()));
                  },
                  // borderSide: BorderSide(color: Theme.of(context).primaryColor),
                  child: FittedBox(
                    child: Text(
                      "کوردی",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Theme.of(context).primaryColor,
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString("language", "arabi");
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (ctx) => Home()));
                  },
                  child: FittedBox(
                    child: Text(
                      "العربیة",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Theme.of(context).primaryColor,
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString("language", "english");
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (ctx) => Home()));
                  },
                  child: FittedBox(
                    child: Text(
                      "English",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            )),
      ),
    );
  }
}
