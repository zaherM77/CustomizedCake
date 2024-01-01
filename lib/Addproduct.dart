import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}
class _AddProductState extends State<AddProduct> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _productImageUrlController = TextEditingController();
  final TextEditingController _productdescriptionController = TextEditingController(); // Add category controller

  @override
  void dispose() {
    _productNameController.dispose();
    _productPriceController.dispose();
    _productImageUrlController.dispose();
    _productdescriptionController.dispose(); // Dispose of category controller
    super.dispose();
  }
  void _addProduct() async {
    final String productName = _productNameController.text;
    final String productPrice = _productPriceController.text;
    final String productImageUrl = _productImageUrlController.text;
    final String productdescription = _productdescriptionController.text;

    final String apiUrl = 'https://bestbakery77.000webhostapp.com/add_product.php';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'name': productName,
          'price': productPrice,
          'image_url': productImageUrl,
          'description': productdescription,
        },
      );

      if (response.statusCode == 200) {
        // Parse the response body to get the newly added product information
        final Map<String, dynamic> responseData = json.decode(response.body);
        final String newProductId = responseData['id'];
        final String newProductName = responseData['name'];
        final String newProductPrice = responseData['price'];
        final String newProductImageUrl = responseData['image_url'];
        final String newProductdescription = responseData['description'];

        // Pass the new product information back to the previous screen
        Navigator.pop(context, {
          'id': newProductId,
          'name': newProductName,
          'price': newProductPrice,
          'image_url': newProductImageUrl,
          'category': newProductdescription,
        });

        // Show a success message (optional)
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Product added successfully"),
        ));
      } else {
        // Handle HTTP request error
        print("HTTP request error. Status code: ${response.statusCode}");
      }
    } catch (e) {
      // Handle other errors (e.g., network error)
      print("Error: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextField(
              controller: _productNameController,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              controller: _productPriceController,
              decoration: InputDecoration(labelText: 'Product Price'),
            ),
            TextField(
              controller: _productImageUrlController,
              decoration: InputDecoration(labelText: 'Product Image URL'),
            ),
            TextField(
              controller: _productdescriptionController,
              decoration: InputDecoration(labelText: 'Product Description'),
            ),
            ElevatedButton(
              onPressed: _addProduct,
              child: Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}

