import 'dart:convert';

CreteProduct creteProductFromMap(String str) => CreteProduct.fromMap(json.decode(str));

String creteProductToMap(CreteProduct data) => json.encode(data.toMap());

class CreteProduct {
  CreteProduct({
    this.message,
  });

  String message;

  factory CreteProduct.fromMap(Map<String, dynamic> json) => CreteProduct(
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toMap() => {
    "message": message == null ? null : message,
  };
}
