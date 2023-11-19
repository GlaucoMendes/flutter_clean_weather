import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_weather/core/extensions/double_extension.dart';
import 'package:flutter_clean_weather/domain/entities/current_condition.dart';
import 'package:flutter_clean_weather/presentation/home/cubits/condition/current_condition_cubit.dart';
import 'package:lottie/lottie.dart';

class CurrentConditionWidget extends StatelessWidget {
  const CurrentConditionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentConditionCubit, CurrentConditionState>(
      builder: (context, state) {
        const loading = Center(child: CircularProgressIndicator());
        return switch (state) {
          CurrentConditionInitialState() => loading,
          CurrentConditionLoadingState() => loading,
          CurrentConditionSuccessState() => _CurrentConditionSuccessWidget(state.condition),
          CurrentConditionErrorState() => Text(state.failure.toString()),
        };
      },
    );
  }
}

class _CurrentConditionSuccessWidget extends StatelessWidget {
  final CurrentCondition condition;
  const _CurrentConditionSuccessWidget(this.condition);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (condition.weatherIcon != null)
          Lottie.asset(
            condition.weatherIcon!.asset,
            height: 100,
          ),
        Text(condition.weatherText, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        Text(condition.temperature.fahrenheitToCelsius(), style: Theme.of(context).textTheme.titleLarge),
      ],
    );
  }
}
