import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/program_model.dart';
import '../constants.dart';

class ProgramCarousel extends StatefulWidget {
  final double latitude;
  final double longtude;
  final String duration;
  final String price;
  ProgramCarousel({this.latitude, this.longtude, this.duration, this.price});
  @override
  _ProgramCarouselState createState() => _ProgramCarouselState();
}

class _ProgramCarouselState extends State<ProgramCarousel> {
  Future<List<Program>> _fetchPrograms() async {
    var url = 'http://192.168.1.8:8080/tour_planning';
    var data = {
      'lat': 30.050053,
      'lon': 31.235964,
      'startTime': 9,
      'time': 8,
      'budget': 200
    };
    Map<String, String> header = {'Content-type': 'application/json'};

    var response =
        await http.post(url, headers: header, body: json.encode(data));

    var jsonData = jsonDecode(response.body);

    // to mared data to see json
    /*var urlll = "http://10.0.2.2/API/data";
    var responseFromMared =
        //await http.post("http://10.0.2.2/API/data", body: jsonData);
        await http.post(urlll, body: json.encode(data));
    var jsonDataMared = jsonDecode(responseFromMared.body);
    print(jsonDataMared);
*/
    print(jsonData);
    //
    List<Program> programs = [];
    for (var data in jsonData) {
      Program program = Program(
          totalHoures: data['program']['totalhours'],
          totalPrices: data['program']['totalmoney']);
      programs.add(program);
      print(data);
    }
    return programs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kBlack,
          centerTitle: true,
          title: Text(
            'Recommended Programs',
            style: TextStyle(color: kGold),
          ),
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: ListView(
            children: [
              Container(
                height: 350.0,
                child: FutureBuilder(
                  future: _fetchPrograms(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Container(
                        child: Center(
                          child: Text("Loading..."),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: 4,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () => print('Done'),
                            child: Container(
                              margin: EdgeInsets.all(10.0),
                              /* height: 200.0,
                        width: 240.0, */
                              child: SingleChildScrollView(
                                child: Column(
                                  //alignment: Alignment.topCenter,
                                  children: <Widget>[
                                    Container(
                                      height: 150.0,
                                      width: 280.0,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              Text(
                                                snapshot
                                                    .data[index].totalHoures,
                                                style: TextStyle(
                                                  fontSize: 19.5,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 1.2,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              SizedBox(height: 2.0),
                                              Text(
                                                snapshot
                                                    .data[index].totalPrices,
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ));
  }
}
