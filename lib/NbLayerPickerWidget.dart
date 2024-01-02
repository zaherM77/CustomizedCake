import 'package:customizedcake/CremePickerWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Cake.dart';

class NbLayerPickerWidget extends StatefulWidget {
  @override
  NbLayerPickerWidgetState createState() => NbLayerPickerWidgetState();
}

class NbLayerPickerWidgetState extends State<NbLayerPickerWidget> {
  final GlobalKey<NbLayerPickerWidgetState> nbLayerPickerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Cake cake = ModalRoute.of(context)!.settings.arguments as Cake;
    return Material(// Add Material widget here
      child: Column(
        children: [
          SizedBox(height: 100,),
          Text(
            'Select Number of Layers:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10,),
          Slider(
            value: cake.nbLayers.toDouble(),
            min: 1,
            max: 4,
            onChanged: (value) {
              setState(() {
                cake.nbLayers = value.toInt();
              });
            },
            divisions: 4,
            label: cake.nbLayers.toString(),
          ),
          SizedBox(height: 25,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Previous'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      settings: RouteSettings(arguments: cake),
                      builder: (context) => CremePickerWidget(),
                    ),
                  );
                },
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}