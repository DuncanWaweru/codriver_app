import 'dart:convert';
import 'package:co_driver/Models/TyreSizes.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:co_driver/Models/Products.dart';
import 'package:co_driver/MyWidgets/MyWidgets.dart';
import 'package:co_driver/Repo/MakeApiCalls.dart';
import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';

import 'ProductImages.dart';

class AddProducts extends StatefulWidget {
  static const String id = 'AddProducts';
  final String dealerId;

  AddProducts({Key key, @required this.dealerId}) : super(key: key);
  @override
  _AddProductsState createState() => _AddProductsState();
}

var _formKey = GlobalKey<FormState>();
List<String> _categories = ["Tyres", "Batteries", "Others"];
String selectedCategory = 'Tyres';
List<String> tyreSizes = TyreSizes.tyreSizes;
String selectedSize = '14';
bool available = true;

class _AddProductsState extends State<AddProducts> {
  TextEditingController productName = new TextEditingController();
  TextEditingController retailPrice = new TextEditingController();
  TextEditingController wholesalePrice = new TextEditingController();
  bool submitingForm = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add product'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Card(
            elevation: 10.0,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RadioGroup<String>.builder(
                    direction: Axis.horizontal,
                    groupValue: selectedCategory,
                    onChanged: (value) => setState(() {
                      selectedCategory = value;
                    }),
                    items: _categories,
                    itemBuilder: (item) => RadioButtonBuilder(
                      item,
                    ),
                  ),
                ),
                Padding(

                  padding: const EdgeInsets.fromLTRB(12,8.0,12,8),
                  child: DropDown<String>(

                    isExpanded: true,
                    items: tyreSizes,
                    initialValue: selectedSize,
                    hint: Text("Select Size"),
                    onChanged: (String size) {
                      setState(() {
                        selectedSize = size;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: productName,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.black),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter a Name';
                      }
                    },
                    decoration: MyWidgets.buildInputDecoration(
                        'Enter Product Name',
                        'Product Name',
                        Icon(Icons.nature)),
                  ),
                ),
                Wrap(
                  children: <Widget>[
                    TextFormField(
                      controller: retailPrice,
                      keyboardType: TextInputType.phone,
                      style: TextStyle(color: Colors.black),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter retail Price';
                        }
                      },
                      decoration: MyWidgets.buildInputDecoration(
                          'Enter Retail Price',
                          'Retail Price',
                          Icon(Icons.attach_money)),
                    ),
                    TextFormField(
                      controller: wholesalePrice,
                      keyboardType: TextInputType.phone,
                      style: TextStyle(color: Colors.black),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter wholesale price';
                        }
                      },
                      decoration: MyWidgets.buildInputDecoration(
                          'Enter Wholesale',
                          'Wholesale price',
                          Icon(Icons.attach_money)),
                    ),
                  ],
                ),
                Wrap(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,16,0,0),
                    child: Text('Available'),
                  ),
                  Checkbox(
                    value: available,
                    onChanged: (bool newValue) {
                      setState(() {
                        available = newValue;
                      });
                    },
                  ),
                ]),
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
                            addProduct();
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
                        'Add Product',
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
  Future<void> addProduct() async {
    Products dealer = Products(selectedCategory,selectedSize,productName.text,wholesalePrice.text,retailPrice.text,available.toString(),widget.dealerId);
    var userData = dealer.toJson();
    var response = await  MakeApiCalls.makeAPostRequest('Products/PostProduct',userData);
    var jsonData = json.decode(response.body);
    print(jsonData);
    if(response.statusCode == 200||response.statusCode==201){
      //set shared Preferences
      Fluttertoast.showToast(
          msg: 'Product Added successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          textColor: Colors.white,
          backgroundColor: Color(0xffff256040),
          fontSize: 16.0);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductImages(
            productId: jsonData[0].toString(),
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
