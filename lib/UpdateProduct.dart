import 'package:customizedcake/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateProductPage extends StatefulWidget {
  final Product product;

  const UpdateProductPage({Key? key, required this.product}) : super(key: key);

  @override
  _UpdateProductPageState createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set the initial values for the text fields
    nameController.text = widget.product.name;
    priceController.text = widget.product.price.toString();
    descriptionController.text = widget.product.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'Product Price'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Product Description'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _updateProduct(widget.product.id);
              },
              child: Text('Update Product'),
            ),
          ],
        ),
      ),
    );
  }

  void _updateProduct(int productId) async {
    // Retrieve values from the controllers
    String name = nameController.text;
    int price = int.tryParse(priceController.text) ?? 0;
    String description = descriptionController.text;

    // Perform the update request
    try {
      var url = "http://10.0.0.15/API/updateProduct.php";
      var response = await http.post(
        Uri.parse(url),
        body: {
          'product_id': productId.toString(),
          'name': name,
          'price': price.toString(),
          'description': description,
        },
      );

      if (response.statusCode == 200) {
        print('Product updated successfully');

        // Update the product in the list
        setState(() {
          widget.product.name = name;
          widget.product.price = price;
          widget.product.description = description;
        });

        // Return to the calling page
        Navigator.pop(context);
      } else {
        print('Failed to update product. Status Code: ${response.statusCode}');
        // Optionally, you can show an error message or handle the failure
      }
    } catch (e) {
      print('Error: $e');
      // Handle other exceptions if necessary
      // Optionally, you can show an error message or handle the failure
    }
  }
}
