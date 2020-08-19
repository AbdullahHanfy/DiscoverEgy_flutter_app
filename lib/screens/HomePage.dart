import 'package:flutter/material.dart';
import 'package:discover_egy/widgets/hotel_carousel.dart';
import 'package:discover_egy/widgets/restaurant_carousel.dart';
import 'package:discover_egy/widgets/site_carousel.dart';

class HomePage extends StatefulWidget {
  static String id = 'homePage';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 30.0),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 15.0),
              child: Text(
                'Welcome to Egypt..',
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 40.0),
            HotelCarousel(),
            SizedBox(height: 20.0),
            RestaurantCarousel(),
            SizedBox(height: 20.0),
            SiteCarousel(),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
