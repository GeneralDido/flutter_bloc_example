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

// it's like we wrote it inside the State class
extension StateExtension<T, E> on State<T, E> {
  bool get isInit => this is InitState<T, E>;

  bool get isData => this is DataState<T, E>;

  bool get isError => this is ErrorState<T, E>;

  bool get isLoading => this is LoadingState<T, E>;

  // T is the Data model, E is the Error
  State<T, E> map(T Function(T) mapper) {
    switch (this) {
      case InitState<T, E>():
        return this;

      case DataState<T, E>(
        value: final value,
      ):
        return DataState(
          value: mapper(value),
        );

      case ErrorState<T, E>(
          value: final option,
          error: final error,
        ):
        return option.match(
          () => this,
          (data) => ErrorState(
            value: Option.of(mapper(data)),
            error: error,
          ),
        );

      case LoadingState<T, E>(
          value: final option,
        ):
        return option.match(
          () => this,
          (data) => LoadingState(
            value: Option.of(mapper(data)),
          ),
        );
    }
  }

}
  