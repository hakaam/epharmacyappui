import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductDetails extends StatelessWidget {
  final ProductModel product;

  const ProductDetails({required this.product});

  @override
  Widget build(BuildContext context) {
    List<ProductModel> relatedProducts = []; // Replace this with your actual list of related products

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Product Details',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 25,
            fontWeight: FontWeight.bold

          ),
        ),


      ),

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Stack(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.red,
                  child: Image.network(
                    product.productImage,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 250,
                        color: Colors.grey, // Placeholder color
                      );
                    },
                  ),
                ),


                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.favorite,
                      size: 25,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                product.productName,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  product.productDescription,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${product.productPrice}',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$${product.productOldPrice}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: SizedBox(
                height: 50,
                width: 250,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () {},
                  child: Text(
                    'Add To Cart',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),

          ],
        ),
      ),
    );
  }
}
