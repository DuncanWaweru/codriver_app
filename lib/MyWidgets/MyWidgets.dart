import 'package:flutter/material.dart';

class MyWidgets{
   static InputDecoration buildInputDecoration(String hint,String label,Icon icon){

      return InputDecoration(
        prefixIcon: icon,
        hintText: hint,
        labelText:label,
        hintStyle: TextStyle(color: Colors.grey),
        contentPadding: EdgeInsets.symmetric(
            vertical: 10.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius:
          BorderRadius.all(Radius.circular(12.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.lightBlueAccent, width: 1.0),
          borderRadius:
          BorderRadius.all(Radius.circular(12.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.lightBlueAccent, width: 2.0),
          borderRadius:
          BorderRadius.all(Radius.circular(12.0)),
        ),
      );

  }
  static Material loadingButton() {
    return Material(
      color: Colors.blueAccent,
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
      elevation: 5.0,
      child: MaterialButton(

        minWidth: 200.0,
        height: 42.0,
        onPressed: () {},
        child: CircularProgressIndicator(backgroundColor: Colors.white,),
      ),
    );
  }
}