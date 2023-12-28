import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FlavorPickerWidget extends StatefulWidget {
  @override
  FlavorPickerWidgetState createState() => FlavorPickerWidgetState();
}

class FlavorPickerWidgetState extends State<FlavorPickerWidget> {
  String selectedFlavor = 'Vanilla';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Select Cake Flavor:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        DropdownButton<String>(
          value: selectedFlavor,
          onChanged: (value) {
            setState(() {
              selectedFlavor = value!;
            });
          },
          items: ['Vanilla', 'Chocolate', 'Strawberry', 'Lemon']
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