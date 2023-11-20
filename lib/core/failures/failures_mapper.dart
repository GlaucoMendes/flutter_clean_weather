part of '../core.dart';

class FailureMapper {
  static String map(Failure failure) {
    if (failure is RequestFailure) {
      return 'RequestFailure (Status code ${failure.statusCode})';
    } else if (failure is EmptyDataFailure) {
      return 'EmptyDataFailure';
    } else if (failure is DtoConversionFailure) {
      return 'DtoConversionFailure';
    } else if (failure is UnexpectedDataFormatFailure) {
      return 'UnexpectedDataFormatFailure';
    } else {
      return 'UnknownFailure';
    }
  }
}
