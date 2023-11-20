import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_weather/core/core.dart';
import 'package:flutter_clean_weather/domain/entities/forecast.dart';
import 'package:flutter_clean_weather/domain/usecases/forecast/get_forecast_by_id_usecase.dart';

part 'forecast_state.dart';

class ForecastCubit extends Cubit<ForecastState> {
  final GetForecastByIdUsecase _getForecastByIdUsecase;
  ForecastCubit(this._getForecastByIdUsecase) : super(ForecastInitialState());

  Future<void> getForecastById(String id) async {
    emit(ForecastLoadingState());
    final result = await _getForecastByIdUsecase(id);
    result.when(
      (forecast) => emit(ForecastSuccessState(forecast)),
      (failure) => emit(ForecastErrorState(failure)),
    );
  }
}
