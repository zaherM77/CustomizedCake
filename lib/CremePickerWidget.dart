import 'package:flutter/material.dart';
import 'FlavorPickerWidget.dart';
import 'Cake.dart';

class CremePickerWidget extends StatefulWidget {
  @override
  CremePickerWidgetState createState() => CremePickerWidgetState();
}

class CremePickerWidgetState extends State<CremePickerWidget> {
  final GlobalKey<CremePickerWidgetState> cremePickerKey = GlobalKey();
  Cake cake = Cake();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
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
                      settings: RouteSettings(arguments: cake),
                      builder: (context) => FlavorPickerWidget(),
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
