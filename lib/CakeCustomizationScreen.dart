import 'package:flutter/material.dart';
import 'ColorPickerWidget.dart';
import 'CremePickerWidget.dart';
import 'FlavorPickerWidget.dart';
import 'NbLayerPickerWidget.dart';




class CakeCustomizationScreen extends StatefulWidget {
  @override
  _CakeCustomizationScreenState createState() => _CakeCustomizationScreenState();
}

class _CakeCustomizationScreenState extends State<CakeCustomizationScreen> {
  Color selectedColor = Colors.brown;
  int selectedLayers = 1;
  String selectedFlavor = 'Vanilla';
  String selectedCremeType = 'Buttercream';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customize Your Cake'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ColorPickerWidget(),
          ],
        ),
      ),
    );
  }

}