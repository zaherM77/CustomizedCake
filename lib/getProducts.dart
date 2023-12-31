import 'package:customizedcake/product.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
List<product> products = [];

void updateProducts() async {
  var url = "http://10.0.0.15/API/getProduct.php";

  try {
    var response = await http.get(Uri.parse(url));
    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      print('API Response Body: $jsonResponse');

      products.clear();
      for (var row in jsonResponse) {
        product p = product(
          int.parse(row['id']?.toString() ?? '0'),
          row['name']?.toString() ?? '',
          int.parse(row['price']?.toString() ?? '0'),
          row['image_url']?.toString() ?? '',
          int.parse(row['category_id']?.toString() ?? '0'),
        );
        products.add(p);
      }

      print('Products length after API call: ${products.length}');
    } else {
      print('Failed to load products. Status Code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

class GetProducts extends StatefulWidget {
  GetProducts({Key? key}) : super(key: key);

  @override
  _GetProductsState createState() => _GetProductsState();
}

class _GetProductsState extends State<GetProducts> {
  // Move the TextEditingController to the class level
  final TextEditingController productIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Page'),
      ),
      body: ListView.builder(
        itemCount: (products.length / 2).ceil(),
        itemBuilder: (context, index) {
          int startIndex = index * 2;
          int endIndex = startIndex + 1;

          return Row(
            children: [
              if (startIndex < products.length)
                _buildProductCard(context, products[startIndex]),
              if (endIndex < products.length)
                _buildProductCard(context, products[endIndex]),
            ],
          );
        },
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, product product) {
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
                  IconButton(
                    onPressed: () {
                      _deleteProduct(product.id); // Pass the product ID to delete
                    },
                    icon: Icon(Icons.delete),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle edit logic
                    },
                    child: Text("edit"),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteProduct(int productId) async {
    try {
      var url = "http://10.0.0.15/API/deleteProduct.php";
      var response = await http.post(
        Uri.parse(url),
        body: {'product_id': productId.toString()},
      );

      if (response.statusCode == 200) {
        print('Product deleted successfully');

        // Remove the deleted product from the products list
        products.removeWhere((product) => product.id == productId);

        // Trigger a rebuild to reflect the changes
        setState(() {});
      } else {
        print('Failed to delete product. Status Code: ${response.statusCode}');
        // Optionally, you can show an error message or handle the failure
      }
    } catch (e) {
      print('Error: $e');
      // Handle other exceptions if necessary
      // Optionally, you can show an error message or handle the failure
    }
  }}
