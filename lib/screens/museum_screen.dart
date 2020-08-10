import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:discover_egy/constants.dart';
import './museum_description.dart';

class MuseumScreen extends StatefulWidget {
  static String id = 'museumScreen';
  @override
  State<StatefulWidget> createState() {
    return _MuseumScreenState();
  }
}

class _MuseumScreenState extends State<MuseumScreen> {
  String dropdownValue = 'English';
  String statueName;
  File _imageFile; // this is a var type file from io package to save an picture

  //var lang = 'en';

  //AudioPlayer audioPlayer = AudioPlayer();

  Future uploadPic(BuildContext context) async {
    if (_imageFile == null) {
      Fluttertoast.showToast(
          msg: "Please Take or upload the image",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MuseumDescription(_imageFile, dropdownValue),
          ));
    }
  }

  void _getImage(BuildContext context, ImageSource source) {
    ImagePicker.pickImage(source: source, maxWidth: 400.0).then((File image) {
      setState(() {
        _imageFile = File(image.path);
      });
      Navigator.pop(context);
    });
  }

  void _openImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: Color(0xff1a1a1a),
            height: 150.0,
            padding: EdgeInsets.all(10.0),
            child: Column(children: [
              Text(
                'Pick an Image',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xffc7aa68)),
              ),
              SizedBox(
                height: 10.0,
              ),
              FlatButton(
                textColor: Theme.of(context).primaryColor,
                child: Text(
                  'Use Camera',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xffc7aa68)),
                ),
                onPressed: () {
                  _getImage(context, ImageSource.camera);
                },
              ),
              FlatButton(
                textColor: Theme.of(context).primaryColor,
                child: Text(
                  'Use Gallery',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xffc7aa68)),
                ),
                onPressed: () {
                  _getImage(context, ImageSource.gallery);
                },
              )
            ]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1a1a1a),
      appBar: AppBar(
        backgroundColor: Color(0xff1a1a1a),
        centerTitle: true,
        title: Text(
          'Explore Egyptian Museum',
          style: TextStyle(color: Color(0xffc7aa68)),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20.0),
              child: TextFormField(
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter The Statue Name',
                ),
                onChanged: (value) {
                  statueName = value;
                },
              ),
            ),
            SizedBox(height: 5.0),
            Center(
              child: RaisedButton(
                color: Color(0xff1a1a1a),
                onPressed: () {},
                elevation: 2.0,
                splashColor: Color(0xff1a1a1a),
                child: Text(
                  'search',
                  style: TextStyle(color: Color(0xffc7aa68), fontSize: 16.0),
                ),
              ),
            ),
            SizedBox(height: 30.0),
            Center(
              child: Text(
                'OR click here to Take a picture to the Statue',
                style: TextStyle(color: Color(0xffc7aa68), fontSize: 20.0),
              ),
            ),
            SizedBox(height: 10.0),
            Center(
              child: GestureDetector(
                child: Container(
                  height: 200.0,
                  child: Image.asset('assets/images/logo1.png'),
                ),
                onTap: () {
                  _openImagePicker(context);
                },
              ),
            ),
            /* Center(
              child: new RawMaterialButton(
                onPressed: () {
                  _openImagePicker(context);
                },
                child: _imageFile == null
                    ? new Icon(
                        Icons.camera,
                        color: Colors.blueGrey,
                        size: 200.0,
                      )
                    : Image.file(
                        _imageFile,
                      ),
                shape: CircleBorder(),
                elevation: 1.0,
                fillColor: Color(0xff1a1a1a),
                padding: const EdgeInsets.all(1.0),
              ),
            ), */
            SizedBox(height: 20.0),
            Center(
              child: DropdownButton<String>(
                dropdownColor: Color(0xff1a1a1a),
                value: dropdownValue,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Color(0xffc7aa68)),
                underline: Container(
                  height: 2,
                  color: Color(0xffc7aa68),
                ),
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
                items: <String>["English", "Arabic", "French", "Spanish"]
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Center(
              child: RaisedButton(
                color: Color(0xff1a1a1a),
                onPressed: () async {
                  uploadPic(context);
                },
                elevation: 2.0,
                splashColor: Color(0xff1a1a1a),
                child: Text(
                  'Submit',
                  style: TextStyle(color: Color(0xffc7aa68), fontSize: 16.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
