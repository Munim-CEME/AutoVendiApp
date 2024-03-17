import 'package:autovendi/cart_view.dart';
import 'package:autovendi/product_view.dart';
import 'package:autovendi/resources/color_manager.dart';
import 'package:autovendi/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'domain/model/model.dart';
import 'menu_view_model.dart';

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  MenuViewModel _menuViewModel = MenuViewModel();

  @override
  void initState() {
    _menuViewModel.start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Stack(
      children: [
        Opacity(
          opacity: 0.5,
          child: Image.asset(
            'assets/isoview.png',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.grey,
            actions: [
              Padding(
                  padding: const EdgeInsets.only(right: AppPadding.padding12),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CartView()),
                      );
                    },
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      color: ColorManager.white,
                      size: AppSize.size25,
                    ),
                  ))
            ],
          ),
          body: SingleChildScrollView(
            child: StreamBuilder<Wishlist>(
              stream: _menuViewModel.outputWishlistStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return _getProduct(
                      snapshot.data!.products, context, productProvider);
                } else {
                  return const Center(
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Colors.grey,
                    )),
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}

Widget _getProduct(List<Product> products, BuildContext context,
    ProductProvider productProvider) {
  return Padding(
    padding: const EdgeInsets.only(
      left: 12,
      right: 12,
      bottom: 12,
    ),
    child: Flex(
      direction: Axis.vertical,
      children: [
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          children: List.generate(products.length, (index) {
            return Padding(
              padding: const EdgeInsets.all(12),
              child: GestureDetector(
                onTap: () {
                  productProvider.updateProduct(products[index]);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProductView()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 10,
                          // blurStyle: BlurStyle.values,
                          offset: const Offset(5, 0),
                          spreadRadius: 1,
                        ),
                        BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 10,
                          // blurStyle: BlurStyle.values,
                          offset: const Offset(-5, 0),
                          spreadRadius: 1,
                        ),
                      ]),
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            products[index].imageUrl,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        products[index].name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      /*getBoldStyle(
                            color: ColorManager.black,
                            fontSize: FontSize.size14,
                            fontFamily: FontConstants.fontFamily_3),
                      ),*/
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Rs. ${products[index].price.toString()}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),

                      /*getRegularStyle(
                            color: ColorManager.black,
                            fontSize: FontSize.size14,
                            fontFamily: FontConstants.fontFamily_3),
                      ),*/
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        )
      ],
    ),
  );
}
