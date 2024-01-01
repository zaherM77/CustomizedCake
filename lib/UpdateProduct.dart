import 'dart:io';
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
  final TextEditingController image_urlController = TextEditingController();

  File? _pickedImage;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.product.name;
    priceController.text = widget.product.price.toString();
    descriptionController.text = widget.product.description;
    image_urlController.text = widget.product.image_url;
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

                TextField(
                  controller: image_urlController,
                  decoration: InputDecoration(labelText: 'Product image'),
                ),
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
    String image_url= image_urlController.text;

    // Perform the update request
    try {
      var url = "https://bestbakery77.000webhostapp.com/updateProduct.php";
      var response = await http.post(
        Uri.parse(url),
        body: {
          'product_id': productId.toString(),
          'name': name,
          'price': price.toString(),
          'description': description,
          'image_url' : image_url,
        },
      );

      if (response.statusCode == 200) {
        print('Product updated successfully');

        // Update the product in the list
        setState(() {
          widget.product.name = name;
          widget.product.price = price;
          widget.product.description = description;
          widget.product.image_url = image_url;
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
