import 'package:customizedcake/product.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

//const String _baseURL = "http://10.0.0.15/API/getProduct.php";
// const String _baseURL ="bestbakery7.infinityfreeapp.com";
void updateProducts() async {
  var url = "http://192.168.1.8/API/getProduct.php";

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
          int.parse(row['id']?.toString() ?? '0'), // Use '0' if 'id' is null
          row['name']?.toString() ?? '', // Use an empty string if 'name' is null
          int.parse(row['price']?.toString() ?? '0'), // Use '0' if 'price' is null
          row['image_url']?.toString() ?? '', // Use an empty string if 'image_url' is null
          int.parse(row['category_id']?.toString() ?? '0'), // Use '0' if 'category_id' is null
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
  @override
  // void initState() {
  //   super.initState();
  //   updateProducts();
  // }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text('Product Page'),
        ),
        body: ListView.builder(
          itemCount: (products.length / 2).ceil(), // Calculate number of rows
          itemBuilder: (context, index) {
            int startIndex = index * 2;
            int endIndex = startIndex + 1;

            return Row(
              children: [
                if (startIndex < products.length) _buildProductCard(products[startIndex]),
                if (endIndex < products.length) _buildProductCard(products[endIndex]),
              ],
            );
          },
        )
    );

  }
  void updateProductsAndRebuild() {
    updateProducts();
    setState(() {}); // Trigger a rebuild
  }
}

Widget _buildProductCard(product product) {
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

