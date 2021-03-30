
import 'dart:convert';

UpdateProduct updateProductFromMap(String str) => UpdateProduct.fromMap(json.decode(str));

String updateProductToMap(UpdateProduct data) => json.encode(data.toMap());

class UpdateProduct {
  UpdateProduct({
    this.message,
  });

  String message;

  factory UpdateProduct.fromMap(Map<String, dynamic> json) => UpdateProduct(
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toMap() => {
    "message": message == null ? null : message,
  };
}
