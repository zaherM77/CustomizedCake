import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Order.dart';

class ViewOrders extends StatefulWidget {
  @override
  _ViewOrdersState createState() => _ViewOrdersState();
}
class _ViewOrdersState extends State<ViewOrders> {
  List<Order> orders = [];

  @override
  void initState() {
    super.initState();
    _getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Order ID: ${orders[index].id}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Customer: ${orders[index].customerName}'),
                Text('Address: ${orders[index].customerAddress}'),
                Text('Product: ${orders[index].productName}'),
                Text('Price: \$${orders[index].productPrice}'),
                Text('Quantity: ${orders[index].quantity}'),
                Text('Note: ${orders[index].note}'),
                Text('Date: ${orders[index].date.toLocal()}'),
                Text('Customization Details:'),
                Text('   Color: ${orders[index].customizationDetails.color}'),
                Text('   Number of Layers: ${orders[index].customizationDetails.numberOfLayers}'),
                Text('   Flavour: ${orders[index].customizationDetails.flavour}'),
                Text('   Frosting: ${orders[index].customizationDetails.frosting}'),
                Text('   Cake Topper: ${orders[index].customizationDetails.cakeTopper}'),
              ],
            ),
          );
        },
      ),
    );
  }

  void _getOrders() async {
    var url = "http://10.0.0.15/API/getOrders.php";

    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        setState(() {
          orders = List<Order>.from(
            jsonResponse.map((order) => Order.fromJson(order)),
          );
        });
      } else {
        print('Failed to load orders. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
