import 'dart:convert';

import 'package:co_driver/Models/Customer.dart';
import 'package:co_driver/Repo/MakeApiCalls.dart';
import 'package:co_driver/Screens/AddShippingAddress.dart';
import 'package:flutter/material.dart';

class AllCustomers extends StatefulWidget {
  static const String id='AllCustomers';
  @override
  _AllCustomersState createState() => _AllCustomersState();
}

class _AllCustomersState extends State<AllCustomers> {
  List<Customer> customers = List<Customer>();
  var hasLoaded = false;
  @override
  void initState() {
    loadCustomers();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Customers'),
      ),
      body: hasLoaded == false
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: <Widget>[
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: customers.length,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          onTap: () {
                            addShippingAddress(customers[index].customerId,
                                customers[index].name);
                          },
                          title: Text(customers[index].name),
                          subtitle: Text('E: ' +
                              customers[index].identityUser.email +
                              ' T:' +
                              customers[index].identityUser.phoneNumber),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
    );
  }

  void addShippingAddress(String customerId, String name) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddShippingAddress(
          customerName: name,
          customerId: customerId,
        ),
      ),
    );
  }

  void loadCustomers() async {
    var response = await MakeApiCalls.makeAGetRequest('Customers/GetCustomer');
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      for (var item in jsonData) {

        Customer cust = Customer();
        cust = Customer.fromJson(item);
        customers.add(cust);
        print(customers.length);
      }
    }
    hasLoaded = true;
    setState(() {

    });
  }
}
