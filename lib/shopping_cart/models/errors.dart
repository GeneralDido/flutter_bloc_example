sealed class ShoppingCartErrorType {
  const ShoppingCartErrorType();
}

class UnkownShoppingCartErrorType extends ShoppingCartErrorType {
  final Object? error; 
  final StackTrace trace;

  const UnkownShoppingCartErrorType({
    required this.error,
    required this.trace,
  });
}

// Indicates a network error
class NetworkShoppingCartErrorType extends ShoppingCartErrorType {
  final Object? error; 
  final StackTrace trace;

  const NetworkShoppingCartErrorType({
    required this.error,
    required this.trace,
  });
}