import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_weather/core/core.dart';
import 'package:flutter_clean_weather/domain/entities/location.dart';
import 'package:flutter_clean_weather/domain/usecases/locations/get_location_by_geoposition_usecase.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final GetLocationByGeoPositionUsecase getLocationByGeoPositionUsecase;
  LocationCubit(this.getLocationByGeoPositionUsecase) : super(LocationInitialState());

  Future<void> getLocation(double lat, double long) async {
    emit(LocationLoadingState());
    final result = await getLocationByGeoPositionUsecase(lat, long);
    result.when(
      (location) => emit(LocationSuccessState(location)),
      (failure) => emit(LocationErrorState(failure)),
    );
  }
}
