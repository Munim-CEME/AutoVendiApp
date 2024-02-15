part of 'AddToWishlist_bloc.dart';

abstract class AddToWishlistState extends Equatable {
   const AddToWishlistState();

  @override
  List<Object?> get props => [];
}

class AddToWishlistLoading extends AddToWishlistState {}

class NotAddedToWishlist extends AddToWishlistState {
  const NotAddedToWishlist();

  @override
  List<Object?> get props => [];
}


class AddedToWishlistState extends AddToWishlistState {
  const AddedToWishlistState();

  @override
  List<Object?> get props => [];
}
