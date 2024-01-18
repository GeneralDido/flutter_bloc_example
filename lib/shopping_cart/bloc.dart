import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/core/core.dart';
import 'package:flutter_bloc_example/shopping_cart/models/errors.dart';
import 'package:flutter_bloc_example/shopping_cart/shopping_cart.dart';
import 'package:fpdart/fpdart.dart' hide State;

typedef ShoppingCartLoader = Future<List<ShoppingCartItem>> Function();

class ShoppingCartBloc extends Bloc<ShoppingCartEvent, 
  State<List<ShoppingCartItem>, ShoppingCartErrorType>> {

    final ShoppingCartLoader loader;
    ShoppingCartBloc(
      this.loader,
    )
    : super(const InitState()) {
      on<LoadShoppingCartEvent>(_onLoad);
      on<AddToShoppingCartEvent>(_onAddTo);
      on<RemoveFromShoppingCartEvent>(_onRemoveFrom);
    }

    /// Loads shopping cart items using [loader] and updates state
    Future<void> _onLoad(LoadShoppingCartEvent event,
      Emitter<State<List<ShoppingCartItem>, ShoppingCartErrorType>> emit,
    ) async {
      emit(const LoadingState());
      try {
        emit(DataState(value: await loader()));
      }
      catch (error, trace) {
        emit(ErrorState(error: UnkownShoppingCartErrorType(
          error: error,
          trace: trace,
        )));
      }
    }

    /// Adding [AddToShoppingCartEvent.item] to shopping cart times
    void _onAddTo(
      AddToShoppingCartEvent event,
      Emitter<State<List<ShoppingCartItem>, ShoppingCartErrorType>> emit,
    ) {
      switch(state) {
        case InitState<List<ShoppingCartItem>, ShoppingCartErrorType>():
          return;
        case DataState<List<ShoppingCartItem>, ShoppingCartErrorType>(
          value: final items,
        ):
          return emit(DataState(
            value: List.unmodifiable([
              ...items, 
              event.item
            ]),
          ));
        case ErrorState<List<ShoppingCartItem>, ShoppingCartErrorType>(
          value: final option,
          error: final error,
        ):
          return option.match(
            () => {
              // on no items cart not loaded yet...
            },
          (items) => emit(ErrorState(
            value: Option.of(List.unmodifiable([
              ...items, 
              event.item
            ])),
            error: error,
          )));
        case LoadingState<List<ShoppingCartItem>, ShoppingCartErrorType>(
          value: final option,
        ):
          return option.match(
            () => {
              // on no items cart not loaded yet...
            },
          (items) => emit(LoadingState(
            value: Option.of(List.unmodifiable([
              ...items, 
              event.item
            ])),
          ))
        );
      }
    }

    /// Removes item with [RemoveFromShoppingCartEvent.id] from shopping cart
    void _onRemoveFrom(
      RemoveFromShoppingCartEvent event,
      Emitter<State<List<ShoppingCartItem>, ShoppingCartErrorType>> emit,
    ) {
      switch(state) {
        case InitState<List<ShoppingCartItem>, ShoppingCartErrorType>():
          return;
        case DataState<List<ShoppingCartItem>, ShoppingCartErrorType>(
          value: final items,
        ):
          return emit(DataState(
            value: List.unmodifiable(
              items.where((item) => item.asset.id != event.id)),
          ));
        case ErrorState<List<ShoppingCartItem>, ShoppingCartErrorType>(
          value: final option,
          error: final error,
        ):
          return option.match(
            () => {
              // on no items cart not loaded yet...
            },
          (items) => emit(ErrorState(
            value: Option.of(List.unmodifiable((
              items.where((item) => item.asset.id != event.id)),
          )),
            error: error,
          )));
        case LoadingState<List<ShoppingCartItem>, ShoppingCartErrorType>(
          value: final option,
        ):
          return option.match(
            () => {
              // on no items cart not loaded yet...
            },
          (items) => emit(LoadingState(
            value: Option.of(List.unmodifiable((
              items.where((item) => item.asset.id != event.id)),
          )),
          ))
        );
      }
    }
}