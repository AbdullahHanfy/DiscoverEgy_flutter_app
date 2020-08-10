import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

var imgResponse;
var transResponse;

class Description extends StatefulWidget {
  final File imageFile;
  final String lang;
  Description(this.imageFile, this.lang);
  @override
  State<StatefulWidget> createState() {
    return _DescriptionState(this.imageFile, this.lang);
  }
}

class _DescriptionState extends State<Description> {
  final File imageFile;
  final String lang;
  _DescriptionState(this.imageFile, this.lang);

  Future<http.Response> requestMethodImage() async {
    var url = 'https://tourappai.appspot.com/detect_imgdata';
    //var body = json.encode({'uri': downUrl});
    var imageBytes = imageFile.readAsBytesSync();
    Map<String, String> header = {'Content-type': 'application/octet-stream'};
    final response =
        await http.post(url, headers: header, body: imageBytes, encoding: utf8);

    final responseJson = json.decode(response.body);

    imgResponse = responseJson['result'].toString();
    return response;
  }

  Future<http.Response> requestMethodTrans(var lang) async {
    var url = 'https://tourappai.appspot.com/translate';
    var body =
        json.encode({'description': imgResponse, "target": lang.toString()});

    Map<String, String> header = {'Content-type': 'application/json'};
    final response = await http.post(url, headers: header, body: body);

    transResponse = response.body.toString();

    return response;
  }

  String code;

  void langcode() {
    switch (lang) {
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
        child: new FutureBuilder(
            future: requestMethodTrans(lang),
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
    List<String> titleres = transResponse.split(",");
    String subtitle = ' ';
    for (int i = 1; i < titleres.length; i++) {
      subtitle = subtitle + titleres[i];
    }

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
                  imageFile,
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
                        title: Text(titleres[0]),
                        subtitle: Text(subtitle),
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
