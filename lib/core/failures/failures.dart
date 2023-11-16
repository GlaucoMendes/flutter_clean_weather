part of '../core.dart';

sealed class Failure implements Exception {}

class UnknownFailure extends Failure {
  final String? message;

  UnknownFailure({this.message});
}
