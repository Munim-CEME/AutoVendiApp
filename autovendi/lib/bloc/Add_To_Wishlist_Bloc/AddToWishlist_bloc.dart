
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'AddToWishlist_state.dart';
part 'AddToWishlist_event.dart';

class AddToWishlistBloc extends Bloc<AddToWishlistEvent, AddToWishlistState> {
  // final Repository _repository;
  // StreamSubscription? streamSubscription;
  // AppPreferences _appPreferences;

  AddToWishlistBloc(
    // Repository? repository, AppPreferences? appPreferences
  )
      //: _repository = repository ?? instance<Repository>(),
      //  _appPreferences = appPreferences ?? instance<AppPreferences>(),
       : super(AddToWishlistLoading()) {
    on<AddedToWishlist>(_AddToWishlist);
    on<LoadAddToWishlistIcon>(_loadAddToWishlistIcon);

  }

  _AddToWishlist(
      AddedToWishlist event, Emitter<AddToWishlistState> emit) {
    emit(const AddedToWishlistState());
  }
  _loadAddToWishlistIcon(
      LoadAddToWishlistIcon event, Emitter<AddToWishlistState> emit) {
    emit(const NotAddedToWishlist());
  }


}
