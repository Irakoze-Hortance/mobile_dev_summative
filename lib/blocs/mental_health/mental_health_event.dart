// mental_health_event.dart
// Events for mental health screen BLoC
import 'package:equatable/equatable.dart';

abstract class MentalHealthEvent extends Equatable {
  const MentalHealthEvent();

  @override
  List<Object> get props => [];
}

class LoadMentalHealthResources extends MentalHealthEvent {}

class SelectMentalHealthResource extends MentalHealthEvent {
  final int resourceIndex;

  const SelectMentalHealthResource(this.resourceIndex);

  @override
  List<Object> get props => [resourceIndex];
}

class ExpandEmergencyContacts extends MentalHealthEvent {}

class CollapseEmergencyContacts extends MentalHealthEvent {}
