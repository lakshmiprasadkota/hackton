
import 'dart:convert';

Getproduct getproductFromMap(String str) => Getproduct.fromMap(json.decode(str));

String getproductToMap(Getproduct data) => json.encode(data.toMap());

class Getproduct {
  Getproduct({
    this.products,
    this.page,
    this.limit,
    this.count,
  });

  List<Products> products;
  int page;
  int limit;
  int count;

  factory Getproduct.fromMap(Map<String, dynamic> json) => Getproduct(
    products: json["products"] == null ? null : List<Products>.from(json["products"].map((x) => Products.fromMap(x))),
    page: json["page"] == null ? null : json["page"],
    limit: json["limit"] == null ? null : json["limit"],
    count: json["count"] == null ? null : json["count"],
  );

  Map<String, dynamic> toMap() => {
    "products": products == null ? null : List<dynamic>.from(products.map((x) => x.toMap())),
    "page": page == null ? null : page,
    "limit": limit == null ? null : limit,
    "count": count == null ? null : count,
  };
}

class Products {
  Products({
    this.productId,
    this.productName,
    this.productDescription,
    this.productPrice,
    this.productDiscount,
    this.productRating,
    this.productImage,
    this.categoryId,
    this.categoryName,
  });

  int productId;
  String productName;
  String productDescription;
  double productPrice;
  double productDiscount;
  double productRating;
  String productImage;
  int categoryId;
  String categoryName;

  factory Products.fromMap(Map<String, dynamic> json) => Products(
    productId: json["product_id"] == null ? null : json["product_id"],
    productName: json["product_name"] == null ? null : json["product_name"],
    productDescription: json["product_description"] == null ? null : json["product_description"],
    productPrice: json["product_price"] == null ? null : json["product_price"],
    productDiscount: json["product_discount"] == null ? null : json["product_discount"],
    productRating: json["product_rating"] == null ? null : json["product_rating"],
    productImage: json["product_image"] == null ? null : json["product_image"],
    categoryId: json["category_id"] == null ? null : json["category_id"],
    categoryName: json["category_name"] == null ? null : json["category_name"],
  );

  Map<String, dynamic> toMap() => {
    "product_id": productId == null ? null : productId,
    "product_name": productName == null ? null : productName,
    "product_description": productDescription == null ? null : productDescription,
    "product_price": productPrice == null ? null : productPrice,
    "product_discount": productDiscount == null ? null : productDiscount,
    "product_rating": productRating == null ? null : productRating,
    "product_image": productImage == null ? null : productImage,
    "category_id": categoryId == null ? null : categoryId,
    "category_name": categoryName == null ? null : categoryName,
  };
}
