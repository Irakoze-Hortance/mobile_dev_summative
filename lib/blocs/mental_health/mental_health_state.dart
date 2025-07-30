// mental_health_state.dart
// States for mental health screen BLoC
import 'package:equatable/equatable.dart';

abstract class MentalHealthState extends Equatable {
  const MentalHealthState();

  @override
  List<Object> get props => [];
}

class MentalHealthInitial extends MentalHealthState {}

class MentalHealthLoading extends MentalHealthState {}

class MentalHealthLoaded extends MentalHealthState {
  final List<Map<String, dynamic>> resources;
  final List<Map<String, dynamic>> emergencyContacts;
  final int? selectedResourceIndex;
  final bool isEmergencyContactsExpanded;

  const MentalHealthLoaded({
    required this.resources,
    required this.emergencyContacts,
    this.selectedResourceIndex,
    this.isEmergencyContactsExpanded = false,
  });

  @override
  List<Object> get props => [
    resources,
    emergencyContacts,
    selectedResourceIndex ?? -1,
    isEmergencyContactsExpanded,
  ];

  MentalHealthLoaded copyWith({
    List<Map<String, dynamic>>? resources,
    List<Map<String, dynamic>>? emergencyContacts,
    int? selectedResourceIndex,
    bool? isEmergencyContactsExpanded,
  }) {
    return MentalHealthLoaded(
      resources: resources ?? this.resources,
      emergencyContacts: emergencyContacts ?? this.emergencyContacts,
      selectedResourceIndex: selectedResourceIndex ?? this.selectedResourceIndex,
      isEmergencyContactsExpanded: isEmergencyContactsExpanded ?? this.isEmergencyContactsExpanded,
    );
  }
}

class MentalHealthError extends MentalHealthState {
  final String message;

  const MentalHealthError(this.message);

  @override
  List<Object> get props => [message];
}
