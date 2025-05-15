import 'package:flutter/foundation.dart';

abstract class Result<T> {
  const Result();
  factory Result.success(T data) => Success<T>(data);
  factory Result.failed(String error) => Failure(error);

}

class Success<T> extends Result<T> {
  final T data;

  Success(this.data);
}
class Failure<T> extends Result<T> {
  final String error;

  Failure(this.error);
}
