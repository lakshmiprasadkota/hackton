// To parse this JSON data, do
//
//     final getproductsowmya = getproductsowmyaFromMap(jsonString);

import 'dart:convert';

List<Getproductsowmya> getproductsowmyaFromMap(String str) => List<Getproductsowmya>.from(json.decode(str).map((x) => Getproductsowmya.fromMap(x)));

String getproductsowmyaToMap(List<Getproductsowmya> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Getproductsowmya {
  Getproductsowmya({
    this.productId,
    this.productName,
    this.productPrice,
    this.categoryId,
    this.categoryName,
    this.imageUrl,
  });

  int productId;
  String productName;
  int productPrice;
  int categoryId;
  String categoryName;
  String imageUrl;

  factory Getproductsowmya.fromMap(Map<String, dynamic> json) => Getproductsowmya(
    productId: json["product_id"] == null ? null : json["product_id"],
    productName: json["product_name"] == null ? null : json["product_name"],
    productPrice: json["product_price"] == null ? null : json["product_price"],
    categoryId: json["category_id"] == null ? null : json["category_id"],
    categoryName: json["category_name"] == null ? null : json["category_name"],
    imageUrl: json["image_url"] == null ? null : json["image_url"],
  );

  Map<String, dynamic> toMap() => {
    "product_id": productId == null ? null : productId,
    "product_name": productName == null ? null : productName,
    "product_price": productPrice == null ? null : productPrice,
    "category_id": categoryId == null ? null : categoryId,
    "category_name": categoryName == null ? null : categoryName,
    "image_url": imageUrl == null ? null : imageUrl,
  };
}
