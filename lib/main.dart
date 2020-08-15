import 'package:flutter/material.dart';
import './screens/HomePage.dart';
import './screens/destination_screen.dart';
import './screens/login_screen.dart';
import './screens/museum_screen.dart';
import './screens/page_selector.dart';
import './screens/registration_screen.dart';
import './screens/welcome_screen.dart';
import './screens/trip_inputs.dart';

void main() => runApp(DiscoverEGY());

class DiscoverEGY extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: PageSelector.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        PageSelector.id: (context) => PageSelector(),
        HomePage.id: (context) => HomePage(),
        DestinationScreen.id: (context) => DestinationScreen(),
        MuseumScreen.id: (context) => MuseumScreen(),
        TripInputs.id: (context) => TripInputs()
      },
    );
  }
}
