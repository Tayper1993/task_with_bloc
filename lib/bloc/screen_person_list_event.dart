part of 'screen_person_list_bloc.dart';

@immutable
abstract class ScreenPersonListEvent {}

class PersonListLoadEvent extends ScreenPersonListEvent {
  final int id;
  PersonListLoadEvent(this.id);
}
