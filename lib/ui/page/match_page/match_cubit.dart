import 'package:bloc/bloc.dart';
import 'package:tournament/model/tournament.dart';

part 'match_state.dart';

class MatchCubit extends Cubit<MatchState> {
  MatchCubit(Tournament tournament) : super(MatchState(tournament));

  void expandInstruction()=>
    emit(state.copyWith(isInstructionExpanded:!state.isInstructionExpanded ));

  void expandDescription() =>
      emit(state.copyWith(isDescriptionExpanded: !state.isDescriptionExpanded));
}
