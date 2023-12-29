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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Welcome to Cake Store',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Customize your dream cake!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Customise My Cake'),
              onTap: () {
                Navigator.pop(context);
                _navigateToCustomizationScreen();
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0), // Adjust top padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Discover Our Delicious Cakes',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: SingleChildScrollView( // Use SingleChildScrollView to handle overflow
                child: Column(
                  children: [
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
        ),
      ),
    );
  }

  void _navigateToCustomizationScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CakeCustomizationScreen()),
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
