// To parse this JSON data, do
//
//     final productsEntry = productsEntryFromJson(jsonString);

import 'dart:convert';

List<ProductsEntry> productsEntryFromJson(String str) => List<ProductsEntry>.from(json.decode(str).map((x) => ProductsEntry.fromJson(x)));

String productsEntryToJson(List<ProductsEntry> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductsEntry {
    dynamic userId;
    String id;
    String name;
    int price;
    String description;
    String? thumbnail;
    String category;
    bool isFeatured;
    int stock;
    String brand;
    String size;
    int productViews;
    DateTime createdAt;

    ProductsEntry({
        required this.userId,
        required this.id,
        required this.name,
        required this.price,
        required this.description,
        required this.thumbnail,
        required this.category,
        required this.isFeatured,
        required this.stock,
        required this.brand,
        required this.size,
        required this.productViews,
        required this.createdAt,
    });

    factory ProductsEntry.fromJson(Map<String, dynamic> json) => ProductsEntry(
        userId: json["user_id"],
        id: json["id"],
        name: json["name"],
        price: json["price"],
        description: json["description"],
        thumbnail: json["thumbnail"],
        category: json["category"],
        isFeatured: json["is_featured"],
        stock: json["stock"],
        brand: json["brand"],
        size: json["size"].toString(),
        productViews: json["product_views"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "id": id,
        "name": name,
        "price": price,
        "description": description,
        "thumbnail": thumbnail,
        "category": category,
        "is_featured": isFeatured,
        "stock": stock,
        "brand": brand,
        "size": size,
        "product_views": productViews,
        "created_at": createdAt.toIso8601String(),
    };
}
