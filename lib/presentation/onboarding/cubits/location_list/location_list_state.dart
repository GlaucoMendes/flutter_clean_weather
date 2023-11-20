part of 'location_list_cubit.dart';

sealed class LocationListState {}

final class LocationListInitialState extends LocationListState {}

final class LocationListLoadingState extends LocationListState {}

final class LocationListSuccessState extends LocationListState {
  final List<Location> locations;

  LocationListSuccessState(this.locations);
}

final class LocationListErrorState extends LocationListState {
  final Failure failure;

  LocationListErrorState(this.failure);
}
