import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'package:co_driver/MyWidgets/MyWidgets.dart';
import 'package:co_driver/Repo/MakeApiCalls.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
class ProductImages extends StatefulWidget {
  final String productId;

  const ProductImages({Key key, this.productId}) : super(key: key);

  @override
  _ProductImagesState createState() => _ProductImagesState();

}

class _ProductImagesState extends State<ProductImages> {
  @override
  void initState() {
    initPermissions();
    // TODO: implement initState
    super.initState();
  }

  bool isVideo = false;
  var submitingForm  =false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Product Images'),),
    body: SingleChildScrollView(
      child: Card(
        elevation: 10.0,
        child: Form(
          child: Column(
            children: <Widget>[
              Semantics(
                label: 'Select from gallery',
                child: FloatingActionButton(
                  onPressed: () {
                    getImage(ImageSource.gallery);
                  },
                  heroTag: 'image0',
                  tooltip: 'Pick Image from gallery',
                  child: const Icon(Icons.photo_library),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: FloatingActionButton(
                  onPressed: ()async {
                  await  getImage(ImageSource.camera);

                  },
                  heroTag: 'image1',
                  tooltip: 'Take a Photo',
                  child: const Icon(Icons.camera_alt),
                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child:_image != null? Material(
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
                          addImage();
                        }
                        catch(Exception){

                          setState(() {
                            submitingForm=false;
                          });
                        }


                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child:Text(
                      'Upload Image',
                    ),
                  ):
                  MyWidgets.loadingButton(),
                ):Material(),
              ),
              Center(
                child: _image == null
                    ? Text('No image selected.')
                    : Image.file(_image),
              ),
            ],
          ),
        ),
      ),
    ),);
  }

  File _image;
  ImagePicker picker = ImagePicker();
  Future getImage(ImageSource gallery) async {
    PickedFile  pickedFile = await picker.getImage(source: gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
initPermissions() async{
  await Permission.camera.request();
  //await Permission.location.request();
  await Permission.storage.request();
}

  void addImage()async {

    var response = await  MakeApiCalls.makeAPostRequestWithAFile('Products/PostImage/'+widget.productId,_image);
    if(response.statusCode == 200||response.statusCode==201){
      //set shared Preferences
      Fluttertoast.showToast(
          msg: 'Product Image Added successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          textColor: Colors.white,
          backgroundColor: Color(0xffff256040),
          fontSize: 16.0);
    }
    else{
      Fluttertoast.showToast(
          msg: 'Product Image Added successfully', ////TODO: update
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          textColor: Colors.white,
          backgroundColor: Color(0xffff256040),
          fontSize: 16.0);
    }
    setState(() {
      submitingForm=false;
    });
  }
}


