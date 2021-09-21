import 'package:co_driver/MyWidgets/MyWidgets.dart';
import 'package:co_driver/Screens/StartPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:co_driver/Models/LoginResponse.dart';
import 'package:co_driver/Models/UserLogin.dart';
import 'package:co_driver/Repo/GetSharedPrefs.dart';
import 'package:co_driver/Repo/MakeApiCalls.dart';
import 'dart:async';
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  static const String id = 'LoginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

TextEditingController passwordController = new TextEditingController();
TextEditingController emailController = new TextEditingController();
var _formKey = GlobalKey<FormState>();
bool submitingForm = false;

class _LoginScreenState extends State<LoginScreen> {
  Duration get loginTime => Duration(milliseconds: 2250);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blueAccent,
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  CircleAvatar(
                    child: Image.asset('assets/images/logo.png',
                        fit: BoxFit.contain, height: 200, width: 200),
                    radius: 60,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Co-Driver',
                    style: TextStyle(fontSize: 36),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Card(
                      elevation: 30,
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 16.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(color: Colors.black),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Please enter your Phone Number';
                                }
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                hintText: 'Enter your Phone Number',
                                labelText: 'Phone Number',
                                hintStyle: TextStyle(color: Colors.grey),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32.0)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.lightBlueAccent,
                                      width: 1.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32.0)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.lightBlueAccent,
                                      width: 2.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32.0)),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: passwordController,
                              keyboardType: TextInputType.emailAddress,
                              obscureText: true,
                              style: TextStyle(color: Colors.black),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  // ignore: missing_return
                                  return 'Please enter a password';
                                }
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock),
                                hintText: 'Enter your password.',
                                labelText: 'Password',
                                hintStyle: TextStyle(color: Colors.grey),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32.0)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.lightBlueAccent,
                                      width: 1.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32.0)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.lightBlueAccent,
                                      width: 2.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32.0)),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Material(
                              color: Colors.blueAccent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                              elevation: 5.0,
                              child: submitingForm==false
                                  ? MaterialButton(
                                      onPressed: () {
                                        if (_formKey.currentState.validate()) {
                                          var email = emailController.text;
                                          var password =
                                              passwordController.text;

                                          //Implement login functionality.

                                          setState(() {
                                            submitingForm = true;
                                          });
                                          try{
                                            _authUser();
                                          }
                                          catch(Exception){
                                            setState(() {
                                              submitingForm = false;
                                            });

                                          }

                                        }
                                      },
                                      minWidth: 200.0,
                                      height: 42.0,
                                      child: Text(
                                        'Log In',
                                      ),
                                    )
                                  : MyWidgets.loadingButton(),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Material(
                              child: MaterialButton(
                                onPressed: () {
                                  ///TODO: add Forgot password functionality
                                },
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.blueAccent),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _authUser() async {
    UserLogin userLogin = UserLogin();
    userLogin.username=emailController.text;
    userLogin.password = passwordController.text;
    var userData = userLogin.toJson();

    var response =
        await MakeApiCalls.makeAPostRequest('auth/login', userData);
    var jsonData = json.decode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      //set shared Preferences
      LoginResponse loginResponse = LoginResponse.fromJson(jsonData);
      GetSharedPrefs.setNamePreference('access_token', loginResponse.token);
      GetSharedPrefs.setNamePreference('username', loginResponse.userName);
      Navigator.popAndPushNamed(context, StartPage.id);
    } else {
      Fluttertoast.showToast(
          msg: 'An error occurred',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          textColor: Colors.white,
          backgroundColor: Color(0xffff990000),
          fontSize: 16.0);
    }
    setState(() {
      submitingForm = false;
    });
  }
}
