import 'dart:convert';
import 'package:co_driver/Screens/CheckOut.dart';
import 'package:co_driver/Models/MyProducts.dart';
import 'package:co_driver/MyWidgets/OldCheckOut.dart';
import 'package:co_driver/Repo/AppConstants.dart';
import 'package:co_driver/Repo/MakeApiCalls.dart';
import 'package:flutter/material.dart';
class ViewProductsBySize extends StatefulWidget {
  static const String id = 'ViewProductsBySize';
  final String productSize;

  const ViewProductsBySize({Key key, this.productSize}) : super(key: key);
  @override
  _ViewProductsBySizeState createState() => _ViewProductsBySizeState();
}

class _ViewProductsBySizeState extends State<ViewProductsBySize> {
  @override
  void initState() {
    // TODO: implement initState
    loadDealersProducts();
    super.initState();
  }
  var hasLoaded = false;
  List<MyProducts> myProducts = List<MyProducts>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(widget.productSize),),
      body:
          hasLoaded == false
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Column(children: <Widget>[
        ListView.builder(
          shrinkWrap: true,
          itemCount: myProducts.length,
          itemBuilder: (_, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: ListTile(
                  onTap: ()async{
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckOut(product: myProducts[index]),
                      ),
                    );
                  },
                  leading: CircleAvatar(child: myProducts[index].productImage.length>0? Image.network(AppConstants.webEndpoint+myProducts[index].productImage[0].imageFile):Icon(Icons.broken_image),),
                  title: Text(myProducts[index].productName),
                  subtitle: Text('Retail Ksh:'+myProducts[index].retailPrice.toString()),
                  trailing:Icon(Icons.add_shopping_cart),
                ),
              ),
            );
          },
        )
      ]),
    );
  }

  void loadDealersProducts() async {
    myProducts.clear();
    var response = await MakeApiCalls.makeAGetRequest('Products/GetProductByActualSize?id=' + widget.productSize);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      for (var item in jsonData) {
        MyProducts products = MyProducts();
        products = MyProducts.fromJson(item);
        myProducts.add(products);
      }
    }
    hasLoaded=true;
    setState(() {

    });
  }
}
