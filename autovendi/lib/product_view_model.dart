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

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  void start() {
    inputCounterStream.add(counter);
  }

  dispose() {
    // TODO: turn the stream controller off
    _counterStreamController.close();
    _priceStreamController.close();
  }

  addToWishlist(Product product) async {
   /* await _firebaseFirestore.collection("products").doc("cart").update({
      'products': {
        'name': product.name,
        'description': product.description,
        'imageUrl': product.imageUrl,
        'price': product.price,
        'quantity': product.quantity,
      }
    });*/

    DocumentSnapshot snapshot = await _firebaseFirestore
        .collection("products")
        .doc("cart")
        .get();

    print("=====================================");
    print(snapshot.data);
    print(Wishlist.fromSnapshot(snapshot));
    print("=====================================");

    Wishlist wishlist = Wishlist.fromSnapshot(snapshot);

    print("========== Wishlist(fromSnapshot)'s output in Rep Imp ==========");

    wishlist.products.add(product);

    print("======== Updated Wishlist ======");
    // print(updatedWishlist);
    print(wishlist);

    await _firebaseFirestore
        .collection("products")
        .doc("cart")
        .update({'products': wishlist.toDocument()});
  }

  decrement() {
    if (counter <= 0) {
      counter = 1;
    } else {
      counter--;
    }

    inputCounterStream.add(counter);
  }

  increment() {
    counter++;
    inputCounterStream.add(counter);
  }

  Sink get inputCounterStream => _counterStreamController.sink;

  Stream<int> get outputCounterStream =>
      _counterStreamController.stream.map((value) => _ifZeroOrLess(value));

  priceMultiplier() {
    final newPrice = price * counter;

    if (counter > 0) {
      inputPriceStream.add(newPrice);
    } else {
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
