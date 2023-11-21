import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/core.dart';
import '../../../../domain/entities/location.dart';
import '../../../../domain/usecases/locations/get_location_by_string_usecase.dart';

part 'location_list_state.dart';

class LocationListCubit extends Cubit<LocationListState> {
  final GetLocationByStringUsecase _getLocationByStringUsecase;
  LocationListCubit(this._getLocationByStringUsecase) : super(LocationListInitialState());

  Future<void> getLocationByString(String text) async {
    emit(LocationListLoadingState());
    final result = await _getLocationByStringUsecase(text);
    result.when(
      (success) => emit(LocationListSuccessState(success)),
      (error) => emit(LocationListErrorState(error)),
    );
  }
}
