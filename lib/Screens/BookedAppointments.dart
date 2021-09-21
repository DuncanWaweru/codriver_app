import 'dart:convert';

import 'package:co_driver/Models/MyAppointments.dart';
import 'package:co_driver/Models/MyProducts.dart';
import 'package:co_driver/Repo/MakeApiCalls.dart';
import 'package:flutter/material.dart';

class BookedAppointments extends StatefulWidget {
  static const String id = "BookedAppointments";
  @override
  _BookedAppointmentsState createState() => _BookedAppointmentsState();
}

class _BookedAppointmentsState extends State<BookedAppointments> {
  List<MyAppointments> myAppointments = List<MyAppointments>();
  bool hasLoaded = false;
  @override
  void initState() {
    loadBookedAppointments();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Booked Appointments'),),
      body: hasLoaded == false
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Column(
        children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
            itemCount: myAppointments.length,
            itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    onTap: () {

                    },

                    title: Text('Customer Name: '+myAppointments[index].customer.name),
                    subtitle: Column(
                      children: <Widget>[
                        Text('Booked on: '+myAppointments[index].visitDate),
                        Text('Dealer: '+myAppointments[index].dealers.dealerName,),
                      ],
                    ),

                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  void loadBookedAppointments() async{

    var response = await MakeApiCalls.makeAGetRequest('SiteVisitAppointments/GetSiteVisitAppointment' );
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      for (var item in jsonData) {
        MyAppointments products = MyAppointments();
        products = MyAppointments.fromJson(item);
        myAppointments.add(products);
      }
    }
    hasLoaded=true;
    setState(() {

    });
  }
}
