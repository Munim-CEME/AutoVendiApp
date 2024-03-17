import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'domain/model/model.dart';

class ProductViewModel {
  final StreamController _counterStreamController = StreamController<int>();
  final StreamController _priceStreamController =
      StreamController<int>(); // TODO: Change the type back to int
  int counter = 1;
  late int price; // TODO: Change the type back to int

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  void start() {
    inputCounterStream.add(counter);
  }

  dispose() {
    // TODO: turn the stream controller off
    _counterStreamController.close();
    _priceStreamController.close();
  }

  Future<bool> addToWishlist(Product product) async {
    /* await _firebaseFirestore.collection("products").doc("cart").update({
      'products': {
        'name': product.name,
        'description': product.description,
        'imageUrl': product.imageUrl,
        'price': product.price,
        'quantity': product.quantity,
      }
    });*/

    DocumentSnapshot snapshot =
        await _firebaseFirestore.collection("products").doc("cart").get();

    print("==============PVM==============");
    print(snapshot['products']);
    print("============PVM===================");

    Wishlist wishlist = Wishlist.fromSnapshot(snapshot);

    for (int i = 0; i < wishlist.products.length; i++) {
      if (wishlist.products[i].name == product.name) {
        return false;
      }
    }

    print("========== Wishlist(fromSnapshot)'s output in Rep Imp ==========");

    wishlist.products.add(product);

    print("======== Updated Wishlist ======");
    // print(updatedWishlist);
    print(wishlist);

    await _firebaseFirestore
        .collection("products")
        .doc("cart")
        .update({'products': wishlist.toDocument()});

    return true;
  }

  decrement(Product product) {
    if (counter <= 0) {
      counter = 1;
    } else {
      counter--;
    }

    changeQuantity(counter, product);
    inputCounterStream.add(counter);
  }

  changeQuantity(int val, Product product) async {
    DocumentSnapshot snapshot =
        await _firebaseFirestore.collection("products").doc("cart").get();

    print("==============Change Quantity==============");
    print(snapshot['products']);
    print("============Change Quantity===================");

    Wishlist wishlist = Wishlist.fromSnapshot(snapshot);

    for (int i = 0; i < wishlist.products.length; i++) {
      if (wishlist.products[i].name == product.name) {
        wishlist.products[i].quantity = val;
        print("==========Updated Quantity===========");
        print(wishlist.products[i].quantity);
        print("==========Updated Quantity===========");
      }
    }

    print("======== Updated Wishlist (Price) ======");
    // print(updatedWishlist);
    print(wishlist);

    await _firebaseFirestore
        .collection("products")
        .doc("cart")
        .update({'products': wishlist.toDocument()});
  }

  increment(Product product) {
    counter++;

    changeQuantity(counter, product);
    inputCounterStream.add(counter);
  }

  changePrice(int price, Product product) async {
    DocumentSnapshot snapshot =
        await _firebaseFirestore.collection("products").doc("cart").get();

    print("==============Change Price==============");
    print(snapshot['products']);
    print("============Change Price===================");

    Wishlist wishlist = Wishlist.fromSnapshot(snapshot);

    for (int i = 0; i < wishlist.products.length; i++) {
      if (wishlist.products[i].name == product.name) {
        wishlist.products[i].price = price;
      }
    }

    print("======== Updated Wishlist (Price)======");
    // print(updatedWishlist);
    print(wishlist);

    await _firebaseFirestore
        .collection("products")
        .doc("cart")
        .update({'products': wishlist.toDocument()});
  }

  Sink get inputCounterStream => _counterStreamController.sink;

  Stream<int> get outputCounterStream =>
      _counterStreamController.stream.map((value) => _ifZeroOrLess(value));

  priceMultiplier(Product product) {
    final newPrice = price * counter;

    if (counter > 0) {
      changePrice(newPrice, product);
      inputPriceStream.add(newPrice);
    } else {
      changePrice(price, product);

      inputPriceStream.add(price);
    }
  }

  Sink get inputPriceStream => _priceStreamController.sink;

  Stream<int> get outputPriceStream =>
      _priceStreamController.stream.map((value) => value);
  // TODO: add Zero and negative values checker

  setPrice(int val) {
    // TODO: Change the type back to int
    price = val;

    inputPriceStream.add(price);
  }

  _ifZeroOrLess(int val) {
    if (val > 0) {
      return val;
    } else {
      return 1;
    }
  }

  /*addToWishlist(List<Product> products) {
    final userID = _getCurrentUser();
  }*/

  _getCurrentUser() async {
    final user = _auth.currentUser!;
    final uid = user.uid;

    print("================User Id================: ");
    print(uid);

    return uid;
  }
}
