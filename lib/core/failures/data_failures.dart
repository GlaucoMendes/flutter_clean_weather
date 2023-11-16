part of '../core.dart';

class RequestFailure implements Failure {
  final int? statusCode;

  RequestFailure({required this.statusCode});

  @override
  String toString() => 'RequestFailure (Status Code: $statusCode)';
}

class EmptyDataFailure implements Failure {}

class DtoConversionFailure implements Failure {
  final String message;

  DtoConversionFailure({this.message = 'Failed to convert DTO'});

  @override
  String toString() => 'DtoConversionFailure: $message';
}

class UnexpectedDataFormatFailure implements Failure {}
