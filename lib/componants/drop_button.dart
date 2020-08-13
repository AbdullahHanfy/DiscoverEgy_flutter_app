import 'package:flutter/material.dart';

class DropButton extends StatelessWidget {
  final String dropdownValue;
  final List<String> items;
  final Function onChanged;
  DropButton(this.dropdownValue, this.onChanged, this.items);
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      dropdownColor: Color(0xff1a1a1a),
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Color(0xffc7aa68)),
      underline: Container(
        height: 2,
        color: Color(0xffc7aa68),
      ),
      onChanged: onChanged,
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
