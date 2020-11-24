import 'package:car_gps/pages/active.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

final gpsRef = Firestore.instance.collection("GPS USERS");
AuthResult auth;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey();

  String email;

  String password;
  bool isLoading = false;

  signIn(BuildContext context) async {
    if (!formKey.currentState.validate()) {
      return;
    }
    setState(() {
      isLoading = true;
    });

    formKey.currentState.save();
    try {
      auth = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => ActivePage(),
        ),
      );
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool("isLogin", true);
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      String errorMessage = "";

      if (e.message.toString().contains(
          "The password is invalid or the user does not have a password")) {
        setState(() {
          errorMessage = "The Password is wrong ";
        });
      } else if (e.message.toString().contains(
          "There is no user record corresponding to this identifier. The user may have been deleted.")) {
        setState(() {
          errorMessage = "Could not find a user with that email";
        });
      } else if (e.message
          .toString()
          .contains("The user account has been disabled by an administrator")) {
        setState(() {
          errorMessage = "The user has been disabled";
        });
      } else {
        errorMessage = "Failed";
      }
      _showErrorDialog(errorMessage);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(50.0),
              child: Form(
                key: formKey,
                child: Container(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            child: FittedBox(
                              // fit: BoxFit.contain,
                              child: Text(
                                "WELCOME\nBACK !",
                                style: TextStyle(
                                  color: Color.fromRGBO(0, 126, 122, 1),
                                  fontSize: 40,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 40),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: "E-Mail",
                            ),
                            validator: (val) {
                              if (val.isEmpty) {
                                return "enter the E-Mail .";
                              }
                            },
                            onSaved: (val) {
                              email = val.trim();
                            },
                          ),
                          TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "Password",
                            ),
                            validator: (val) {
                              if (val.isEmpty) {
                                return "enter the password .";
                              }
                            },
                            onSaved: (val) {
                              password = val;
                            },
                          ),
                          SizedBox(height: 40),
                          RaisedButton(
                            onPressed: () {
                              signIn(context);
                            },
                            color: Color.fromRGBO(0, 126, 122, 1),
                            child: Text(
                              "LOGIN",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
            ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text("Failed"),
              content: Text(message),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text("OKEY"))
              ],
            ));
  }
}
