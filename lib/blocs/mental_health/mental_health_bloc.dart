// mental_health_bloc.dart
// BLoC for handling mental health screen logic
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'mental_health_event.dart';
import 'mental_health_state.dart';

class MentalHealthBloc extends Bloc<MentalHealthEvent, MentalHealthState> {
  MentalHealthBloc() : super(MentalHealthInitial()) {
    on<LoadMentalHealthResources>(_onLoadMentalHealthResources);
    on<SelectMentalHealthResource>(_onSelectMentalHealthResource);
    on<ExpandEmergencyContacts>(_onExpandEmergencyContacts);
    on<CollapseEmergencyContacts>(_onCollapseEmergencyContacts);
  }

  void _onLoadMentalHealthResources(
    LoadMentalHealthResources event,
    Emitter<MentalHealthState> emit,
  ) async {
    emit(MentalHealthLoading());

    try {
      // Simulate loading data - in real app, this would come from a service/repository
      await Future.delayed(const Duration(milliseconds: 500));

      final resources = [
        {
          'title': 'Anxiety Management',
          'description': 'Learn techniques to manage anxiety and stress',
          'icon': Icons.spa,
          'color': Colors.blue,
          'content': [
            'Deep breathing exercises',
            'Progressive muscle relaxation',
            'Mindfulness meditation',
            'Grounding techniques',
            'Cognitive behavioral strategies'
          ]
        },
        {
          'title': 'Depression Support',
          'description': 'Resources and strategies for depression',
          'icon': Icons.favorite,
          'color': Colors.pink,
          'content': [
            'Understanding depression symptoms',
            'Daily routine building',
            'Social support strategies',
            'Professional help guidance',
            'Self-care activities'
          ]
        },
        {
          'title': 'Stress Relief',
          'description': 'Effective stress management techniques',
          'icon': Icons.self_improvement,
          'color': Colors.green,
          'content': [
            'Time management skills',
            'Relaxation techniques',
            'Physical exercise benefits',
            'Sleep hygiene',
            'Work-life balance'
          ]
        },
        {
          'title': 'Mindfulness & Meditation',
          'description': 'Practice mindfulness for better mental health',
          'icon': Icons.psychology,
          'color': Colors.purple,
          'content': [
            'Basic meditation techniques',
            'Mindful breathing',
            'Body scan meditation',
            'Walking meditation',
            'Loving-kindness meditation'
          ]
        },
      ];

      final emergencyContacts = [
        {
          'name': 'National Suicide Prevention Lifeline',
          'number': '988',
          'description': '24/7 crisis support'
        },
        {
          'name': 'Crisis Text Line',
          'number': 'Text HOME to 741741',
          'description': 'Free, 24/7 support via text'
        },
        {
          'name': 'SAMHSA National Helpline',
          'number': '1-800-662-4357',
          'description': 'Mental health and substance abuse'
        },
      ];

      emit(MentalHealthLoaded(
        resources: resources,
        emergencyContacts: emergencyContacts,
      ));
    } catch (e) {
      emit(MentalHealthError('Failed to load mental health resources'));
    }
  }

  void _onSelectMentalHealthResource(
    SelectMentalHealthResource event,
    Emitter<MentalHealthState> emit,
  ) {
    final currentState = state;
    if (currentState is MentalHealthLoaded) {
      emit(currentState.copyWith(selectedResourceIndex: event.resourceIndex));
    }
  }

  void _onExpandEmergencyContacts(
    ExpandEmergencyContacts event,
    Emitter<MentalHealthState> emit,
  ) {
    final currentState = state;
    if (currentState is MentalHealthLoaded) {
      emit(currentState.copyWith(isEmergencyContactsExpanded: true));
    }
  }

  void _onCollapseEmergencyContacts(
    CollapseEmergencyContacts event,
    Emitter<MentalHealthState> emit,
  ) {
    final currentState = state;
    if (currentState is MentalHealthLoaded) {
      emit(currentState.copyWith(isEmergencyContactsExpanded: false));
    }
  }
}
