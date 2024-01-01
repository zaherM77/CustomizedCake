import 'package:customizedcake/CakeTopperWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Cake.dart';

class FlavorPickerWidget extends StatefulWidget {
  @override
  FlavorPickerWidgetState createState() => FlavorPickerWidgetState();
}

class FlavorPickerWidgetState extends State<FlavorPickerWidget> {
  final GlobalKey<FlavorPickerWidgetState> flavorPickerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Cake cake = ModalRoute
        .of(context)!
        .settings
        .arguments as Cake;
    return Material(
        child:
      Column(
      children: [
        Text(
          'Select Cake Flavor:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        DropdownButton<String>(
          value: cake.flavore,
          onChanged: (value) {
            setState(() {
              cake.flavore = value!;
            });
          },
          items: ['Vanilla', 'Chocolate', 'Strawberry', 'Lemon']
              .map<DropdownMenuItem<String>>(
                (String value) =>
                DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ),
          )
              .toList(),
        ),
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
                    settings: RouteSettings(arguments: cake,),
                    builder: (context) => CakeTopperWidget(),
                  ),);
              },
              child: Text('Next'),
            ),
          ],
        ),
      ],
      )
    );
  }
}