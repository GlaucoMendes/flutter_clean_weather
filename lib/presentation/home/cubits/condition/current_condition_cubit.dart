import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/core.dart';
import '../../../../domain/entities/current_condition.dart';
import '../../../../domain/usecases/conditions/get_current_condition_usecase.dart';

part 'current_condition_state.dart';

class CurrentConditionCubit extends Cubit<CurrentConditionState> {
  final GetCurrentConditionUsecase _getCurrentConditionUsecase;
  CurrentConditionCubit(this._getCurrentConditionUsecase) : super(CurrentConditionInitialState());

  Future<void> getCurrentCondition(String id) async {
    emit(CurrentConditionLoadingState());
    final result = await _getCurrentConditionUsecase(id);
    result.when(
      (condition) => emit(CurrentConditionSuccessState(condition)),
      (failure) => emit(CurrentConditionErrorState(failure)),
    );
  }
}
