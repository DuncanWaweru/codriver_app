import 'package:co_driver/Models/LocationData.dart';
import 'package:co_driver/MyWidgets/MyWidgets.dart';
import 'package:co_driver/Repo/MakeApiCalls.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:fluttertoast/fluttertoast.dart';
class DealerLocation extends StatefulWidget {
  static const String id = 'DealerLocation';
  final String dealerId;
  final String dealerName;

  const DealerLocation({Key key, this.dealerId, this.dealerName}) : super(key: key);

  @override
  _DealerLocationState createState() => _DealerLocationState();
}

var submitingForm = false;
class _DealerLocationState extends State<DealerLocation> {
  Position position = Position();
  @override
  void initState() {
    // TODO: implement initState
    getLocation();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select '+widget.dealerName+ 'Location'),),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                elevation: 5.0,
                child:submitingForm ==false?
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      submitingForm=true;
                    });

                    try{
                      if(position!=null){
                      postLocation();}
                      else{
                        Fluttertoast.showToast(
                            msg: 'No Location has been selected',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 2,
                            textColor: Colors.white,
                            backgroundColor: Color(0xffff256040),
                            fontSize: 16.0);
                      }
                    }
                    catch(Exception){

                      setState(() {
                        submitingForm=false;
                      });
                    }


                  },
                  minWidth: 200.0,
                  height: 22.0,
                  child:Text(
                    'Update Location',
                  ),
                ):
                MyWidgets.loadingButton(),
              ),
            ),
            Text('lat:'+position.latitude.toString()+'long: '+position.longitude.toString()),
            Container(
              height: 600,
              child: Card(
                elevation: 10.0,
                child: FlutterMap(
                  options: new MapOptions(
                    center: new LatLng(-1.2921,36.7835),
                    zoom: 8.0,

                  ),
                  layers: [
                    new TileLayerOptions(
                        urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: ['a', 'b', 'c']
                    ),
                    new MarkerLayerOptions(
                      markers: [
                        new Marker(
                          width: 80.0,
                          height: 80.0,
                          point: position==null?new LatLng(position.latitude,position.longitude):LatLng(-1.2921,36.7835),
                          builder: (ctx) =>
                          new Container(
                            child: new Icon(Icons.location_on,color: Colors.redAccent,),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



  Future<void> getLocation() async {
    bool serviceEnabled;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    else
      await _determinePosition();


  }
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }
    position = await Geolocator.getCurrentPosition() ;
    setState(() {
      print('position print');
    });
    return position;
  }

  void postLocation() async{

    LocationData loc = LocationData();
    loc.latitude=position.latitude;
    loc.longitude =position.longitude;
    loc.dealerId = widget.dealerId;
    var json = loc.toJson();

  var response= await MakeApiCalls.makeAPostRequest('Dealers/UpdateLocation', json);
    if(response.statusCode == 200||response.statusCode==201){
      //set shared Preferences
      Fluttertoast.showToast(
          msg: 'Location updated successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          textColor: Colors.white,
          backgroundColor: Color(0xffff256040),
          fontSize: 16.0);


    }
    else{
      Fluttertoast.showToast(
          msg: 'An error occured',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          textColor: Colors.white,
          backgroundColor: Color(0xffffc2261b),
          fontSize: 16.0);
    }
    setState(() {
      submitingForm=false;
    });
  }

}


