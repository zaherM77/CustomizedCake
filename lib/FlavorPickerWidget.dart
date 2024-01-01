import 'package:flutter/material.dart';
import 'CakeTopperWidget.dart';
import 'CremePickerWidget.dart';
import 'Cake.dart';
import 'LoginForm.dart';
import 'package:shared_preferences/shared_preferences.dart';
class FlavorPickerWidget extends StatefulWidget {
  @override
  FlavorPickerWidgetState createState() => FlavorPickerWidgetState();
}

class FlavorPickerWidgetState extends State<FlavorPickerWidget> {
  final GlobalKey<FlavorPickerWidgetState> flavorPickerKey = GlobalKey();
  Cake cake = Cake();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Text(
            'Select Cake Flavor:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          DropdownButton<String>(
            value: cake.flavor,
            onChanged: (value) {
              setState(() {
                cake.flavor = value!;
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
                onPressed: () async {
                  int? customerId = await SharedPreferencesUtil.getCustomerId();
                   cake.customerId = customerId;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      settings: RouteSettings(arguments: cake),
                      builder: (context) => CakeTopperWidget(),
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
