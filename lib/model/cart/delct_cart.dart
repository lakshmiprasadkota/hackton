import 'dart:convert';

DelCart delCartFromMap(String str) => DelCart.fromMap(json.decode(str));

String delCartToMap(DelCart data) => json.encode(data.toMap());

class DelCart {
  DelCart({
    this.message,
  });

  String message;

  factory DelCart.fromMap(Map<String, dynamic> json) => DelCart(
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toMap() => {
    "message": message == null ? null : message,
  };
}
