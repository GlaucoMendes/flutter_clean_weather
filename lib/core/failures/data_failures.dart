part of '../core.dart';

class RequestFailure implements Failure {
  final int? statusCode;

  RequestFailure({this.statusCode});
}

class EmptyDataFailure implements Failure {}

class DtoConversionFailure implements Failure {}

class UnexpectedDataFormatFailure implements Failure {}
