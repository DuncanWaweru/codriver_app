import 'dart:convert';

import 'package:co_driver/Models/DealersList.dart';
import 'package:co_driver/Repo/MakeApiCalls.dart';
import 'package:flutter/material.dart';

import 'DealerLocation.dart';
import 'DealersProducts.dart';

class AllDealers extends StatefulWidget {
  static const String id = 'AllDealers';
  @override
  _AllDealersState createState() => _AllDealersState();
}

class _AllDealersState extends State<AllDealers> {
  List<DealersList> dealers = List<DealersList>();
  var hasLoaded = false;
  @override
  void initState() {
    loadAllDealers();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Dealers'),
      ),
      body: hasLoaded == false
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: <Widget>[
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: dealers.length,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          onTap: () {

                          },
                          leading: GestureDetector(child: Icon(Icons.location_on),onTap: (){ addLocation(dealers[index].dealersId,
                              dealers[index].dealerName);},),
                          title: Text(dealers[index].dealerName),
                          subtitle: Text(dealers[index].address),
                          trailing: GestureDetector(child: Icon(Icons.business_center),onTap: (){ viewProducts(dealers[index].dealersId,
                              dealers[index].dealerName);},),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
    );
  }

  void loadAllDealers() async {
    var response = await MakeApiCalls.makeAGetRequest('Dealers/GetDealers');
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      for (var item in jsonData) {
        DealersList dealer = DealersList();
        dealer = DealersList.fromJson(item);
        dealers.add(dealer);
      }
    }
    hasLoaded = true;
    setState(() {

    });
  }

  void viewProducts(String dealersId, String dealerName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DealersProducts(
          dealerId: dealersId,
          dealerName: dealerName,
        ),
      ),
    );
  }

  void addLocation(String dealersId, String dealerName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DealerLocation(
          dealerId: dealersId,
          dealerName: dealerName,

        ),
      ),
    );
  }
}
