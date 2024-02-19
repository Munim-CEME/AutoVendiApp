import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Product {
  final String name;
  final String description;
  final String imageUrl;
  final int price;
  int quantity = 1;

  Product(this.name, this.description, this.imageUrl, this.price, this.quantity);

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      json['name'],
      json['description'],
      json['imageUrl'],
      json['price'],
      json['quantity'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description,
    'imageUrl': imageUrl,
    'price': price,
    'quantity': quantity,
  };

  factory Product.fromSnapshot(Map<String, dynamic> snap) {
    return Product(
      snap['name'],
      snap['description'],
      snap['imageUrl'],
      snap['price'],
      snap['quantity'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'quantity': quantity,
    };
  }


}

class Wishlist extends Equatable {
  final List<Product> products;

  const Wishlist({required this.products});

  @override
  List<Object?> get props {
    return [products];
  }

  Wishlist copyWith({
    List<Product>? products,
  }) {
    return Wishlist(
      products: products ?? this.products,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'wishlist': products!.map(
            (product) {
          return product.toDocument();
        },
      ).toList(),
    };
  }

  String toJson() => json.encode(toDocument());

  // factory RestaurantOne.fromJson(String source) => RestaurantOne.fromMap(json.decode(source));

  factory Wishlist.fromSnapshot(DocumentSnapshot snap) {

    return Wishlist(
        products: (snap['products'] as List).map((product) {
          print("=========================================================================");
          print("Product from snapshot: $product");
          print("=========================================================================");
          return Product.fromSnapshot(product);}).toList()
      // snap['wishlist'] returns the map from the firebase, the map has 'wishlist' key and a list as value, so to access
      // the value, which is a list, we use ['wishlist']
    );
  }
}