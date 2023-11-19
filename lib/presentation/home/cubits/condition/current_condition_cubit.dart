import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'current_condition_state.dart';

class CurrentConditionCubit extends Cubit<CurrentConditionState> {
  CurrentConditionCubit() : super(CurrentConditionInitial());
}
