import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:discover_egy/models/site_model.dart';
import 'package:discover_egy/screens/restaurant_secreen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
//import '../constants.dart';

class SiteCarousel extends StatefulWidget {
  @override
  _SiteCarouselState createState() => _SiteCarouselState();
}

class _SiteCarouselState extends State<SiteCarousel> {
  Future<List<Site>> _fetchSites() async {
    var response = await http.get("http://10.0.2.2/API/sites");

    var jsonData = json.decode(response.body);
    //print(jsonData);
    List<Site> sites = [];
    for (var data in jsonData) {
      Site site = Site(
          imageUrl: data['image'],
          name: data['name'],
          rate: data['rate'],
          price: data['price']);
      sites.add(site);
    }
    return sites;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'sites',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RestaurantScreen(),
                  ),
                ),
                child: Text(
                  'See All',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 350.0,
          child: FutureBuilder(
            future: _fetchSites(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Text("Loading..."),
                  ),
                );
              } else {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.all(10.0),
                      /* height: 200.0,
                      width: 240.0, */
                      child: SingleChildScrollView(
                        child: Column(
                          //alignment: Alignment.topCenter,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0.0, 2.0),
                                    blurRadius: 6.0,
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image(
                                  height: 180.0,
                                  width: 250.0,
                                  image: NetworkImage(
                                      snapshot.data[index].imageUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              height: 150.0,
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
                                        snapshot.data[index].name,
                                        style: TextStyle(
                                          fontSize: 19.5,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.2,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 2.0),
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
                                      /* Text(
                                        snapshot.data[index].rate,
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ), */
                                      SizedBox(height: 2.0),
                                      Text(
                                        snapshot.data[index].price,
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w600,
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
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
