import 'package:customizedcake/product.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

//const String _baseURL = "http://10.0.0.15/API/getProduct.php";
// const String _baseURL ="bestbakery7.infinityfreeapp.com";
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
        title: Text("All Products"),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) => Container(
          color: index % 2 == 0 ? Colors.amber : Colors.cyan,
          padding: const EdgeInsets.all(5),
          width: width * 0.9,
          child: Row(
            children: [
              SizedBox(width: width * 0.15),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ID: ${products[index].id}',
                        style: TextStyle(fontSize: width * 0.045)),
                    Text('Name: ${products[index].name}',
                        style: TextStyle(fontSize: width * 0.045)),
                    Text('Price: ${products[index].price}',
                        style: TextStyle(fontSize: width * 0.045)),
                    // Add similar lines for other fields
                  ],
                ),
              ),
            ],
          ),

        ),
      ),
    );
  }
  void updateProductsAndRebuild() {
    updateProducts();
    setState(() {}); // Trigger a rebuild
  }
}
