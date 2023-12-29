import 'package:customizedcake/product.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
void updateProducts(Function(bool success) update) async{
  try{
    final url=Uri.https(_baseURL, 'getProducts.php');
    final response=await http.get(url).timeout(const Duration(seconds:5));
    prodcuts.clear();
    if(response.statusCode==200){
      final jsonResponse=convert.jsonDecode(response.body);
      for(var row in jsonResponse){
        product p=product(
            int.parse(row['id']),
            row['name'],
            int.parse(row['price']),
            row['image_url'],
            int.parse(row['category_id']);
            products.add(p);
      }
      update(true);
    }
  }
  catch(e){
    update(false);}
}
class getProducts extends StatelessWidget {
  getProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    return ListView.builder(
        itemCount: products.length,
        itemBuilder:(context, index)=>Column(children: [
        const SizedBox(height:10),
    Container(
    color:index%2==0 ? Colors.amber: Colors.cyan,
    padding: const EdgeInsets.all(5),
    width:width*0.9, child:Row(children:[
    SizedBox(width:width*0.15),
    Flexible(child:Text(products[index].toString(), style:TextStyle(fontSize: width*0.045)
    )
    )
  ]
  )
  )
  ]
  )
  );
}
}
