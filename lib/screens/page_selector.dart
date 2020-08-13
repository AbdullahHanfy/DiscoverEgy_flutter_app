import 'package:flutter/material.dart';
import 'HomePage.dart';
import './museum_screen.dart';
import './trip_inputs.dart';

class PageSelector extends StatefulWidget {
  static String id = 'pageSelector';
  @override
  _PageSelectorState createState() => _PageSelectorState();
}

class _PageSelectorState extends State<PageSelector> {
  int _currentTab = 0;

  final _pageOptions = [HomePage(), MuseumScreen(), HomePage(), TripInputs()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageOptions[_currentTab],
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
            canvasColor: Color(0xff1a1a1a),
            // sets the active color of the `BottomNavigationBar` if `Brightness` is light
            primaryColor: Color(0xffc7aa68),
            textTheme: Theme.of(context)
                .textTheme
                .copyWith(caption: new TextStyle(color: Color(0xffc7aa68)))),
        child: BottomNavigationBar(
          currentIndex: _currentTab,
          onTap: (value) {
            setState(() {
              _currentTab = value;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                size: 30.0,
              ),
              title: SizedBox.shrink(),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.camera,
                size: 30.0,
              ),
              title: SizedBox.shrink(),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.restaurant,
                size: 30.0,
              ),
              title: SizedBox.shrink(),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                size: 30.0,
              ),
              title: SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
