import 'package:autovendi/product_view_model.dart';
import 'package:autovendi/resources/color_manager.dart';
import 'package:autovendi/resources/strings_manager.dart';
import 'package:autovendi/resources/styles_manager.dart';
import 'package:autovendi/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'bloc/Add_To_Wishlist_Bloc/AddToWishlist_bloc.dart';
import 'counter_button.dart';
import 'menu_view_model.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  final ProductViewModel _productViewModel = ProductViewModel();

  @override
  void initState() {
    super.initState();

    _bind();
  }

  _bind() {
    _productViewModel.start();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    _productViewModel
        .setPrice(productProvider.product.price); // TODO: Remove the Type Cast

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height * 0.65,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    // TODO: Change the color scheme, and save it to the respected directories
                    Colors.grey.withOpacity(1),
                    Colors.grey.withOpacity(0.4),
                    Colors.grey.withOpacity(0.1),
                    Colors.grey.withOpacity(0),
                  ]),
            ),
            // TODO: Set the image
          ),
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height * 0.4,
            child: Image.network(
              productProvider.product.imageUrl,
              // TODO: Check the width and the height of the images that will be added
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.4,
            ),
          ),
          SingleChildScrollView(
            physics:
            const ClampingScrollPhysics(),
            // TODO: Change the scroll physics to bounce with imageSize incr and dec with scroll
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.3,
                ),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.8,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:  BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          left: 8,
                          right: 8,
                        ),
                        child: Text(
                          productProvider.product.name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                          /*getBoldStyle(
                              color: ColorManager.black, fontSize: 30),*/
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          left: 8,
                          right: 8,
                        ),
                        child: Text(
                          productProvider.product.description,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            left: MediaQuery
                .of(context)
                .size
                .width * 0.05,
            right: MediaQuery
                .of(context)
                .size
                .width * 0.05,
            child: SafeArea(
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.9,
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.08,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    CounterButton(
                        iconData: Icons.remove,
                        onPressed: () {
                          _productViewModel.decrement();
                          _productViewModel.priceMultiplier();
                        }),
                    StreamBuilder<int>(
                      stream: _productViewModel.outputCounterStream,
                      builder:
                          (BuildContext context, AsyncSnapshot<int> snapshot) {
                        return Text(
                          "${snapshot.data}",
                          style: getSemiBoldStyle(
                              color: ColorManager.white,
                              fontSize: AppSize.size18),
                        );
                      },
                    ),
                    CounterButton(
                        iconData: Icons.add,
                        onPressed: () {
                          _productViewModel.increment();
                          _productViewModel.priceMultiplier();
                        }),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: AppPadding.padding8,
                            top: AppPadding.padding8,
                            bottom: AppPadding.padding8),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSize.size12),
                            color: ColorManager.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: AppPadding.padding8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppPadding.padding8,
                                    vertical: AppPadding.padding4,
                                  ),
                                  child: StreamBuilder<int>(
                                    // TODO: Change the stream type back to int
                                    stream: _productViewModel.outputPriceStream,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<int> snapshot) {
                                      return Text(
                                        'Rs. ${snapshot.data}',
                                        overflow: TextOverflow.ellipsis,
                                        style: getSemiBoldStyle(
                                            color: ColorManager.black,
                                            fontSize: AppSize.size18),
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: AppPadding.padding8,
                                      vertical: AppPadding.padding4),
                                  child: GestureDetector(
                                    onTap: () {
                                      _productViewModel.addToWishlist(productProvider.product);
                                    },
                                    child: BlocBuilder<AddToWishlistBloc,
                                        AddToWishlistState>(
                                      builder: (BuildContext context, state) {
                                        if (state is AddedToWishlistState) {
                                          return Expanded(
                                            child: Text(
                                              AppStrings.viewCart,
                                              style: getSemiBoldStyle(
                                                  color: ColorManager.primary),
                                            ),
                                          );
                                        }
                                        if (state is NotAddedToWishlist) {
                                          return Icon(
                                            Icons.add_shopping_cart_outlined,
                                            color: ColorManager.black,
                                          );
                                        } else {
                                          return const Text(
                                              AppStrings.errorOnBloc);
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


}