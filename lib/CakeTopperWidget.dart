import 'package:flutter/material.dart';
import 'Cake.dart';


class CakeTopperWidget extends StatefulWidget {
  CakeTopperWidget({Key? key}) : super(key: key);

  @override
  _CakeTopperWidgetState createState() {
    return _CakeTopperWidgetState();
  }
}

class _CakeTopperWidgetState extends State<CakeTopperWidget> {
  TextEditingController _cakeTopperController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Cake cake = ModalRoute.of(context)!.settings.arguments as Cake;
    return Material(
        child:
        Column(
      children: [
        Text(
          'Select Cake Topper:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        TextField(
          controller: _cakeTopperController,
        decoration: InputDecoration(
          labelText: 'Cake Topper',
          hintText: 'enter your email',
        ),

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
                setState(() {
                  cake.cakeTopper = _cakeTopperController.text;
                });
                _showConfirmationDialog(cake.color,cake.flavore , cake.nbLayers , cake.frosting , cake.cakeTopper);

              },
              child: Text('Order My Cake'),
            ),
          ],
        ),
      ],
    )
    );
  }
  void _showConfirmationDialog(
      Color selectedColor ,
      String selectedFlavor ,
      int selectedLayers ,
      String selectedCremeType,
      String selectedCakeTopper) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Your Order'),
          content: Column(
            children: [
            Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: selectedColor,
              borderRadius: BorderRadius.circular(10),

            ),
            child: Center(
              child: Text(
                'Preview\nFlavor: $selectedFlavor\nLayers: $selectedLayers\nCreme Type: $selectedCremeType\n Cake Topper: $selectedCakeTopper',
                style: TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ),
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
}
