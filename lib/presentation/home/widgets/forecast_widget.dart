import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_weather/core/core.dart';
import 'package:flutter_clean_weather/core/extensions/double_extension.dart';
import 'package:flutter_clean_weather/domain/entities/forecast.dart';
import 'package:flutter_clean_weather/presentation/home/cubits/forecast/forecast_cubit.dart';
import 'package:lottie/lottie.dart';

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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            context.l10n.nDaysForecast(forecast.dailyForecasts.length.toString()),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            itemCount: forecast.dailyForecasts.length,
            itemBuilder: (context, index) {
              final day = forecast.dailyForecasts[index];
              return Row(
                children: [
                  const Spacer(),
                  SizedBox(
                    width: 50,
                    child: (day.date.day == DateTime.now().toTimeZone.day)
                        ? Text(context.l10n.today, textAlign: TextAlign.center)
                        : Text(
                            day.date.weekdayName(context).capitalize.substring(0, 3),
                            textAlign: TextAlign.center,
                          ),
                  ),
                  const SizedBox(width: 16),
                  Row(
                    children: [
                      if (day.iconDay != null)
                        Lottie.asset(
                          day.iconDay!.asset,
                          width: 32,
                          height: 32,
                          fit: BoxFit.cover,
                        ),
                      const SizedBox(width: 8),
                      Text(day.maxTemp.fahrenheitToCelsius()),
                      const SizedBox(width: 8),
                      const Text('/'),
                      const SizedBox(width: 8),
                      Text(day.minTemp.fahrenheitToCelsius()),
                      const SizedBox(width: 8),
                      if (day.iconNight != null)
                        Lottie.asset(
                          day.iconNight!.asset,
                          width: 32,
                          height: 32,
                          fit: BoxFit.cover,
                        ),
                    ],
                  ),
                  const Spacer(flex: 2),
                ],
              );
            },
            separatorBuilder: (context, index) => const Divider(thickness: 0.5),
          ),
        ],
      ),
    );
  }
}
