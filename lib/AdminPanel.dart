import 'package:flutter/material.dart';
import 'AllCakes.dart';
import 'Cake.dart';

class AdminPanel extends StatefulWidget {
  AdminPanel({Key ?key}) : super(key: key);

  @override
  _AdminPanelState createState() {
    return _AdminPanelState();
  }
}

class _AdminPanelState extends State<AdminPanel> {
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
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("admin"),
      ),
      body: allCakes(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.home_filled),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminPanel()),
                  );
                },
              ),
            label: 'home',
          ),
          BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.list_alt_outlined),
                onPressed: () { Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => getProducts()),
                ); },
              ),
              label: 'products',
          )
        ],),
    );
  }
}