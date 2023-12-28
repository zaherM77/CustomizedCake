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
            ContainerWithNextButton(),
            ElevatedButton(
              onPressed: () {
                _showConfirmationDialog();
              },
              child: Text('Order My Cake'),
            ),
          ],
        ),
      ),
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
              BuildCakePreview(
                selectedColor: ColorPickerWidgetState().selectedColor,
                selectedFlavor: FlavorPickerWidgetState().selectedFlavor,
                selectedLayers: NbLayerPickerWidgetState().selectedLayers,
                selectedCremeType: CremePickerWidgetState().selectedCremeType,
              ),
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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Order confirmed!'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

class BuildCakePreview extends StatelessWidget {
  final Color selectedColor;
  final String selectedFlavor;
  final int selectedLayers;
  final String selectedCremeType;

  BuildCakePreview({
    required this.selectedColor,
    required this.selectedFlavor,
    required this.selectedLayers,
    required this.selectedCremeType,
  });

  @override
  Widget build(BuildContext context) {
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

class ContainerWithNextButton extends StatefulWidget {
  @override
  _ContainerWithNextButtonState createState() => _ContainerWithNextButtonState();
}

class _ContainerWithNextButtonState extends State<ContainerWithNextButton> {
  int currentPage = 0;

  List<Widget> pages = [
    ColorPickerWidget(),
    NbLayerPickerWidget(),
    FlavorPickerWidget(),
    CremePickerWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          pages[currentPage],
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (currentPage > 0)
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      currentPage--;
                    });
                  },
                  child: Text('Previous'),
                ),
              ElevatedButton(
                onPressed: () {
                  if (currentPage < pages.length - 1) {
                    setState(() {
                      currentPage++;
                    });
                  } else {
                    // Handle the next button action when on the last page
                    print('Last page reached');
                  }
                },
                child: Text(currentPage < pages.length - 1 ? 'Next' : 'Finish'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}






