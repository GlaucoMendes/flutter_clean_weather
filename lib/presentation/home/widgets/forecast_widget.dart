import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_weather/core/core.dart';
import 'package:flutter_clean_weather/domain/entities/forecast.dart';
import 'package:flutter_clean_weather/presentation/home/cubit/forecast_cubit.dart';

class ForecastWidget extends StatelessWidget {
  const ForecastWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForecastCubit, ForecastState>(
      builder: (context, state) {
        const loading = Center(child: CircularProgressIndicator());

        return switch (state) {
          ForecastInitialState() => loading,
          ForecastLoadingState() => loading,
          ForecastSuccessState() => _ForecastSuccessWidget(state.forecast),
          ForecastErrorState() => Text(state.failure.toString()),
        };
      },
    );
  }
}

class _ForecastSuccessWidget extends StatelessWidget {
  final Forecast forecast;
  const _ForecastSuccessWidget(this.forecast);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(),
          Text(context.l10n.helloWorld),
        ],
      ),
    );
  }
}
