part of 'forecast_cubit.dart';

sealed class ForecastState {}

final class ForecastInitialState extends ForecastState {}

final class ForecastLoadingState extends ForecastState {}

final class ForecastSuccessState extends ForecastState {
  final Forecast forecast;

  ForecastSuccessState(this.forecast);
}

final class ForecastErrorState extends ForecastState {
  final Failure failure;

  ForecastErrorState(this.failure);
}
