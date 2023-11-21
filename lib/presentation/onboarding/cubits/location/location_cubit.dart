import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/core.dart';
import '../../../../domain/entities/location.dart';
import '../../../../domain/usecases/locations/get_location_by_geoposition_usecase.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final GetLocationByGeoPositionUsecase _getLocationByGeoPositionUsecase;
  LocationCubit(this._getLocationByGeoPositionUsecase) : super(LocationInitialState());

  Future<void> getLocation(double lat, double long) async {
    emit(LocationLoadingState());
    final result = await _getLocationByGeoPositionUsecase(lat, long);
    result.when(
      (location) => emit(LocationSuccessState(location)),
      (failure) => emit(LocationErrorState(failure)),
    );
  }
}
