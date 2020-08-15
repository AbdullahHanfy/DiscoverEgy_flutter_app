import 'package:flutter/material.dart';
import '../constants.dart';
import '../componants/drop_button.dart';
import '../widgets/restaurant_carousel.dart';

class RestaurantScreen extends StatefulWidget {
  static String id = 'restaurantScreen';
  @override
  _RestaurantScreenState createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  String specialDiets = 'English';
  String price = "\$ABB";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlack,
      appBar: AppBar(
        backgroundColor: kBlack,
        centerTitle: true,
        title: Text(
          'Restaurants',
          style: TextStyle(color: kGold),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        /* DropButton(price, (String newValue) {
                        setState(() {
                          price = newValue;
                        });
                      }, <String>["English", "\$", "French", "Spanish"]),
                      SizedBox(
                        height: 25.0,
                      ),*/
                        DropButton(specialDiets, (String newValue) {
                          setState(() {
                            specialDiets = newValue;
                          });
                        }, <String>["English", "\$", "French", "Spanish"]),
                      ],
                    ),
                    SizedBox(
                      width: 30.0,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: RaisedButton(
                            color: kBlack,
                            onPressed: () {},
                            elevation: 2.0,
                            splashColor: kGold,
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                  color: Color(0xffc7aa68), fontSize: 16.0),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            RestaurantCarousel(Axis.horizontal)
          ],
        ),
      ),
    );
  }
}
