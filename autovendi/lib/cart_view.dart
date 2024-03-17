import 'package:autovendi/cart_view_model.dart';
import 'package:autovendi/domain/model/model.dart';
import 'package:autovendi/pin_view.dart';
import 'package:autovendi/resources/color_manager.dart';
import 'package:autovendi/resources/styles_manager.dart';
import 'package:autovendi/resources/values_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final CartViewModel _cartViewModel = CartViewModel();
  late Wishlist wishlist;
  static int totalPrice = 0;

  @override
  void initState() {
    _cartViewModel.getCart();
    totalPrice = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Cart',
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.grey,
      ),
      body: Stack(
        children: [
          StreamBuilder<Wishlist>(
            stream: _cartViewModel.outputWishlistStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                wishlist = snapshot.data!;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final product = wishlist
                        .products[index + 1]; // Start from the second element

                    debugPrint("------------------------------------");

                    totalPrice += product.price;
                    debugPrint("Total Price: $totalPrice");
                    _cartViewModel.inputTPStream.add(totalPrice);
                    debugPrint("------------------------------------");

                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Slidable(
                        startActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          extentRatio: 0.25,
                          openThreshold: 0.25,
                          closeThreshold: 0.25,
                          children: [
                            SlidableAction(
                              onPressed: (context) async {
                                bool checker =
                                    await _cartViewModel.deleteProduct(product);

                                _cartViewModel.getCart();

                                if (checker) {
                                  _showSnackBar(context, "Removed from cart");
                                } else {
                                  _showSnackBar(
                                      context, "Not removed from cart");
                                }
                              },
                              label: "Delete",
                              backgroundColor: ColorManager.primary,
                              foregroundColor: ColorManager.white,
                              borderRadius:
                                  BorderRadius.circular(AppSize.size25),
                            ),
                          ],
                        ),
                        child: Card(
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 4),
                            title: Text(
                              product.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 8),
                                Text(
                                  'Price: ${product.price.toString()}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Quantity: ${product.quantity}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            trailing: Container(
                              width: 100,
                              height: 250,
                              decoration: BoxDecoration(
                                color: ColorManager.primary,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  product.imageUrl,
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: wishlist.products.length - 1, // Adjusted itemCount
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          Positioned(
            bottom: 0,
            child: Column(
              children: [
                Container(
                  color: ColorManager.grey,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, top: 4.0, bottom: 4.0, right: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            "Total Price",
                            style: getSemiBoldStyle(
                              color: ColorManager.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        StreamBuilder<int>(
                            stream: _cartViewModel.outputTPStream,
                            builder: (context, snapshot) {
                              if (snapshot.data != null) {
                                return Text(
                                  snapshot.data.toString(),
                                  style: getSemiBoldStyle(
                                    color: ColorManager.white,
                                    fontSize: 16,
                                  ),
                                );
                              } else {
                                return Text(
                                  "Loading...",
                                  style: getSemiBoldStyle(
                                    color: ColorManager.white,
                                    fontSize: 16,
                                  ),
                                );
                              }
                            }),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PinView()),
                    );
                  },
                  child: Container(
                    color: ColorManager.black,
                    width: MediaQuery.of(context).size.width,
                    height: 70,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, top: 4.0, bottom: 4.0, right: 4.0),
                      child: Center(
                        child: Text(
                          "Place Order",
                          style: getSemiBoldStyle(
                            color: ColorManager.white,
                            fontSize: 32,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        content: Center(
          child: Text(
            message,
            style: TextStyle(
              color: ColorManager.white,
              fontSize: AppSize.size18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 100,
            right: 20,
            left: 20),
        duration: const Duration(seconds: 2),
        dismissDirection: DismissDirection.down,
        backgroundColor: ColorManager.grey2,
      ),
    );
  }
}
