import 'package:flutter_bloc_example/shopping_cart/models/item.dart';

sealed class ShoppingCartEvent {
  const ShoppingCartEvent();
}

// Emit on request to load shopping cart Event
class LoadShoppingCartEvent extends ShoppingCartEvent {
  const LoadShoppingCartEvent();
}

// Emit on add [item] to shopping cart Event
class AddToShoppingCartEvent extends ShoppingCartEvent {
  final ShoppingCartItem item;

  const AddToShoppingCartEvent({
    required this.item,
  });
}

// Emit on remove item [id] from shopping cart Event
class RemoveFromShoppingCartEvent extends ShoppingCartEvent {
  final String id;

  const RemoveFromShoppingCartEvent({
    required this.id,
  });
}

// Emit on clear shopping cart Event
class ClearShoppingCartEvent extends ShoppingCartEvent {
  const ClearShoppingCartEvent();
}

// Emit on purchase shopping cart Event
class PurchaseShoppingCartEvent extends ShoppingCartEvent {
  const PurchaseShoppingCartEvent();
}
