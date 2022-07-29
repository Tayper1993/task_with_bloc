part of 'screen_person_details_bloc.dart';

@immutable
abstract class ScreenPersonDetailsEvent {}

class PersonDetailsLoadEvent extends ScreenPersonDetailsEvent {
  final int id;
  PersonDetailsLoadEvent(this.id);
}
