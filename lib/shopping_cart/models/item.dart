class ShoppingCartItem {
  final num amount;
  final Asset asset;

  const ShoppingCartItem({
    required this.amount,
    required this.asset,
  });

  @override
  int get hashCode => amount.hashCode ^ asset.hashCode;

  @override
  bool operator ==(Object other) =>
      other is ShoppingCartItem &&
      amount == other.amount &&
      asset == other.asset;
  
  @override
  String toString() => "${super.toString()} (amount: $amount, Asset: $Asset)";
}

class Asset {
  final String id;
  final String value;

  const Asset({
    required this.id,
    required this.value,
  });

  @override
  int get hashCode => id.hashCode ^ value.hashCode;

  @override
  bool operator ==(Object other) =>
      other is Asset &&
      id == other.id &&
      value == other.value;

  @override
  String toString() => "${super.toString()} (id: $id, value: $value)";
}