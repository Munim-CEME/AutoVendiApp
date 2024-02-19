import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'domain/model/model.dart';

class MenuViewModel {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final StreamController _wishlistStreamController = StreamController<Wishlist>.broadcast();

  void start() {
    fetchProducts();
  }

  void dispose() {}

  void fetchProducts() async {
    DocumentSnapshot snapshot = await _firebaseFirestore
        .collection("products")
        .doc("products")
        .get();

    print("=====================================");
    print(snapshot.data);
    print(Wishlist.fromSnapshot(snapshot));
    print("=====================================");

    Wishlist wishlist = Wishlist.fromSnapshot(snapshot);

    inputWishlistStream.add(wishlist);



  }

  Stream<Wishlist> get outputWishlistStream => _wishlistStreamController.stream.map((data) => data);

  Sink get inputWishlistStream => _wishlistStreamController.sink;

}

class ProductProvider extends ChangeNotifier {
  late Product _product;

  //TODO: make sure that the product provider does not have a value before updateProduct is called!

  Product get product => _product;

  updateProduct(Product newProduct) {
    _product = newProduct;
    print('===========INDEX FROM PROVIDER=======');
    print(newProduct);
    // notifyListeners();
  }
}
