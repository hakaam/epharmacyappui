
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/category.dart';

class CategoryProvider extends ChangeNotifier {
  List<CategoryModel> _categories = [];

  List<CategoryModel> get categories => _categories;

  Future<void> fetchCategories() async {
    try {
      // Fetch the data from Firestore
      QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('categories').get();

      // Extract the data and update the list of categories
      List<CategoryModel> fetchedCategories =
      snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>; // Add type casting here
        return CategoryModel(
          name: data['name'] ?? '',
          imageUrl: data['image'] ?? '',
        );
      }).toList();

      _categories = fetchedCategories;

      notifyListeners();
    } catch (error) {
      print('Error fetching categories: $error');
    }
  }


}