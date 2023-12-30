import 'package:flutter/material.dart';
import 'AllCakes.dart';
import 'getProducts.dart';

class AdminPanel extends StatefulWidget {
  AdminPanel({Key? key}) : super(key: key);

  @override
  _AdminPanelState createState() {
    return _AdminPanelState();
  }
}

class _AdminPanelState extends State<AdminPanel> {
  @override
  void initState() {
    super.initState();
    updateProducts();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin"),
      ),
      body: _getBodyWidget(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Orders',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          // Handle navigation when a tab is pressed
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _getBodyWidget(int index) {
    switch (index) {
      case 0:
        return GetProducts(); // Your initial widget for the "Home" tab
      case 1:
        return allCakes(); // Replace YourOrdersWidget with the widget you want to display for the "Orders" tab
      default:
        return GetProducts(); // Handle other cases or return an empty container
    }
  }
}


