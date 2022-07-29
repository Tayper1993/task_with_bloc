import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task1/models.dart';

import '../api.dart';

part 'screen_person_details_event.dart';
part 'screen_person_details_state.dart';

class MyBloc extends Bloc<ScreenPersonDetailsEvent, ScreenPersonDetailsState> {
  final Api _api;
  MyBloc(this._api) : super(ScreenPersonDetailsInitialState()) {
    on<PersonDetailsLoadEvent>(_onPersonDetailsEvent);
  }

  Future<void> _onPersonDetailsEvent(PersonDetailsLoadEvent event,
      Emitter<ScreenPersonDetailsState> emit) async {
    try {
      emit(ScreenPersonDetailsLoadingState());
      final result = await _api.loadPersonDetails(event.id.toString());
      emit(ScreenPersonDetailsLoadedState(result));
    } catch (e) {
      emit(ScreenPersonDetailsErrorState(e.toString()));
    }
  }
}
