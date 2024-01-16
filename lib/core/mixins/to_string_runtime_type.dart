/// Mixin to use when want to override [toString] to print [runtimeType] only
mixin ToStringRuntimeTypeMixin {
  @override
  String toString() => "$runtimeType";
}
