import 'dart:convert';

import 'package:co_driver/Models/TyreSizes.dart';
import 'package:co_driver/MyWidgets/MyWidgets.dart';
import 'package:co_driver/Repo/MakeApiCalls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';

import 'ViewProductsBySize.dart';
class FilterTyres extends StatefulWidget {
  static const String id = 'FilterTyres';
  @override
  _FilterTyresState createState() => _FilterTyresState();
}

class _FilterTyresState extends State<FilterTyres> {
  String selectedSize ;
  bool hasLoaded = false;
  List<String> tyreSizes = new List<String>();
  @override
  void initState() {
    // TODO: implement initState
    getTyresBySize();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Filter Tyres'),),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              child: DropDown<String>(
                isExpanded: true,
                items: TyreSizes.tyreSizes,
                initialValue: selectedSize,
                hint: Text("Select Size"),
                onChanged: (String size) {
                  setState(() {
                    selectedSize = size;
                    getTyresBySize();
                  });
                },
              ),
            ),
          ),
          hasLoaded==false?Center(child: Text('Select Size to Load Tyres'),):
              Column(
                children: <Widget>[
                  Center(child: Text('Products Matching your Search',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
                  Divider(),
                  tyreSizes.length==0?Center(child: Text('No products matched that size.')): ListView.builder(
                    shrinkWrap: true,
                    itemCount: tyreSizes.length,
                    itemBuilder: (_, index) {
                      return Card(
                          child: ListTile(
                            onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ViewProductsBySize(
                                          productSize: tyreSizes[index]
                                      ),
                                    ),
                                  );

                            },
                            title: Text(tyreSizes[index]),

                          ),
                        );
                    }),
                ],
              ),
        ],
      ),
    );
  }

  void getTyresBySize() async{
    tyreSizes.clear();
    if(selectedSize!=null){
      var response=  await MakeApiCalls.makeAGetRequest('Products/GetProductBySize/'+selectedSize);
      if(response.statusCode==200){
        var jsonData = json.decode(response.body);
        print(jsonData);
        for(var item in jsonData){
          tyreSizes.add(item);
        }
      }
      hasLoaded= true;
      setState(() {

      });
    }


  }
}
