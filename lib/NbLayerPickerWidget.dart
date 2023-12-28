
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NbLayerPickerWidget extends StatefulWidget {
  @override
  NbLayerPickerWidgetState createState() => NbLayerPickerWidgetState();
}

class NbLayerPickerWidgetState extends State<NbLayerPickerWidget> {
  int selectedLayers = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Select Number of Layers:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Slider(
          value: selectedLayers.toDouble(),
          min: 1,
          max: 4,
          onChanged: (value) {
            setState(() {
              selectedLayers = value.toInt();
            });
          },
          divisions: 4,
          label: selectedLayers.toString(),
        ),
      ],
    );
  }
}