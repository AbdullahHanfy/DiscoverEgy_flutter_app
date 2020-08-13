import 'package:flutter/material.dart';
import 'package:discover_egy/services/location.dart';
import '../constants.dart';

class TripInputs extends StatefulWidget {
  static String id = 'tripInputs';
  @override
  _TripInputsState createState() => _TripInputsState();
}

class _TripInputsState extends State<TripInputs> {
  Location location = Location();
  String duration;
  String price;

  @override
  void initState() {
    super.initState();
    location.getLocation();
  } //after this function , I had access the location of the user

  final kBlack = Color(0xff1a1a1a);
  final kGold = Color(0xffc7aa68);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlack,
      appBar: AppBar(
        backgroundColor: kBlack,
        centerTitle: true,
        title: Text(
          'Sugget a tour plan program',
          style: TextStyle(color: kGold),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
          child: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(50.0),
            child: TextFormField(
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter The Duration time of your Trip',
              ),
              onChanged: (value) {
                duration = value;
              },
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            padding: EdgeInsets.all(50.0),
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
                print(duration);
                print(price);
                print('${location.latitude}');
              },
              elevation: 5.0,
              splashColor: kBlack,
              child: Text(
                'search',
                style: TextStyle(color: kGold, fontSize: 20.0),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
