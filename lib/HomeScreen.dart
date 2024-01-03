import 'package:customizedcake/selectProducts.dart';
import 'package:flutter/material.dart';

import 'CakeCustomizationScreen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cake Store'),

      ),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0), // Adjust top padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MyImageWithButton(),
            SizedBox(height: 20.0),
            //Customer_display_products(),
          ],
        ),
      ),
    );
  }  

  Widget _buildCakeCategory(String categoryName, String imageUrl) {
    return Card(
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
    );
  }
}
class MyImageWithButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            width: 500.0, // Adjust the width as needed
            height: 400.0, // Adjust the height as needed
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("image1.png"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10.0), // Optional: Add border radius
              color: Colors.purple.shade100,
            ),
          ),
          SizedBox(height: 15,),
          ElevatedButton.icon(
            icon:Icon(Icons.navigate_next),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Customer_display_products()),
              );
            },
            label: Text('Go'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple.shade800, // Background color of the button
              foregroundColor: Colors.white, // Text color of the button
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0), // Border radius
              ),)
          ),
        ],
      ),
    );
  }
}

