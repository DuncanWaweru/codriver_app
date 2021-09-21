import 'package:co_driver/Screens/AddDealer.dart';
import 'package:co_driver/Screens/AddShippingAddress.dart';
import 'package:co_driver/Screens/AllCustomers.dart';
import 'package:co_driver/Screens/AllDealers.dart';
import 'package:flutter/material.dart';
import 'Auth/LoginScreen.dart';
import 'Screens/AddProducts.dart';
import 'Screens/BookedAppointments.dart';
import 'Screens/FilterTyres.dart';
import 'Screens/StartPage.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Co Driver',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        StartPage.id:(context)=>StartPage(),
        AddDealer.id:(context)=>AddDealer(),
        AllDealers.id:(context)=>AllDealers(),
        AddProducts.id:(context)=>AddProducts(),
        AddShippingAddress.id:(context)=>AddShippingAddress(),
        AllCustomers.id:(context)=>AllCustomers(),
        BookedAppointments.id:(context)=>BookedAppointments(),
        FilterTyres.id:(context)=>FilterTyres()
      },
      supportedLocales: [Locale('en', 'KE')],
    );
  }
}

