import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class CremePickerWidget extends StatefulWidget {
  @override
  CremePickerWidgetState createState() => CremePickerWidgetState();
}

class CremePickerWidgetState extends State<CremePickerWidget> {
  String selectedCremeType = 'Buttercream';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Select Creme Type:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        DropdownButton<String>(
          value: selectedCremeType,
          onChanged: (value) {
            setState(() {
              selectedCremeType = value!;
            });
          },
          items: ['Buttercream', 'Fondant', 'Cream Cheese']
              .map<DropdownMenuItem<String>>(
                (String value) => DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            ),
          )
              .toList(),
        ),
      ],
    );
  }
}