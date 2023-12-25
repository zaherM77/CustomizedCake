import 'package:flutter/material.dart';

import 'HomeScreen.dart';

void main() => runApp(CakeStoreApp());

class CakeStoreApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cake Store',
      home: HomeScreen(),
    );
  }
}
