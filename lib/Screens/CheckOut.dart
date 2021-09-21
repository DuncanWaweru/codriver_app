import 'dart:convert';
import 'package:co_driver/Models/SiteVisitAppointment.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:co_driver/Models/CustomerShippingAddress.dart';
import 'package:co_driver/Models/MyProducts.dart';
import 'package:co_driver/Models/PostNewOrder.dart';
import 'package:co_driver/Models/SingleDealer.dart';
import 'package:co_driver/Repo/AppConstants.dart';
import 'package:co_driver/Repo/MakeApiCalls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class CheckOut extends StatefulWidget {
  static const String id = "CheckOut";
  final MyProducts product;

  const CheckOut({Key key, this.product}) : super(key: key);
  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  DateTime selectedDate = DateTime.now();
  String _valueChanged4 = '';
  int quantity = 1;
  double cost = 0.00;
  int currentIndex = 0;
  String currentAddress = "";
  SingleDealer singleDealer = SingleDealer();
  bool deliver = true;
  List<CustomerShippingAddress> customerShippingAddress =
      List<CustomerShippingAddress>();
  TextEditingController _controller2;
  @override
  void initState() {
    initCost();
    loadSupplierDetails();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var AutovalidateMode;
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Check Out'))),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                leading:
                    CircleAvatar(child: Text(widget.product.size.toString())),
                title: Text(widget.product.productName),
                subtitle: Text(
                    'Total Cost Ksh:' + widget.product.retailPrice.toString()),
              ),
            ),
          ),
          Divider(),
          SizedBox(
            height: 150,
            child: ListView(
              // This next line does the trick.
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                for (var item in widget.product.productImage)
                  Image.network(AppConstants.webEndpoint + item.imageFile)
              ],
            ),
          ),
          Divider(),

          ListTile(
            leading: GestureDetector(
              onTap: () {
                quantity > 0 ? quantity = quantity - 1 : quantity = quantity;
                cost = widget.product.retailPrice * quantity;
                setState(() {});
              },
              child: Icon(
                Icons.remove_circle,
                size: 40,
                color: Colors.redAccent,
              ),
            ),
            title: Row(
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Qty: ' +
                        quantity.toString() +
                        ' At Kes: ' +
                        cost.toString() +
                        '.'),
                  ),
                ),
              ],
            ),
            trailing: GestureDetector(
              onTap: () {
                quantity = quantity + 1;
                cost = widget.product.retailPrice * quantity;
                setState(() {});
              },
              child: Icon(
                Icons.add_circle,
                color: Colors.greenAccent,
                size: 40,
              ),
            ),
          ),
          Divider(),
          Card(
            elevation: 10.0,
            child: CheckboxListTile(
              title: Text('Purchase Online'),
              value: deliver,
              onChanged: (bool newValue) {
                setState(() {
                  deliver = newValue;
                });
              },
            ),
          ),
          Wrap(
            children: <Widget>[
              deliver == true?
              ListTile(
                subtitle: FlatButton.icon(
                        color: Colors.blueAccent,
                        hoverColor: Colors.blue,
                        onPressed: () {
                          submitToCart();
                        },
                        icon: Icon(Icons.add_shopping_cart),
                        label: Text('CheckOut')),
                title:
                customerShippingAddress.length > 0
                    ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: customerShippingAddress[0].shippingAddress.length,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Icon(Icons.location_on),
                            radius: 25,
                          ),
                          title: Text(customerShippingAddress[0]
                              .shippingAddress[index]
                              .region),
                          subtitle: Text(customerShippingAddress[0]
                              .shippingAddress[index]
                              .physicalAddress),
                          trailing: currentIndex != index
                              ? Icon(Icons.radio_button_unchecked)
                              : Icon(Icons.radio_button_checked),
                          selected: currentIndex != index ? false : true,
                          onTap: () {
                            currentAddress = customerShippingAddress[0]
                                .shippingAddress[index]
                                .shippingAddressId
                                .toString();
                            currentIndex = index;
                            setState(() {});
                          },
                        ),
                      ),
                    );
                  },
                )
                    : Center(
                  child: Text('Waiting for shipping Address'),
                ),
              )
                  : Wrap(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            elevation: 10.0,
                            onPressed: () {
                              DatePicker.showDateTimePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime.now(),
                                  maxTime: DateTime(2030, 12, 31, 23, 59), onChanged: (date) {
                                setState(() {
                                  selectedDate =date;
                                });

                                  }, onConfirm: (date) {

                                  }, locale: LocaleType.en);
                            },
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    selectedDate.toString().length>16?selectedDate.toString().substring(0,16)+'(tap to change)':'Select Date',
                                    style: TextStyle(
                                      fontSize: 13,

                                      color: Colors.black,
                                    ),
                                  ),
                                  Icon(
                                    Icons.event,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: FlatButton.icon(
                              onPressed: () {
                                bookAppointment();
                              },
                              color: Colors.blueAccent,
                              icon: Icon(Icons.add_shopping_cart),
                              label: Text(
                                'Get visit voucher',
                                style: TextStyle(color: Colors.black),
                              )),
                        )
                      ],
                    )
            ],
          ),
        ],
      ),
    );
  }
  void loadSupplierDetails() async {
    var response = await MakeApiCalls.makeAGetRequest('Dealers/GetDealers/' + widget.product.dealersId);
    if (response.statusCode == 200) {
      singleDealer = SingleDealer.fromJson(json.decode(response.body));
    }
    var myShippingAddress = await MakeApiCalls.makeAGetRequest('ShippingAddresses/GetShippingAddressPerCurrentCustomer');
    if (myShippingAddress.statusCode == 200) {
      var address = json.decode(myShippingAddress.body);
      print('fetching shipping address');
      print(myShippingAddress.body);
      for (var item in address) {
        var custAddress = CustomerShippingAddress.fromJson(item);
        customerShippingAddress.add(custAddress);
      }
      currentAddress = customerShippingAddress[0].shippingAddress[0].shippingAddressId;
      setState(() {
      });
    }
    setState(() {});
  }
  void initCost() {
    cost = widget.product.retailPrice;
    setState(() {});
  }
  void submitToCart() async {
    PostNewOrder postNewOrder = PostNewOrder();
    postNewOrder.customerId= customerShippingAddress[0].customerId;
    postNewOrder.quantity = quantity;
    postNewOrder.product = widget.product.productId;
    postNewOrder.shippingAddress = currentAddress;
    postNewOrder.productCost = widget.product.retailPrice;
    postNewOrder.totalCost = cost;
    var json = postNewOrder.toJson();
    var response = await MakeApiCalls.makeAPostRequest(
        'SalesOrders/PostNewSalesOrder', json);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: 'Order has been placed',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          textColor: Colors.white,
          backgroundColor: Color(0xffff256040),
          fontSize: 16.0);
    }
  }
  void bookAppointment() async {
    SiteVisitAppointment siteVisitAppointment = SiteVisitAppointment();
    siteVisitAppointment.productId = widget.product.productId;
    siteVisitAppointment.dealerId = widget.product.dealersId;
    siteVisitAppointment.customerId = customerShippingAddress[0].customerId;
    siteVisitAppointment.visitDate = selectedDate.toString();
    var json = siteVisitAppointment.toJson();
    print(json);
    var response = await MakeApiCalls.makeAPostRequest(
        'SiteVisitAppointments/PostSiteVisitAppointment', json);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: 'Appointment has been booked!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          textColor: Colors.white,
          backgroundColor: Color(0xffff256040),
          fontSize: 16.0);
    }
  }
}
