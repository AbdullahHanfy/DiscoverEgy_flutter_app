import 'package:flutter/material.dart';

class NavButton extends StatelessWidget {
  final Color colour;
  final String buttonName;
  final Function onPressed;

  NavButton(
      {@required this.colour,
      @required this.buttonName,
      @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            buttonName,
            style: TextStyle(
              fontSize: 27.0,
            ),
          ),
          textColor: Color(0xffc7aa68),
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: Color(0xffc7aa68), width: 1, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(50)),
        ),
      ),
    );
  }
}
