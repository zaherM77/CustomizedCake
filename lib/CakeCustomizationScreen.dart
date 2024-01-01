import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

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
      body:
      SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            SizedBox(height: 20),
            Text(
              'Select Number of Layers:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Slider(
              value: selectedLayers.toDouble(),
              min: 1,
              max: 5,
              onChanged: (value) {
                setState(() {
                  selectedLayers = value.toInt();
                });
              },
              divisions: 4,
              label: selectedLayers.toString(),
            ),
            SizedBox(height: 20),
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
            SizedBox(height: 20),
            Text(
              'Select Creme Type:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: selectedCremeType,
              onChanged: (value) {
                setState(() {
                  selectedCremeType = value!;
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Show a confirmation dialog or proceed with the order
                _showConfirmationDialog();
              },
              child: Text('Order My Cake'),
            ),
          ],
        ),
      ),
    )
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Your Order'),
          content: Column(
            children: [
              // Display a preview of the selected cake
              _buildCakePreview(),
              SizedBox(height: 20),
              Text('Do you want to confirm your order?'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // TODO: Implement logic to proceed with the order
                // You can add code here to save the order or send it to a server
                _showOrderConfirmation();
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  void _showOrderConfirmation() {
    // Show a simple confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Order confirmed!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Widget _buildCakePreview() {
    // Build a simple preview of the selected cake
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: selectedColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          'Preview\nFlavor: $selectedFlavor\nLayers: $selectedLayers\nCreme Type: $selectedCremeType',
          style: TextStyle(color: Colors.white, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}