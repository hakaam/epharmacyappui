import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gogorideapp/models/product_model.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> _products = [];

  List<ProductModel> get products => _products;

  Future<void> fetchProducts() async {
    try {
      // Fetch the data from Firestore
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('products')
          .get();

      // Extract the data and update the list of products
      List<ProductModel> fetchedProducts = snapshot.docs.map((doc) {
        Map<String, dynamic> data = (doc.data() as Map<String, dynamic>);
        return ProductModel(
          productImage: data['image'] as String? ?? '',
          productName: data['name'] as String? ?? '',
          productPrice: (data['price'] as double?) ?? 0.0,
          productOldPrice: (data['oldPrice'] as double?) ?? 0.0,
          productDescription: data['description'] as String? ?? '',
        );
      }).toList();

      _products = fetchedProducts;

      notifyListeners();
    } catch (error) {
      print('Error fetching products: $error');
    }
  }}