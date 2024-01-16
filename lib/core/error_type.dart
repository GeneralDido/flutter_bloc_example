/// Base error type, all errors should implement it
abstract class ErrorType {
  Object get error;

  StackTrace get trace;
}
