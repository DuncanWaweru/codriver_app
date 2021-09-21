import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:co_driver/Models/Dealer.dart';
import 'package:co_driver/MyWidgets/MyWidgets.dart';
import 'package:co_driver/Repo/MakeApiCalls.dart';
import 'package:flutter/material.dart';

import 'AddProducts.dart';
class AddDealer extends StatefulWidget {
  static const String id = 'AddDealer';
  @override
  _AddDealerState createState() => _AddDealerState();
}
var _formKey = GlobalKey<FormState>();
class _AddDealerState extends State<AddDealer> {
  TextEditingController dealerName = new TextEditingController();
  TextEditingController dealerAddress = new TextEditingController();
  TextEditingController dealerEmail = new TextEditingController();
  TextEditingController dealerPhone = new TextEditingController();
  bool submitingForm = false;

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add A new Dealer'),),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Card(
            elevation: 10.0,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(

                    controller: dealerName,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.black),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter a name';
                      }
                    },
                    decoration: MyWidgets.buildInputDecoration ('Enter Dealers Name','Dealer Name',Icon(Icons.person)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(

                    controller: dealerPhone,
                    keyboardType: TextInputType.phone,
                    style: TextStyle(color: Colors.black),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter your Phone Number';
                      }
                    },
                    decoration: MyWidgets.buildInputDecoration ('Enter Phone Number','Phone Number',Icon(Icons.phone)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(

                    controller: dealerEmail,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.black),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter an Email Address';
                      }
                    },
                    decoration: MyWidgets.buildInputDecoration ('Enter Email Address','Email Address',Icon(Icons.alternate_email)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(

                    controller: dealerAddress,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.black),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter an address';
                      }
                    },
                    decoration: MyWidgets.buildInputDecoration ('Enter an Address','Physical Address',Icon(Icons.person)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    elevation: 5.0,
                    child:submitingForm ==false?
                    MaterialButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {

                          setState(() {
                            submitingForm=true;
                          });

                          try{
                            addDealer();
                          }
                          catch(Exception){

                            setState(() {
                              submitingForm=false;
                            });
                          }

                        }
                      },
                      minWidth: 200.0,
                      height: 42.0,
                      child:Text(
                        'Add Dealer',
                      ),
                    ):
                    MyWidgets.loadingButton(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addDealer() async {
    Dealer dealer = Dealer(dealerName.text,dealerAddress.text,dealerPhone.text,dealerEmail.text);
    var userData = dealer.toJson();
    var response = await  MakeApiCalls.makeAPostRequest('Dealers/PostDealers',userData);
    var jsonData = json.decode(response.body);
    print(jsonData);
    if(response.statusCode == 200||response.statusCode==201){
      //set shared Preferences
      Fluttertoast.showToast(
          msg: 'Dealer Added successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          textColor: Colors.white,
          backgroundColor: Color(0xffff256040),
          fontSize: 16.0);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddProducts(
           dealerId: jsonData[0].toString(),
          ),
        ),
      );

    }
    else{
      Fluttertoast.showToast(
          msg: 'An error occured',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          textColor: Colors.white,
          backgroundColor: Color(0xffffc2261b),
          fontSize: 16.0);
    }
    setState(() {
      submitingForm=false;
    });
  }
}
