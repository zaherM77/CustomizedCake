
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

class ColorPickerWidget extends StatefulWidget {
  @override
  ColorPickerWidgetState createState() => ColorPickerWidgetState();
}

class ColorPickerWidgetState extends State<ColorPickerWidget> {
  Color selectedColor = Colors.brown;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Select Cake Color:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        MaterialColorPicker(
          onColorChange: (Color color) {
            setState(() {
              selectedColor = color;
            });
          },
          selectedColor: selectedColor,
          allowShades: false,
        ),
      ],
    );
  }
}