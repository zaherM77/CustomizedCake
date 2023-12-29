import 'package:customizedcake/Addproduct.dart';
import 'package:flutter/material.dart';

import 'Admin_diplay_products.dart';

class allCakes extends StatefulWidget {
  allCakes({Key ?key}) : super(key: key);

  @override
  _allCakesState createState() {
    return _allCakesState();
  }
}

class _allCakesState extends State<allCakes> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView( // Use SingleChildScrollView to handle overflow
            child: Column(
              children: [
                ElevatedButton.icon(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddProduct()),
                      );
                    },
                  icon: Icon(Icons.add), // Icon on the left
                  label: Text('Add new product'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Background color
                    foregroundColor: Colors.white, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), // Border radius
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10), // Padding
                  ),
                ),
                SizedBox(height: 12.0),
                _buildCakeCategory(
                  'Wedding Cakes',
                  'https://cdn.pixabay.com/photo/2017/03/02/07/18/wedding-2110546_1280.jpg',
                ),
                SizedBox(height: 12.0),
                _buildCakeCategory(
                  'Birthday Cakes',
                  'https://cdn.pixabay.com/photo/2015/08/04/14/24/birthday-874783_1280.jpg',
                ),
                SizedBox(height: 12.0),
                _buildCakeCategory(
                  'Cupcakes',
                  'https://cdn.pixabay.com/photo/2016/01/11/07/18/cupcakes-1133146_1280.jpg',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCakeCategory(String categoryName, String imageUrl) {
    return GestureDetector(
        onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Products_display(),
        ),
      );
    },
      child:Card(
        elevation: 5.0,
        margin: EdgeInsets.only(bottom: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
              child: Image.network(
                imageUrl,
                height: 150.0,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                categoryName,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}