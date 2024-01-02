import 'CustomizationDetails.dart';

class Order {
  final int id;
  final String customerName;
  final String customerAddress;
  final String productName;
  final int productPrice;
  final int quantity;
  final DateTime date;
  final CustomizationDetails? customizationDetails;
  bool? isDone; // Make it nullable

  Order({
    required this.id,
    required this.customerName,
    required this.customerAddress,
    required this.productName,
    required this.productPrice,
    required this.quantity,
    required this.date,
    required this.customizationDetails,
    this.isDone, // Make it nullable
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    final customizationDetailsJson = json['customization_details'];
    return Order(
      id: int.parse(json['id'].toString()),
      customerName: json['customer_name'] as String,
      customerAddress: json['customer_address'] as String,
      productName: json['product_name'] as String,
      productPrice: int.parse(json['product_price'].toString()),
      quantity: int.parse(json['quantity'].toString()),
      date: DateTime.parse(json['date'].toString()),
      customizationDetails: customizationDetailsJson != null
          ? CustomizationDetails.fromJson(customizationDetailsJson)
          : null,
      isDone: json['is_done'] == 1, // Assuming 1 represents true in your database
    );
  }
}
