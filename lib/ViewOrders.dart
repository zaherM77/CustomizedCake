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
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(
                'Order ID: ${orders[index].id}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Customer: ${orders[index].customerName ?? ''}'),
                  Text('Address: ${orders[index].customerAddress ?? ''}'),
                  Text('Product: ${orders[index].productName ?? ''}'),
                  Text('Price: \$${orders[index].productPrice ?? ''}'),
                  Text('Quantity: ${orders[index].quantity ?? ''}'),
                  Text('Date: ${orders[index].date?.toLocal() ?? ''}'),
                  Text('Customization Details:'),
                  if (orders[index].customizationDetails != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('   Color: ${orders[index].customizationDetails!.color ?? ''}'),
                        Text('   Number of Layers: ${orders[index].customizationDetails!.numberOfLayers ?? ''}'),
                        Text('   Flavour: ${orders[index].customizationDetails!.flavour ?? ''}'),
                        Text('   Frosting: ${orders[index].customizationDetails!.frosting ?? ''}'),
                        Text('   Cake Topper: ${orders[index].customizationDetails!.cakeTopper ?? ''}'),
                      ],
                    ),
                ],
              ),
              trailing: Checkbox(
                value: orders[index].isDone ?? false,
                onChanged: (value) => _updateOrderStatus(orders[index].id, value!),
              ),
            ),
          );
        },
      ),
    );
  }

  void _getOrders() async {
    var url = "https://bestbakery77.000webhostapp.com/getOrders.php";

    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        setState(() {
          orders = List<Order>.from(
            jsonResponse.map(
                  (order) => Order.fromJson(order),
            ),
          );
        });
      } else {
        print('Failed to load orders. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }


  void _updateOrderStatus(int orderId, bool isDone) async {
    var url = "https://bestbakery77.000webhostapp.com/updateOrderStatus.php";

    try {
      var response = await http.post(
        Uri.parse(url),
        body: {'order_id': orderId.toString(), 'is_done': isDone ? '1' : '0'}, // Convert boolean to '1' or '0'
      );

      if (response.statusCode == 200) {
        print('Order status updated successfully');
        // You might want to update the local state as well
        setState(() {
          orders.firstWhere((order) => order.id == orderId).isDone = isDone;
        });
      } else {
        print('Failed to update order status. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
