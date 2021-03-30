// To parse this JSON data, do
//
//     final postCart = postCartFromMap(jsonString);

import 'dart:convert';

PostCart postCartFromMap(String str) => PostCart.fromMap(json.decode(str));

String postCartToMap(PostCart data) => json.encode(data.toMap());

class PostCart {
  PostCart({
    this.message,
  });

  String message;

  factory PostCart.fromMap(Map<String, dynamic> json) => PostCart(
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toMap() => {
    "message": message == null ? null : message,
  };
}
