// To parse this JSON data, do
//
//     final delectProduct = delectProductFromMap(jsonString);
import 'dart:convert';

DelCategory delCategoryFromMap(String str) => DelCategory.fromMap(json.decode(str));

String delCategoryToMap(DelCategory data) => json.encode(data.toMap());

class DelCategory {
  DelCategory({
    this.message,
  });

  String message;

  factory DelCategory.fromMap(Map<String, dynamic> json) => DelCategory(
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toMap() => {
    "message": message == null ? null : message,
  };
}
