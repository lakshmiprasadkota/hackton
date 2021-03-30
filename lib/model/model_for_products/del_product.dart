// To parse this JSON data, do
//
//     final delProduct = delProductFromMap(jsonString);

import 'dart:convert';

DelProduct delProductFromMap(String str) => DelProduct.fromMap(json.decode(str));

String delProductToMap(DelProduct data) => json.encode(data.toMap());

class DelProduct {
  DelProduct({
    this.message,
  });

  String message;

  factory DelProduct.fromMap(Map<String, dynamic> json) => DelProduct(
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toMap() => {
    "message": message == null ? null : message,
  };
}
