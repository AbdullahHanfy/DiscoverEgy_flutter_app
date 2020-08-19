import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/program_model.dart';
import '../constants.dart';
import '../screens/trip_outputs.dart';

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
    var url = 'http://192.168.1.7:8080/tour_planning';
    var data = {
      'lat': 30.050053,
      'lon': 31.235964,
      'startTime': 9,
      'time': 8,
      'budget': 100
    };
    Map<String, String> header = {'Content-type': 'application/json'};

    var response =
        await http.post(url, headers: header, body: json.encode(data));

    var jsonData = jsonDecode(response.body);
    //print(jsonData[0]['program']);
    //
    List<Program> programs = [];
    /* Program program = Program(
        totalHoures: jsonData[0]['program'][0]["From"].toString(),
        totalPrices: jsonData[0]['program'][0]["From"].toString());
    programs.add(program); */
    for (var data in jsonData) {
      //print(data);
      Program program = Program(
          totalHoures: data['totalhours'].toString(),
          totalPrices: data['totalmoney'].toString());
      programs.add(program);
    }

    return programs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff1a1a1a),
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
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProgramDetailsCarousel(
                                index: index,
                              ),
                            ));
                      },
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        /* height: 200.0,
                  width: 240.0, */
                        child: Column(
                          //alignment: Alignment.topCenter,
                          children: <Widget>[
                            Container(
                              height: 130.0,
                              width: 280.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        'Program ' + (index + 1).toString(),
                                        style: TextStyle(
                                          color: kGold,
                                          fontSize: 21,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.2,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        'Total hours :- ' +
                                            snapshot.data[index].totalHoures,
                                        style: TextStyle(
                                          fontSize: 19.5,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.2,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 2.0),
                                      Text(
                                        'Total price :- ' +
                                            snapshot.data[index].totalPrices +
                                            '\$',
                                        style: TextStyle(
                                          fontSize: 19.5,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.2,
                                        ),
                                      ),
                                      Text(
                                        'See Details',
                                        style: TextStyle(
                                            fontSize: 19.5,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.2,
                                            color: kGold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ));
  }
}
