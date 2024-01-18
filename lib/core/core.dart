import 'package:fpdart/fpdart.dart';

sealed class State<T, E> {
  const State();

  @override
  String toString() => "$runtimeType";
}

class InitState<T, E> extends State<T, E> {
  const InitState();

  @override
  int get hashCode => 0;

  @override
  bool operator ==(Object other) => other is InitState<T, E>;
}

class DataState<T, E> extends State<T, E> {
  final T value;

  const DataState({
    required this.value,
  });

  @override
  int get hashCode => value.hashCode;

  @override
  bool operator ==(Object other) =>
      other is DataState<T, E> && value == other.value;

  @override
  String toString() => "${super.toString()} (value: $value)";
}

class ErrorState<T, E> extends State<T, E> {
  final Option<T> value;
  final E error;

  const ErrorState({
    this.value = const Option.none(),
    required this.error,
  });

  @override
  int get hashCode => value.hashCode ^ error.hashCode;

  @override
  bool operator ==(Object other) =>
      other is ErrorState<T, E> && value == other.value && error == other.error;

  @override
  String toString() => "${super.toString()} (value: $value, error: $error)";
}

class LoadingState<T, E> extends State<T, E> {
  final Option<T> value;

  const LoadingState({
    this.value = const Option.none(),
  });

  @override
  int get hashCode => value.hashCode;

  @override
  bool operator ==(Object other) =>
      other is LoadingState<T, E> && value == other.value;

  @override
  String toString() => "${super.toString()} (value: $value)";
}