import 'package:flutter/material.dart';
import 'Cake.dart';

class Products_display extends StatefulWidget {
  Products_display({Key ?key}) : super(key: key);

  @override
  _Products_displayState createState() {
    return _Products_displayState();
  }
}

class _Products_displayState extends State<Products_display> {
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
        title: Text('Product Page'),
    ),
    body: ListView.builder(
      itemCount: (cakes.length / 2).ceil(), // Calculate number of rows
      itemBuilder: (context, index) {
        int startIndex = index * 2;
        int endIndex = startIndex + 1;

        return Row(
          children: [
            if (startIndex < cakes.length) _buildProductCard(cakes[startIndex]),
            if (endIndex < cakes.length) _buildProductCard(cakes[endIndex]),
          ],
        );
      },
    )
    );

  }

  Widget _buildProductCard(Cake cake) {
    return Expanded(
      child: Card(
        elevation: 5.0,
        margin: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
              child: Image.network(
                cake.image,
                height: 150.0,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                cake.category,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  IconButton(
                      onPressed: (){

                      },
                      icon: Icon(Icons.delete)),
                  ElevatedButton(
                      onPressed: (){

                      },
                      child: Text("edit"))
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}