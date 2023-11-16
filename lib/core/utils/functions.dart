part of '../core.dart';

T safeFromJson<T>(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
  try {
    return fromJsonT(json);
  } catch (_) {
    throw DtoConversionFailure();
  }
}
