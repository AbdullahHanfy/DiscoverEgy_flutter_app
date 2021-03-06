import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/activity_model.dart';
import '../constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProgramDetailsCarousel extends StatefulWidget {
  final double latitude;
  final double longtude;
  final String duration;
  final String price;
  final int index;
  ProgramDetailsCarousel(
      {this.latitude, this.longtude, this.duration, this.price, this.index});
  @override
  _ProgramDetailsCarouselState createState() => _ProgramDetailsCarouselState();
}

class _ProgramDetailsCarouselState extends State<ProgramDetailsCarousel> {
  Future<List<Activity>> _fetchActivitys() async {
    var url = 'http://192.168.1.7:8080/tour_planning';
    var data = {
      'lat': 31.050053,
      'lon': 35.235964,
      'startTime': 9,
      'time': 8,
      'budget': 100
    };
    Map<String, String> header = {'Content-type': 'application/json'};

    var response =
        await http.post(url, headers: header, body: json.encode(data));

    var jsonData = jsonDecode(response.body);
    //print(jsonData[widget.index]['program']);
    //
    List<Activity> activites = [];
    /* Program program = Program(
        totalHoures: jsonData[0]['program'][0]["From"].toString(),
        totalPrices: jsonData[0]['program'][0]["From"].toString());
    programs.add(program); */

    for (var data in jsonData[widget.index]['program']) {
      print(data['Image']);
      print(data['you will visit']);

      print(data['rating of this place is ']);
      print(data['rating of this place is ']);
      print(data['The cost is ']);
      print(data['From']);
      print(data['To']);

      Activity activity = Activity(
          imageUrl: data['Image'],
          name: data['you will visit'],
          price: data['The cost is '],
          rating: data['rating of this place is '],
          startTimes: [data['From'], data['To']]);
      activites.add(activity);
    }
    print(activites.length);

    return activites;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Color(0xff1a1a1a),
        appBar: AppBar(
          backgroundColor: kBlack,
          centerTitle: true,
          title: Text(
            'Programs Details',
            style: TextStyle(color: kGold),
          ),
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
            child: FutureBuilder(
                future: _fetchActivitys(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: Center(
                        child: Text("Loading..."),
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
                            itemCount: 4,
                            itemBuilder: (BuildContext context, int index) {
                              return Stack(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        40.0, 5.0, 20.0, 5.0),
                                    height: 170.0,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          100.0, 20.0, 20.0, 20.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                width: 120.0,
                                                child: Text(
                                                  snapshot.data[index].name,
                                                  style: TextStyle(
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                ),
                                              ),
                                              Column(
                                                children: <Widget>[
                                                  Text(
                                                    '\$${snapshot.data[index].price}',
                                                    style: TextStyle(
                                                      fontSize: 22.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Text(
                                            '',
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          //_buildRatingStars(int.parse(activity.rating)),
                                          SizedBox(height: 10.0),
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.all(5.0),
                                                width: 50.0,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  'From',
                                                ),
                                              ),
                                              SizedBox(width: 5.0),
                                              Container(
                                                padding: EdgeInsets.all(5.0),
                                                width: 50.0,
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  snapshot.data[index]
                                                      .startTimes[0],
                                                ),
                                              ),
                                              SizedBox(width: 10.0),
                                              Container(
                                                padding: EdgeInsets.all(5.0),
                                                width: 40.0,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  'To',
                                                ),
                                              ),
                                              SizedBox(width: 5.0),
                                              Container(
                                                padding: EdgeInsets.all(5.0),
                                                width: 70.0,
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  snapshot.data[index]
                                                      .startTimes[1],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 20.0,
                                    top: 15.0,
                                    bottom: 15.0,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Image(
                                        width: 110.0,
                                        image: NetworkImage(
                                          snapshot.data[index].imageUrl,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }
                })));
  }
}

/*
Padding(
                      padding: EdgeInsets.all(10),
                      child: ListView.builder(
                        primary: false,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 4,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Container(
                              height: 90,
                              child: Row(
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image(
                                      image: NetworkImage(
                                        snapshot.data[index].imageUrl,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Container(
                                    height: 80,
                                    width:
                                        MediaQuery.of(context).size.width - 130,
                                    child: ListView(
                                      primary: false,
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            snapshot.data[index].name,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                            ),
                                            maxLines: 2,
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        SizedBox(height: 3),
                                        RatingBar(
                                          initialRating: double.parse(
                                              snapshot.data[index].rating),
                                          minRating: 3,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 1,
                                          itemPadding: EdgeInsets.symmetric(
                                              horizontal: 2.0),
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Color(0xffc7aa38),
                                          ),
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                          },
                                        ),
                                        Row(
                                          children: <Widget>[
                                            SizedBox(width: 3),
                                            Row(
                                              children: <Widget>[
                                                Container(
                                                  padding: EdgeInsets.all(5.0),
                                                  width: 70.0,
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .accentColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    snapshot.data[index]
                                                        .startTimes[0],
                                                  ),
                                                ),
                                                SizedBox(width: 10.0),
                                                Container(
                                                  padding: EdgeInsets.all(5.0),
                                                  width: 70.0,
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .accentColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    snapshot.data[index]
                                                        .startTimes[1],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '\$${snapshot.data[index].price}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                            maxLines: 1,
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )



*/
