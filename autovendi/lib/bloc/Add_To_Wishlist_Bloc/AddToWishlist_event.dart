part of 'AddToWishlist_bloc.dart';

abstract class AddToWishlistEvent extends Equatable {
   const AddToWishlistEvent();

  @override
  List<Object?> get props => [];
}

class LoadAddToWishlistIcon extends AddToWishlistEvent {

  const LoadAddToWishlistIcon();

  @override
  List<Object?> get props => [];
}

class AddedToWishlist extends AddToWishlistEvent {

   const AddedToWishlist();

  @override
  List<Object?> get props => [];
}



