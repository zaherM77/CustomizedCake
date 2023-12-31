import 'package:flutter/material.dart';
import 'AllCakes.dart';
import 'Cake.dart';
import 'ViewOrders.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("admin"),
      ),
      body: allCakes(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist_rtl),
            label: 'Orders',
          ),
        ],
        onTap: (index) {
          // Handle navigation when a tab is pressed
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GetProducts()),
            );
          }
          else if(index==2){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ViewOrders()),
            );
          }
        },
      ),
    );
  }
}