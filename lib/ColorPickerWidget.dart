
import 'package:customizedcake/NbLayerPickerWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

import 'Cake.dart';

 Cake cake = Cake();
class ColorPickerWidget extends StatefulWidget {
  @override
  ColorPickerWidgetState createState() => ColorPickerWidgetState();
}

class ColorPickerWidgetState extends State<ColorPickerWidget> {

  final GlobalKey<ColorPickerWidgetState> colorPickerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 100,),
        Text(
          'Select Cake Color:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        MaterialColorPicker(
          onColorChange: (Color color) {
            setState(() {
              cake?.color = color;

            });
          },
          selectedColor: cake?.color,
          allowShades: false,
        ),
        Row(
          children: [
              SizedBox(width: 170,),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        settings:  RouteSettings(arguments: cake ,),
                      builder: (context) => NbLayerPickerWidget(),
                  ),
                  );
                },
                child: Text('Next'),
              ),
          ],
        ),
      ],
    );
  }
}