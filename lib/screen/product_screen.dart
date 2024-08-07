
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ques1/model/product_model.dart';
import 'package:ques1/screen/product_detail_screen.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}
   
  

  Future<ProductsModel> getProductsApi() async{
    final response =await http.get(Uri.parse("https://dummyjson.com/products"));
    var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200){
      return ProductsModel.fromJson(data);

    }else{
      return ProductsModel.fromJson(data);

    }

  }

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<ProductsModel>(
              future: getProductsApi(), 
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3, // Number of columns in the grid
    crossAxisSpacing: 8.0, // Spacing between columns
    mainAxisSpacing: 8.0, // Spacing between rows
    childAspectRatio: 0.75, // Adjust the aspect ratio to fit your design
  ),
  itemCount: snapshot.data!.products!.length,
  itemBuilder: (context, index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductsDetailScreen(
              productImage: snapshot.data!.products![index].images![0].toString(),
              title: snapshot.data!.products![index].title.toString(),
              description: snapshot.data!.products![index].description.toString(),
              price: snapshot.data!.products![index].price.toString(),
              category: snapshot.data!.products![index].category.toString(),
            ),
          ),
        );
      },
      child: Card(
        elevation: 2.0,
        margin: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.0,
              child: Image.network(
                snapshot.data!.products![index].images![0].toString(),
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    snapshot.data!.products![index].title.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.0),
                 Text(
                   "\$${snapshot.data!.products![index].price.toString()}",
                            style: TextStyle(
                                   color: Colors.grey[600],
                              ),
                          ),

                   SizedBox(height: 4.0),
                  Text(
                    snapshot.data!.products![index].brand.toString(),
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                      SizedBox(height: 4.0),
                  Text(
                    snapshot.data!.products![index].returnPolicy.toString(),
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  },
);

                     }else{
                  return Center(child: CircularProgressIndicator());
                }
                

              }), 

          )
        ],
      ),
    );
  }
}