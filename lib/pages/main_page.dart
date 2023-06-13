import 'package:flutter/material.dart';
import 'package:gogorideapp/pages/product_details.dart';
import 'package:provider/provider.dart';

import '../models/category.dart';
import '../models/product_model.dart';
import '../services/category_provider.dart';
import '../services/product_provider.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CategoryProvider>(context, listen: false).fetchCategories();
    Provider.of<ProductProvider>(context, listen: false).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);

    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Card(
              elevation: 1,
              child: SizedBox(
                // height: height * 0.99,
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        size: 20,
                        color: Colors.black,
                      ),
                      suffixIcon: Icon(
                        Icons.tune,
                      ),
                      hintText: 'Search Product',
                      hintStyle: TextStyle(color: Colors.black, fontSize: 18),
                      contentPadding: EdgeInsets.only(top: 12)),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                // ...
                itemCount: categoryProvider.categories.length,
                itemBuilder: (context, index) {
                  CategoryModel category = categoryProvider.categories[index];
                  return Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        CircleAvatar(
                          child: Image.network(
                            category.imageUrl,
                            fit: BoxFit.cover,
                            height: 130,
                            width: 130,
                          ),
                        ),
                        Text(
                          category.name,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Products",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "See All",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Consumer<ProductProvider>(
              builder: (context, productProvider, _) {
                if (productProvider.products.isEmpty) {
                  // If products haven't been fetched yet, show a loading indicator or placeholder
                  return CircularProgressIndicator();
                } else {
                  // Products have been fetched, display them in the GridView.builder
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 3,
                    ),
                    itemCount: productProvider.products.length,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      ProductModel product = productProvider.products[index];

                      return Padding(
                        padding: const EdgeInsets.all(2),
                        child: GestureDetector(
                          onTap:() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetails(product: product),
                              ),
                            );



                          },




                          child: Card(

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 20,
                            child: Container(

                              height: 160,
                              width: 170,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  Image.network(
                                    product.productImage,
                                    fit: BoxFit.fitHeight,
                                    height: 150,
                                  ),
                                  Center(
                                    child: Text(
                                      product.productName,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "\$${product.productPrice}",
                                          style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "\$${product.productOldPrice}",
                                          style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),

            // Your existing code...
          ],
        ),
      ),
    );
  }
}
