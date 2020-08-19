import 'package:flutter/material.dart';
import '../constants.dart';
import '../componants/drop_button.dart';
import '../widgets/restaurant_page_carousel.dart';
import './restaurants_outputs.dart';

class RestaurantScreen extends StatefulWidget {
  static String id = 'restaurantScreen';
  @override
  _RestaurantScreenState createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  String specialDiets = 'Turkish';
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
            SizedBox(
              height: 15.0,
            ),
            Center(
              child: Text(
                'You can search about favourite restaurant',
                style: TextStyle(fontSize: 20.0, color: kGold),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Center(
              child: Text(
                'choose your best diets and range price',
                style: TextStyle(fontSize: 20.0, color: kGold),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 50, right: 50.0),
              child: TextFormField(
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter The special diets you want',
                ),
                onChanged: (value) {
                  specialDiets = value;
                },
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 50, right: 50.0),
              child: TextFormField(
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter The Price you want to pay',
                ),
                onChanged: (value) {
                  price = value;
                },
              ),
            ),
            SizedBox(height: 20.0),
            Center(
              child: RaisedButton(
                color: kBlack,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RestaurantsOutput(),
                      ));
                },
                elevation: 5.0,
                splashColor: kBlack,
                child: Text(
                  'search',
                  style: TextStyle(color: kGold, fontSize: 20.0),
                ),
              ),
            ),
            //RestaurantPageCarousel()
          ],
        ),
      ),
    );
  }
}

/* Padding(
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
                        /*   DropButton(specialDiets, (String newValue) {
                          setState(() {
                            specialDiets = newValue;
                          });
                        }, <String>[
                          "Turkish",
                          "Asian",
                          "Italian",
                          "Sushi",
                        ]), */
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
            ) */
