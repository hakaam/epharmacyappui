class ProductModel {
  final String productImage;
  final String productName; // Should be a non-nullable String type
  final double productPrice;
  final double productOldPrice;
  final String productDescription;

  ProductModel({
    required this.productImage,
    required this.productName,
    required this.productPrice,
    required this.productOldPrice,
    required this.productDescription,
  });
}