import 'dart:convert';

UpdateCategory updateCategoryFromMap(String str) => UpdateCategory.fromMap(json.decode(str));

String updateCategoryToMap(UpdateCategory data) => json.encode(data.toMap());

class UpdateCategory {
  UpdateCategory({
    this.message,
  });

  String message;

  factory UpdateCategory.fromMap(Map<String, dynamic> json) => UpdateCategory(
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toMap() => {
    "message": message == null ? null : message,
  };
}
