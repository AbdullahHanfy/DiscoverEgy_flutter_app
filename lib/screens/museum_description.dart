import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

var imgResponse;

class MuseumDescription extends StatefulWidget {
  static String id = 'museumDescription';
  final File imageFile;
  final String lang;
  MuseumDescription(this.imageFile, this.lang);
  @override
  _MuseumDescriptionState createState() {
    return _MuseumDescriptionState(this.imageFile, this.lang);
  }
}

class _MuseumDescriptionState extends State<MuseumDescription> {
  final File imageFile;
  final String lang;
  _MuseumDescriptionState(this.imageFile, this.lang);

  Future<http.Response> requestMethodImage() async {
    var url = 'https://';
    //var body = json.encode({'uri': downUrl});
    var imageBytes = imageFile.readAsBytesSync();
    Map<String, String> header = {'Content-type': 'application/octet-stream'};
    final response =
        await http.post(url, headers: header, body: imageBytes, encoding: utf8);

    final responseJson = json.decode(response.body);

    imgResponse = responseJson['result'].toString();
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore Egyptian Museum'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 80.0),
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
            ],
          ),
        ),
      ),
    );
  }
}
