part of 'screen_person_details_bloc.dart';

@immutable
abstract class ScreenPersonDetailsState {}

class ScreenPersonDetailsInitialState extends ScreenPersonDetailsState {}

class ScreenPersonDetailsLoadingState extends ScreenPersonDetailsState {}

class ScreenPersonDetailsLoadedState extends ScreenPersonDetailsState {
  final PersonDetails list;
  ScreenPersonDetailsLoadedState(this.list);
}

class ScreenPersonDetailsErrorState extends ScreenPersonDetailsState {
  late final String message;
  ScreenPersonDetailsErrorState(this.message);
}
