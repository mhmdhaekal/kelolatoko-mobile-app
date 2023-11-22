// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  List<ProductElement> products;
  int count;

  Product({
    required this.products,
    required this.count,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        products: List<ProductElement>.from(
            json["products"].map((x) => ProductElement.fromJson(x))),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "count": count,
      };
}

class ProductElement {
  String id;
  String name;
  String description;
  int price;
  int stock;
  int sold;
  dynamic categoryName;

  ProductElement({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.sold,
    required this.categoryName,
  });

  factory ProductElement.fromJson(Map<String, dynamic> json) => ProductElement(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        stock: json["stock"],
        sold: json["sold"],
        categoryName: json["category__name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "stock": stock,
        "sold": sold,
        "category__name": categoryName,
      };
}
