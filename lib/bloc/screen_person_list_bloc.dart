import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task1/api.dart';
import 'package:tuple/tuple.dart';

part 'screen_person_list_event.dart';
part 'screen_person_list_state.dart';

class MyBlocList extends Bloc<ScreenPersonListEvent, ScreenPersonListState> {
  final Api _api;
  MyBlocList(this._api) : super(ScreenPersonListInitialState()) {
    on<PersonListLoadEvent>(_onPersonListEvent);
  }

  Future<void> _onPersonListEvent(
      PersonListLoadEvent event, Emitter<ScreenPersonListState> emit) async {
    try {
      emit(ScreenPersonListLoadingState());
      final result = await _api.loadPersonList(event.id);
      emit(ScreenPersonListLoadedState(result));
    } catch (e) {
      emit(ScreenPersonListErrorState(e.toString()));
    }
  }
}
