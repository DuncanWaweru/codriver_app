import 'package:co_driver/Models/MyProducts.dart';
import 'package:flutter/material.dart';

class OldCheckOut{
  static  checkOutAlertDialog(BuildContext context, MyProducts myProduct,) async {
    return showDialog(
      context:context,
        barrierDismissible: false,
        builder:(BuildContext context){
     return AlertDialog(
      title:Center(child: Column(
        children: <Widget>[
          Text('Check Out Item',),
          Divider(),
        ],
      )),
      content: Column(
        children: <Widget>[

        ],
      ),

    );
      }
    );
  }
}
