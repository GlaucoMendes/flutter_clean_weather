part of 'location_cubit.dart';

sealed class LocationState {}

final class LocationInitialState extends LocationState {}

final class LocationLoadingState extends LocationState {}

final class LocationSuccessState extends LocationState {
  final Location location;

  LocationSuccessState(this.location);
}

final class LocationErrorState extends LocationState {
  final Failure failure;

  LocationErrorState(this.failure);
}
