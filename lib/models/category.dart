import 'dart:convert';

class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }
}

List<Category> categoriesFromJson(String str) =>
    List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));