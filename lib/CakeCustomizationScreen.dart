import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

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
      body:
      Padding(
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
              buildCakePreview(),
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
class buildCakePreview extends StatefulWidget {
  @override
  _buildCakePreviewState createState() => _buildCakePreviewState();
}

class _buildCakePreviewState extends State<ContainerWithNextButton> {
  @override
  Widget build(BuildContext context) {

    Color c = _ColorPickerWidgetState().selectedColor;
    String f = _FlavorPickerWidgetState().selectedFlavor;
    int l = _NbLayerPickerWidgetState().selectedLayers;
    String r = _CremePickerWidgetState().selectedCremeType;

    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: c,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          'Preview\nFlavor: $f\nLayers: $l\nCreme Type: $r',
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

class ColorPickerWidget extends StatefulWidget {

  @override
  _ColorPickerWidgetState createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends State<ColorPickerWidget> {
  Color selectedColor = Colors.brown;
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Text(
            'Select Cake Color:',
            style:
            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
        ]
    )
    ;
  }
}

class NbLayerPickerWidget extends StatefulWidget {

  @override
  _NbLayerPickerWidgetState createState() => _NbLayerPickerWidgetState();
}

class _NbLayerPickerWidgetState extends State<NbLayerPickerWidget> {
  int selectedLayers = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Select Number of Layers:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Slider(
          value: selectedLayers.toDouble(),
          min: 1,
          max: 4,
          onChanged: (value) {
            setState(() {
              selectedLayers = value.toInt();
            });
          },
          divisions: 4,
          label: selectedLayers.toString(),
        ),
      ],
    );
  }
}

class FlavorPickerWidget extends StatefulWidget {
  @override
  _FlavorPickerWidgetState createState() => _FlavorPickerWidgetState();
}

class _FlavorPickerWidgetState extends State<FlavorPickerWidget> {
  String selectedFlavor = 'Vanilla';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
      ],
    );
  }
}

class CremePickerWidget extends StatefulWidget {


  @override
  _CremePickerWidgetState createState() => _CremePickerWidgetState();
}

class _CremePickerWidgetState extends State<CremePickerWidget> {
  String selectedCremeType = 'Buttercream';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
      ],
    );
  }
}

