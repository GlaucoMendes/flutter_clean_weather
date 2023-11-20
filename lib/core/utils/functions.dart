part of '../core.dart';

T safeFromJson<T>(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
  try {
    return fromJsonT(json);
  } catch (e) {
    throw DtoConversionFailure();
  }
}

void waitFrame(VoidCallback callback) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    callback();
  });
}
