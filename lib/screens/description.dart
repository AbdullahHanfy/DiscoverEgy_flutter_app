import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/item_model.dart';

var imgResponse;
var transResponse;

class MuseumDescription extends StatefulWidget {
  final File imageFile;
  final String lang;
  MuseumDescription(this.imageFile, this.lang);
  @override
  State<StatefulWidget> createState() {
    return _MuseumDescriptionState();
  }
}

class _MuseumDescriptionState extends State<MuseumDescription> {
  Future<List<Item>> _requestMethodImage() async {
    var url = 'http://192.168.1.3:8080/detect';
    //var body = json.encode({'uri': downUrl});
    var imageBytes = widget.imageFile.readAsBytesSync();
    Map<String, String> header = {'Content-type': 'application/octet-stream'};
    final response =
        await http.post(url, headers: header, body: imageBytes, encoding: utf8);

    final responseJson = json.decode(response.body);
    print(responseJson);
    List<Item> item = [];
    item.add(Item(
        name: responseJson['Name_E'].toString(),
        description: responseJson['Description_F'].toString()));

    print('aaa');
    return item;
  }

  /* Future<http.Response> requestMethodTrans(var lang) async {
    var url = 'https://tourappai.appspot.com/translate';
    var body =
        json.encode({'description': imgResponse, "target": lang.toString()});

    Map<String, String> header = {'Content-type': 'application/json'};
    final response = await http.post(url, headers: header, body: body);

    transResponse = response.body.toString();

    return response;
  } */

  String code;

  void langcode() {
    switch (widget.lang) {
      case 'en':
        code = 'en-US';
        break;
      case 'fr':
        code = 'fr-FR';
        break;
      case 'ar':
        code = 'ar-XA';
        break;
      case 'de':
        code = 'de-DE';
        break;
      case 'ru':
        code = 'ru-RU';
        break;
      case 'es':
        code = 'es-ES';
        break;
      case 'it':
        code = 'it-IT';
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: FutureBuilder(
            future: _requestMethodImage(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data != null) {
                  return new Column(
                    children: <Widget>[
                      new Expanded(
                        child: _getData(snapshot),
                      )
                    ],
                  );
                } else {
                  return CircularProgressIndicator();
                }
              } else {
                return CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                );
              }
            }));
  }

  Widget _getData(AsyncSnapshot snapshot) {
    /* List<String> titleres = transResponse.split(",");
    String subtitle = ' ';
    for (int i = 1; i < titleres.length; i++) {
      subtitle = subtitle + titleres[i];
    }  */

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Image Description'),
          centerTitle: true,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Image.file(
                  widget.imageFile,
                  fit: BoxFit.cover,
                  height: 200.0,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                ),
                Card(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                      ListTile(
                        title: Text('${snapshot.data[0].name}'),
                        subtitle: Text('${snapshot.data[0].description}'),
                      ),
                    ])),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
