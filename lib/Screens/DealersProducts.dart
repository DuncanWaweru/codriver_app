import 'dart:convert';

import 'package:co_driver/Models/MyProducts.dart';
import 'package:co_driver/Repo/MakeApiCalls.dart';
import 'package:flutter/material.dart';

import 'AddProducts.dart';
import 'ProductImages.dart';

class DealersProducts extends StatefulWidget {
  static const String id = 'AddProducts';
  final String dealerId;
  final String dealerName;

  const DealersProducts({Key key, this.dealerId, this.dealerName})
      : super(key: key);

  @override
  _DealersProductsState createState() => _DealersProductsState();
}

class _DealersProductsState extends State<DealersProducts> {
  List<MyProducts> myProducts = List<MyProducts>();
  @override
  void initState() {
    loadDealersProducts();
    // TODO: implement initState
    super.initState();
  }

  var hasLoaded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.dealerName)),
        actions: <Widget>[GestureDetector(child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: Icon(Icons.add_circle,size: 30,)),
        ),onTap: (){Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddProducts(
              dealerId: widget.dealerId,
            ),
          ),
        );
        },)],
      ),
      body: hasLoaded == false
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(children: <Widget>[
        myProducts.length==0?Column(
          children: <Widget>[
            SizedBox(height: 200,),
            Center(child: Text('No data to show.'),),
            FlatButton.icon(onPressed: (){

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddProducts(
                    dealerId: widget.dealerId,
                  ),
                ),
              );
            }, icon: Icon(Icons.add_circle), label: Text('Add Products'),color: Color(0xffff256040),)
          ],
        ): ListView.builder(
          shrinkWrap: true,
          itemCount: myProducts.length,
          itemBuilder: (_, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: ListTile(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductImages(
                          productId: myProducts[index].productId,
                        ),
                      ),
                    );
                  },
                  leading: CircleAvatar(child: Text(myProducts[index].size.toString()),),
                  title: Text(myProducts[index].productName.toString()),
                  subtitle: Text('W/S :'+myProducts[index].wholeSalePrice.toString()+'/=  Ret :'+myProducts[index].retailPrice.toString()+'/='),
                  trailing: myProducts[index].active==true?Icon(Icons.check_circle,color: Colors.greenAccent,):Icon(Icons.cancel,color: Colors.redAccent,),
                ),
              ),
            );
          },
        )
      ]),
    );
  }

  void loadDealersProducts() async {
    var response = await MakeApiCalls.makeAGetRequest('Products/GetProductPerDealer/' + widget.dealerId);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      for (var item in jsonData) {
        print('item');
        print(item);
        MyProducts products = MyProducts();
        products = MyProducts.fromJson(item);
        print('product');
        print(products.productName);
        myProducts.add(products);
      }
    }
    hasLoaded=true;
    setState(() {

    });
  }
}
