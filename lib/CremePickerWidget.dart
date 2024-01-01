import 'package:customizedcake/FlavorPickerWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Cake.dart';


class CremePickerWidget extends StatefulWidget {
  @override
  CremePickerWidgetState createState() => CremePickerWidgetState();
}

class CremePickerWidgetState extends State<CremePickerWidget> {
  final GlobalKey<CremePickerWidgetState> cremePickerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    Cake cake = ModalRoute.of(context)!.settings.arguments as Cake;
    return Material( // Add Material widget here
       child:Column(
      children: [
        Text(
          'Select Creme Type:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        DropdownButton<String>(
          value: cake.frosting,
          onChanged: (value) {
            setState(() {
              cake.frosting = value!;
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
                    settings:  RouteSettings(arguments: cake ,),
                    builder: (context) => FlavorPickerWidget(),
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