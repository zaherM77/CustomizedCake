import 'package:customizedcake/CakeCustomizationScreen.dart';

import'product.dart';
import 'package:customizedcake/product.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;




Future<List<Product>> updateProducts() async {
  var url = "http://192.168.1.8/API/getProduct.php";

  try {
    var response = await http.get(Uri.parse(url));
    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      print('API Response Body: $jsonResponse');

      List<Product> updatedProducts = [];
      for (var row in jsonResponse) {
        Product p = Product(
          int.parse(row['id']?.toString() ?? '0'),
          row['name']?.toString() ?? '',
          int.parse(row['price']?.toString() ?? '0'),
          row['image_url']?.toString() ?? '',
          row['description']?.toString() ?? '',
        );
        updatedProducts.add(p);
      }

      print('Products length after API call: ${updatedProducts.length}');
      return updatedProducts;
    } else {
      print('Failed to load products. Status Code: ${response.statusCode}');
      throw Exception('Failed to load products');
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('Error loading products');
  }
}

class Customer_display_products extends StatefulWidget {
  Customer_display_products({Key ?key}) : super(key: key);

  @override
  _Customer_display_productsState createState() {
    return _Customer_display_productsState();
  }
}

class _Customer_display_productsState extends State<Customer_display_products> {
  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = updateProducts();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title: Text("Pick your cake type")),
        body:
      FutureBuilder<List<Product>>(

      future: futureProducts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Product> products = snapshot.data!;
          return Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                if (index % 2 == 0) {
                  int endIndex = index + 1;
                  return Row(
                    children: [
                      _buildProductCard(products[index]),
                      if (endIndex < products.length)
                        _buildProductCard(products[endIndex]),
                    ],
                  );
                }
                return SizedBox(); // Return an empty SizedBox for odd indices
              },
            ),
          );
        }
      },
    ));
  }

  Widget _buildProductCard(Product product) {
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
                product.image_url,
                height: 150.0,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                product.name,
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
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                        MaterialPageRoute(
                            settings: RouteSettings(arguments: product),
                            builder: (context) => CakeCustomizationScreen()),
                      );
                    },
                    child: Text("Customise"),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
