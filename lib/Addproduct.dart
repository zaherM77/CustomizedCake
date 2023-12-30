import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}
class _AddProductState extends State<AddProduct> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _productImageUrlController = TextEditingController();
  final TextEditingController _productCategoryController = TextEditingController(); // Add category controller

  @override
  void dispose() {
    _productNameController.dispose();
    _productPriceController.dispose();
    _productImageUrlController.dispose();
    _productCategoryController.dispose(); // Dispose of category controller
    super.dispose();
  }

  void _addProduct() async {
    final String productName = _productNameController.text;
    final String productPrice = _productPriceController.text;
    final String productImageUrl = _productImageUrlController.text;
    final String productCategory = _productCategoryController.text; // Get category value

    // Replace with your server URL
    final String apiUrl = 'http://10.0.0.15/API/add_product.php';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'name': productName,
          'price': productPrice,
          'image_url': productImageUrl,
          'category': productCategory, // Add category to the request body
        },
      );

      if (response.statusCode == 200) {
        // Handle the response from the server (e.g., show a success message)
        print("Product added successfully");
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
              controller: _productCategoryController,
              decoration: InputDecoration(labelText: 'Product Category'),
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

