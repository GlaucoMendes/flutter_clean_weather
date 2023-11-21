import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/core.dart';
import '../../../../domain/entities/forecast.dart';
import '../../../../domain/usecases/forecast/get_forecast_by_id_usecase.dart';

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
