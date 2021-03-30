// To parse this JSON data, do
//
//     final getcategory = getcategoryFromMap(jsonString);

import 'dart:convert';

List<Getcategory> getcategoryFromMap(String str) => List<Getcategory>.from(json.decode(str).map((x) => Getcategory.fromMap(x)));

String getcategoryToMap(List<Getcategory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Getcategory {
  Getcategory({
    this.categoryId,
    this.categoryName,
    this.categoryImage,
    this.products,
  });

  int categoryId;
  String categoryName;
  String categoryImage;
  List<Product> products;

  factory Getcategory.fromMap(Map<String, dynamic> json) => Getcategory(
    categoryId: json["category_id"] == null ? null : json["category_id"],
    categoryName: json["category_name"] == null ? null : json["category_name"],
    categoryImage: json["category_image"] == null ? null : json["category_image"],
    products: json["products"] == null ? null : List<Product>.from(json["products"].map((x) => Product.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "category_id": categoryId == null ? null : categoryId,
    "category_name": categoryName == null ? null : categoryName,
    "category_image": categoryImage == null ? null : categoryImage,
    "products": products == null ? null : List<dynamic>.from(products.map((x) => x.toMap())),
  };
}

class Product {
  Product({
    this.productId,
    this.productName,
    this.productDescription,
    this.productPrice,
    this.productDiscount,
    this.productRating,
    this.productImage,
  });

  int productId;
  String productName;
  String productDescription;
  double productPrice;
  double productDiscount;
  double productRating;
  String productImage;

  factory Product.fromMap(Map<String, dynamic> json) => Product(
    productId: json["product_id"] == null ? null : json["product_id"],
    productName: json["product_name"] == null ? null : json["product_name"],
    productDescription: json["product_description"] == null ? null : json["product_description"],
    productPrice: json["product_price"] == null ? null : json["product_price"],
    productDiscount: json["product_discount"] == null ? null : json["product_discount"],
    productRating: json["product_rating"] == null ? null : json["product_rating"],
    productImage: json["product_image"] == null ? null : json["product_image"],
  );

  Map<String, dynamic> toMap() => {
    "product_id": productId == null ? null : productId,
    "product_name": productName == null ? null : productName,
    "product_description": productDescription == null ? null : productDescription,
    "product_price": productPrice == null ? null : productPrice,
    "product_discount": productDiscount == null ? null : productDiscount,
    "product_rating": productRating == null ? null : productRating,
    "product_image": productImage == null ? null : productImage,
  };
}
