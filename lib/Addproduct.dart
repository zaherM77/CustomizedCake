import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  AddProduct({Key ?key}) : super(key: key);

  @override
  _AddProductState createState() {
    return _AddProductState();
  }
}

class _AddProductState extends State<AddProduct> {
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
        title: Text("add new product"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,

      ),
    );
  }
}