import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../core/extensions/double_extension.dart';
import '../../../domain/entities/current_condition.dart';
import '../cubits/condition/current_condition_cubit.dart';

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
    final weatherIcon = condition.weatherIcon;
    final assetIcon = condition.assetIcon;
    return Column(
      children: [
        if (weatherIcon != null) Lottie.asset(weatherIcon.asset, height: 100),
        if (assetIcon != null) Image.asset(assetIcon, height: 100, fit: BoxFit.fill),
        const SizedBox(height: 8),
        Text(condition.weatherText, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        Text(condition.temperature.fahrenheitToCelsius(), style: Theme.of(context).textTheme.titleLarge),
      ],
    );
  }
}
