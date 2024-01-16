import 'package:flutter_bloc_example/core/error_type.dart';
import 'package:flutter_bloc_example/core/mixins/to_string_error.dart';
import 'package:flutter_bloc_example/core/mixins/to_string_runtime_type.dart';

class ProfileErrorType with ToStringRuntimeTypeMixin, ToStringErrorMixin implements ErrorType {
  @override
  final Object error;
  @override
  final StackTrace trace;

  const ProfileErrorType({
    required this.error,
    required this.trace,
  });
}

class UnknownProfileErrorType extends ProfileErrorType {
  const UnknownProfileErrorType({
    required super.error,
    required super.trace,
  });
}
