import 'package:flutter/material.dart';
import 'Cake.dart';
import 'package:http/http.dart' as http;

import 'LoginForm.dart';

class CakeTopperWidget extends StatefulWidget {
  CakeTopperWidget({Key? key}) : super(key: key);

  @override
  _CakeTopperWidgetState createState() {
    return _CakeTopperWidgetState();
  }
}

class _CakeTopperWidgetState extends State<CakeTopperWidget> {
  TextEditingController _cakeTopperController = TextEditingController();
  int selectedProductId = 2; // Initialize with a default value or fetch from your data
  int? customerId;

  @override
  void initState() {
    super.initState();
    _fetchCustomerId();
  }

  Future<void> _fetchCustomerId() async {
    // Fetch and set the customerId
    customerId = await SharedPreferencesUtil.getCustomerId();
  }

  @override
  Widget build(BuildContext context) {
    Cake cake = ModalRoute.of(context)!.settings.arguments as Cake;
    return Material(
      child: Column(
        children: [
          Text(
            'Select Cake Topper:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          TextField(
            controller: _cakeTopperController,
            decoration: InputDecoration(
              labelText: 'Cake Topper',
              hintText: 'Enter your cake topper',
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
                  _showConfirmationDialog(
                    cake.color,
                    cake.flavor,
                    cake.nbLayers,
                    cake.frosting,
                    cake.cakeTopper,
                  );
                },
                child: Text('Order My Cake'),
              ),
            ],
          ),
        ],
      ),
    );
  }


  void _showConfirmationDialog(
      Color selectedColor,
      String selectedFlavor,
      int selectedLayers,
      String selectedCremeType,
      String selectedCakeTopper,
      ) {
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
                // Send data to the PHP file
                _sendOrderToServer(
                  selectedColor,
                  selectedFlavor,
                  selectedLayers,
                  selectedCremeType,
                  selectedCakeTopper,
                );
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  void _sendOrderToServer(
      Color selectedColor,
      String selectedFlavor,
      int selectedLayers,
      String selectedCremeType,
      String selectedCakeTopper,
      ) async {
    var url = "https://bestbakery77.000webhostapp.com/submit_order.php";

    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          'color': selectedColor.toString(),
          'flavor': selectedFlavor,
          'layers': selectedLayers.toString(),
          'cremeType': selectedCremeType,
          'cakeTopper': selectedCakeTopper,
          'productId': selectedProductId.toString(),
          'customerId': customerId.toString(),
        },
      );

      if (response.statusCode == 200) {
        print('Response from server: ${response.body}');
        // Parse the response and handle accordingly
      } else {
        print('Failed to submit order. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
