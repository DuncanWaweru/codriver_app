import 'package:co_driver/Auth/LoginScreen.dart';
import 'package:co_driver/Repo/GetSharedPrefs.dart';
import 'package:co_driver/Screens/AllCustomers.dart';
import 'package:co_driver/Screens/FilterTyres.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AddDealer.dart';
import 'AllDealers.dart';
import 'BookedAppointments.dart';
import 'package:fluttertoast/fluttertoast.dart';
class StartPage extends StatefulWidget {
  static const String id = 'StartPage';
  @override
  _StartPageState createState() => _StartPageState();
}
String username;
class _StartPageState extends State<StartPage> {
  @override
  void initState() {
    loadUserName();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome Back'),),
      drawer: _buildDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Flexible(flex: 1, child: Card( elevation: 10,child: ListTile(onTap: (){Navigator.pushNamed(context, FilterTyres.id);},title: Icon(Icons.camera),subtitle: Center(child: Text('Tyres')),)),),
                Flexible(flex: 1, child: Card(elevation:10 ,child: ListTile(title: Icon(Icons.airplay),subtitle: Center(child: Text('Batteries')),))),
              ],
            ),
            Row(
              children: <Widget>[
                Flexible(flex:1,child: Card( elevation: 10,child: ListTile(title: Icon(Icons.settings_applications),subtitle: Center(child: Text('Accessories')),))),
              ],
            ),
            Divider(color: Colors.black,),
            Center(child: Text('Admin Functions'),),
            Divider(color: Colors.black,),
            Row(
              children: <Widget>[
                Flexible(flex: 1, child: Card( elevation: 10,child: ListTile(onTap: (){Navigator.pushNamed(context, AddDealer.id);},title: Icon(Icons.camera),subtitle: Center(child: Text('Add Dealer')),)),),
                Flexible(flex: 1, child: Card(elevation:10 ,child: ListTile(onTap: (){Navigator.pushNamed(context, AllDealers.id);},title: Icon(Icons.airplay),subtitle: Center(child: Text('Dealers')),))),
                Flexible(flex: 1, child: Card(elevation:10 ,child: ListTile(onTap: (){Navigator.pushNamed(context, AllCustomers.id);}, title: Icon(Icons.airplay),subtitle: Center(child: Text('Customers')),))),

              ],
            ),
            Row(
              children: <Widget>[
                Flexible(flex: 1, child: Card(elevation:10 ,child: ListTile(onTap:(){Navigator.pushNamed(context, BookedAppointments.id);},title: Icon(Icons.remove_red_eye),subtitle: Center(child: Text('Visits')),))),

                Flexible(flex: 1, child: Card( elevation: 10,child: ListTile(onTap:(){comingSoonToast();}, title: Icon(Icons.camera),subtitle: Center(child: Text('Deliveries')),)),),
                Flexible(flex: 1, child: Card(elevation:10 ,child: ListTile(onTap:(){comingSoonToast();},title: Icon(Icons.airplay),subtitle: Center(child: Text('My Details')),))),

              ],
            ),
          ],
        ),
      ),

    );
  }
  Drawer _buildDrawer(context) {
    return new Drawer(
      child: new ListView(
        children: <Widget>[
          DrawerHeader(
              child: new Container(

                decoration: BoxDecoration(color: Colors.indigoAccent),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      child: Icon(Icons.account_circle),
                      radius: 40.0,
                      backgroundColor: Colors.white,
                    ),
                    Text(
                      username == null ? 'Not Logged In' : username,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )),
          Divider(
            color: Colors.black45,
            indent: 10.0,
          ),
          ListTile(
            onTap: () {
              //Navigator.popAndPushNamed(context, ChangePassword.id);
            },
            leading: Icon(Icons.vpn_key,color: Colors.blueAccent),
            title: Text(
              'Change Password',
              style: TextStyle(color: Colors.black),
            ),
          ),
          Divider(
            color: Colors.black45,
            indent: 10.0,
          ),
          ListTile(
            onTap: () async {
              final pref = await SharedPreferences.getInstance();
              await pref.clear();
              print('Prefs cleared');
              Navigator.pop(context);
              // Navigator.of(context).popUntil(ModalRoute.withName(LoginScreen.id));
              Navigator.popAndPushNamed(context, LoginScreen.id);
              SystemNavigator.pop();
              // Navigator.pop(context);
              //Navigator.pushNamed(context, LoginScreen.id);
            },
            leading: Icon(Icons.power_settings_new,color: Colors.blueAccent),
            title: Text(
              'Log Out',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  void loadUserName ()async {
    username = await  GetSharedPrefs.getNamePreference('username');

 setState(() {

 });
  }

  void comingSoonToast() {
    Fluttertoast.showToast(
        msg: 'Feature coming soon',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        textColor: Colors.white,
        backgroundColor: Color(0xffff256040),
        fontSize: 16.0);

  }
}
