part of 'current_condition_cubit.dart';

sealed class CurrentConditionState {}

final class CurrentConditionInitialState extends CurrentConditionState {}

final class CurrentConditionLoadingState extends CurrentConditionState {}

final class CurrentConditionSuccessState extends CurrentConditionState {
  final CurrentCondition condition;
  CurrentConditionSuccessState(this.condition);
}

final class CurrentConditionErrorState extends CurrentConditionState {
  final Failure failure;
  CurrentConditionErrorState(this.failure);
}
