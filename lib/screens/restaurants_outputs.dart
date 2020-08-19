import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/activity_model.dart';
import '../models/restaurant_model.dart';
import '../constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RestaurantsOutput extends StatefulWidget {
  @override
  _RestaurantsOutputState createState() => _RestaurantsOutputState();
}

class _RestaurantsOutputState extends State<RestaurantsOutput> {
  Future<List<Restaurant>> _fetchRestaurants() async {
    /* var url = 'http://192.168.1.7:8080/recommendation';
    var data = {"diet": "Cafe", "price": "\$\$-\$\$\$"};
    Map<String, String> header = {'Content-type': 'application/json'};

    var response =
        await http.post(url, headers: header, body: json.encode(data)); */
    var response = await http.get("http://10.0.2.2/API/recommendation");
    var jsonData = jsonDecode(response.body);
    //print(jsonData[]);

    List<Restaurant> restaurants = [];

    for (var rest in jsonData) {
      Restaurant restaurant = Restaurant(
          imageUrl: rest['image'],
          name: rest['name'],
          specialDiets: rest['specialdiets'],
          rate: rest['rate']);
      restaurants.add(restaurant);
    }
    print(restaurants.length);

    return restaurants;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Color(0xff1a1a1a),
        appBar: AppBar(
          backgroundColor: kBlack,
          centerTitle: true,
          title: Text(
            'Recommended Restaurants',
            style: TextStyle(color: kGold),
          ),
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
            child: FutureBuilder(
                future: _fetchRestaurants(),
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
                            itemCount: 10,
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
                                                    snapshot.data[index]
                                                        .specialDiets,
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

                                          //_buildRatingStars(int.parse(activity.rating)),

                                          RatingBar(
                                            initialRating: double.parse(
                                                snapshot.data[index].rate),
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
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
                                          SizedBox(height: 10.0),
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
