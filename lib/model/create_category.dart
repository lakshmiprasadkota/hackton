import 'dart:convert';

CreateCategory createCategoryFromMap(String str) => CreateCategory.fromMap(json.decode(str));

String createCategoryToMap(CreateCategory data) => json.encode(data.toMap());

class CreateCategory {
  CreateCategory({
    this.message,
  });

  String message;

  factory CreateCategory.fromMap(Map<String, dynamic> json) => CreateCategory(
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toMap() => {
    "message": message == null ? null : message,
  };
}