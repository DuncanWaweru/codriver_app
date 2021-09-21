import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:co_driver/Models/ShippingAddress.dart';
import 'package:co_driver/MyWidgets/MyWidgets.dart';
import 'package:co_driver/Repo/MakeApiCalls.dart';
import 'package:flutter/material.dart';
class AddShippingAddress extends StatefulWidget {
  static const String id = 'AddShippingAddress';
  final String customerId;
  final String customerName;

  const AddShippingAddress({Key key, this.customerId, this.customerName}) : super(key: key);
  @override
  _AddShippingAddressState createState() => _AddShippingAddressState();
}
var _formKey = GlobalKey<FormState>();
class _AddShippingAddressState extends State<AddShippingAddress> {
  List<ShippingAddress> addresses = List<ShippingAddress>();
  bool submitingForm = false;
  TextEditingController cityController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();

  @override
  void initState() {
    loadMyAddresses();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.customerName+' Shipping Address'),),
      body: Column(

        children: [
          Form(
            key: _formKey,
            child: Card(
              elevation: 10.0,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                   child:
                   Wrap(
                     children: <Widget>[
                       TextFormField(
                         controller: cityController,
                         keyboardType: TextInputType.text,
                         style: TextStyle(color: Colors.black),
                         validator: (String value) {
                           if (value.isEmpty) {
                             return 'Please enter nearest city';
                           }
                         },
                         decoration: MyWidgets.buildInputDecoration(
                             'Enter nearest city',
                             'Nearest city',
                             Icon(Icons.location_city)),
                       ),
                       Divider(),
                       TextFormField(
                         controller: addressController,
                         keyboardType: TextInputType.multiline,
                         minLines: 3,//Normal textInputField will be displayed
                         maxLines: 5,
                         style: TextStyle(color: Colors.black),
                         validator: (String value) {
                           if (value.isEmpty) {
                             return 'Detailed Physical Address';
                           }
                         },
                         decoration: MyWidgets.buildInputDecoration(
                             'Detailed Physical Address',
                             'Physical Address',
                             Icon(Icons.location_on)),
                       ),
                     ],
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
                              postShippingAddress();
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
                          'Add Shipping Address',
                        ),
                      ):
                      MyWidgets.loadingButton(),
                    ),
                  ),
                ],
              )
              ,
            ),
          ),
          Divider(),
          Card(
            elevation: 10.0,
            child:  addresses.length == 0
                ? Center(
              child: Text('No Data To Display'),
            )
                : Column(
              children: <Widget>[
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: addresses.length,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          leading: CircleAvatar(child: Icon(Icons.location_on),radius: 25,),
                          title: Text(addresses[index].region),
                          subtitle: Text(addresses[index].physicalAddress),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void postShippingAddress() async{
    ShippingAddress dealer = ShippingAddress(customerId: widget.customerId,region: cityController.text,physicalAddress:addressController.text );
    var userData = dealer.toJson();
    var response = await  MakeApiCalls.makeAPostRequest('ShippingAddresses/PostShippingAddress',userData);
    var jsonData = json.decode(response.body);
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
      cityController.clear();
      addressController.clear();
    loadMyAddresses();

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

  void loadMyAddresses()async {
    addresses.clear();
    var response = await MakeApiCalls.makeAGetRequest('ShippingAddresses/GetShippingAddressPerCustomer/'+widget.customerId);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      for (var item in jsonData) {
        ShippingAddress address = ShippingAddress();
        address = ShippingAddress.fromJson(item);
        addresses.add(address);
      }
    }
    setState(() {

    });
  }
  }

