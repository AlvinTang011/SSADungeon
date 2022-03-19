import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ssadgame/Controller/LoginController.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20);
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  LoginController LoginC = LoginController.getInstance();

  var _formKey = GlobalKey<FormState>();

  bool _showSpinner = false;
  @override
  Widget build(BuildContext context) {
    const spinkit = SpinKitRing(
      color: Colors.black,
      size: 25.0,
    );
    return MaterialApp(
        home: DefaultTabController(
      length: 2,
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Color(0xffc4c4c4),
          appBar: AppBar(
              centerTitle: true,
              title: Text('Welcome',
                  style: TextStyle(fontSize: 24, color: Colors.white, fontFamily: 'Orbitron')),
              backgroundColor: Colors.black,
              bottom: TabBar(
                  unselectedLabelColor: Colors.white,
                  labelColor: Colors.black,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    color: Colors.orange[100],
                  ),
                  tabs: [
                    Tab(
                        child: Align(
                      child: Text('Student', style: TextStyle(fontSize: 16, fontFamily: 'Orbitron')),
                    )),
                    Tab(
                        child: Align(
                      child: Text('Teacher', style: TextStyle(fontSize: 16, fontFamily: 'Orbitron')),
                    )),
                  ])),
          body: TabBarView(
            children: [
              SingleChildScrollView(
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formKey,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                      child: Column(
                        children: [
                          Image.asset('assets/SSADGAME.png', scale: 1),
                          SizedBox(height: 20),
                          TextFormField(
                              controller: email,
                              obscureText: false,
                              style: style,
                              validator: (String email) {
                                if (email.isEmpty) {
                                  return 'Email cannot be empty';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                prefixIcon:
                                    Icon(Icons.email, color: Colors.grey[450]),
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: "Email address",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32)),
                              )),
                          SizedBox(height: 10),
                          TextFormField(
                              controller: password,
                              obscureText: true,
                              style: style,
                              validator: (String password) {
                                if (password.isEmpty) {
                                  return 'Password cannot be empty';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                prefixIcon:
                                    Icon(Icons.lock, color: Colors.grey[450]),
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: "Password",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0)),
                              )),
                          SizedBox(height: 20),
                          Material(
                              elevation: 5.0,
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.blueGrey[300],
                              child: MaterialButton(
                                  minWidth: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                                  onPressed: () async {
                                    setState(() {
                                      _showSpinner = true;
                                    });
                                    LoginC.getStudentObject(email.text,
                                            password.text, "Students")
                                        .then((student) {
                                      if (student != null)
                                        Navigator.popAndPushNamed(
                                            context, '/HomePage');
                                      _showSpinner = false;
                                    });
                                  },
                                  child: _showSpinner
                                      ? spinkit
                                      : Text("Login",
                                          textAlign: TextAlign.center,
                                          style: style.copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Orbitron'
                                          )))),
                        ],
                      )),
                ),
              ),
              SingleChildScrollView(
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formKey,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                      child: Column(
                        children: [
                          Image.asset('assets/SSADGAME.png', scale: 1),
                          SizedBox(height: 20),
                          TextFormField(
                              controller: email,
                              obscureText: false,
                              style: style,
                              validator: (String email) {
                                if (email.isEmpty) {
                                  return 'Email cannot be empty';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                prefixIcon:
                                    Icon(Icons.email, color: Colors.grey[450]),
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: "Email address",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32)),
                              )),
                          SizedBox(height: 10),
                          TextFormField(
                              controller: password,
                              obscureText: true,
                              style: style,
                              validator: (String password) {
                                if (password.isEmpty) {
                                  return 'Password cannot be empty';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                prefixIcon:
                                    Icon(Icons.lock, color: Colors.grey[450]),
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: "Password",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0)),
                              )),
                          SizedBox(height: 20),
                          Material(
                              elevation: 5.0,
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.blueGrey[300],
                              child: MaterialButton(
                                  minWidth: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                                  onPressed: () async {
                                    setState(() {
                                      _showSpinner = true;
                                    });
                                    LoginC.getStudentObject(email.text,
                                            password.text, "Teachers")
                                        .then((teacher) {
                                      if (teacher != null)
                                        Navigator.popAndPushNamed(context,
                                            '/Teacher/HomePage_Teacher');
                                      setState(() {
                                        _showSpinner = false;
                                      });
                                    });
                                  },
                                  child: _showSpinner
                                      ? spinkit
                                      : Text("Login",
                                          textAlign: TextAlign.center,
                                          style: style.copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Orbitron'
                                          )))),
                        ],
                      )),
                ),
              )
            ],
          )),
    ));
  }
}
