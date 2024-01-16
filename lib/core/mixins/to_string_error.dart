import 'package:flutter_bloc_example/core/error_type.dart';

/// Mixin to use when want to include [error] in [toString]
mixin ToStringErrorMixin {
  Object? get error;

  @override
  String toString() => "${super.toString()} (error: $error)";
}

/// Mixin to use when want to include [ErrorType] [type] in [toString]
mixin ToStringErrorTypeMixin<T extends ErrorType> {
  T get type;

  @override
  String toString() => "${super.toString()} (type: $type)";
}
