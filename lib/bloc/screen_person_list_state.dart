part of 'screen_person_list_bloc.dart';

@immutable
abstract class ScreenPersonListState {}

class ScreenPersonListInitialState extends ScreenPersonListState {}

class ScreenPersonListLoadingState extends ScreenPersonListState {}

class ScreenPersonListLoadedState extends ScreenPersonListState {
  final Tuple2 list;
  ScreenPersonListLoadedState(this.list);
}

class ScreenPersonListErrorState extends ScreenPersonListState {
  late final String message;
  ScreenPersonListErrorState(this.message);
}
