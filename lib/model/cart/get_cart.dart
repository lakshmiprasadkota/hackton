// To parse this JSON data, do
//
//     final getCart = getCartFromMap(jsonString);

import 'dart:convert';

List<GetCart> getCartFromMap(String str) => List<GetCart>.from(json.decode(str).map((x) => GetCart.fromMap(x)));

String getCartToMap(List<GetCart> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class GetCart {
  GetCart({
    this.cartId,
    this.categoryId,
    this.productId,
    this.name,
    this.quantity,
    this.price,
    this.discount,
    this.totalPrice,
    this.image,
  });

  int cartId;
  int categoryId;
  int productId;
  String name;
  int quantity;
  double price;
  double discount;
  double totalPrice;
  dynamic image;

  factory GetCart.fromMap(Map<String, dynamic> json) => GetCart(
    cartId: json["cart_id"] == null ? null : json["cart_id"],
    categoryId: json["category_id"] == null ? null : json["category_id"],
    productId: json["product_id"] == null ? null : json["product_id"],
    name: json["name"] == null ? null : json["name"],
    quantity: json["quantity"] == null ? null : json["quantity"],
    price: json["price"] == null ? null : json["price"],
    discount: json["discount"] == null ? null : json["discount"],
    totalPrice: json["total_price"] == null ? null : json["total_price"],
    image: json["image"],
  );

  Map<String, dynamic> toMap() => {
    "cart_id": cartId == null ? null : cartId,
    "category_id": categoryId == null ? null : categoryId,
    "product_id": productId == null ? null : productId,
    "name": name == null ? null : name,
    "quantity": quantity == null ? null : quantity,
    "price": price == null ? null : price,
    "discount": discount == null ? null : discount,
    "total_price": totalPrice == null ? null : totalPrice,
    "image": image,
  };
}
