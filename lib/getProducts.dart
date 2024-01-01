import 'package:customizedcake/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'UpdateProduct.dart';

List<Product> products = [];

void updateProducts() async {
  var url = "https://bestbakery77.000webhostapp.com/getProduct.php";

  try {
    var response = await http.get(Uri.parse(url));
    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      print('API Response Body: $jsonResponse');

      products.clear();
      for (var row in jsonResponse) {
        Product p = Product(
          int.parse(row['id']?.toString() ?? '0'),
          row['name']?.toString() ?? '',
          int.parse(row['price']?.toString() ?? '0'),
          row['image_url']?.toString() ?? '',
          row['description']?.toString() ?? '',
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
        itemCount: products.length,
        itemBuilder: (context, index) {
          return _buildProductCard(context, products[index]);
        },
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Product product) {
    return Card(
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateProductPage(product: product),
                      ),
                    ).then((updatedProduct) {
                      // Handle the updated product when coming back from the update page
                      if (updatedProduct != null) {
                        setState(() {
                          // Find and replace the old product with the updated one
                          int index = products.indexWhere((p) => p.id == updatedProduct.id);
                          if (index != -1) {
                            products[index] = updatedProduct;
                          }
                        });
                      }
                    });
                  },
                  child: Text("edit"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _deleteProduct(int productId) async {
    try {
      var url = "https://bestbakery77.000webhostapp.com/deleteProduct.php";
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
  }
}
