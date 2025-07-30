// health_education_bloc.dart
// BLoC for handling health education screen logic
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'health_education_event.dart';
import 'health_education_state.dart';

class HealthEducationBloc extends Bloc<HealthEducationEvent, HealthEducationState> {
  HealthEducationBloc() : super(HealthEducationInitial()) {
    on<LoadHealthEducationCategories>(_onLoadHealthEducationCategories);
    on<SelectEducationCategory>(_onSelectEducationCategory);
    on<SelectArticle>(_onSelectArticle);
    on<BackToCategories>(_onBackToCategories);
    on<BackToArticles>(_onBackToArticles);
  }

  late List<Map<String, dynamic>> _categories;

  void _onLoadHealthEducationCategories(
    LoadHealthEducationCategories event,
    Emitter<HealthEducationState> emit,
  ) async {
    emit(HealthEducationLoading());

    try {
      // Simulate loading data - in real app, this would come from a service/repository
      await Future.delayed(const Duration(milliseconds: 500));

      _categories = [
        {
          'title': 'Nutrition & Diet',
          'description': 'Learn about healthy eating habits',
          'icon': Icons.restaurant,
          'color': Colors.green,
          'articles': [
            {
              'title': 'Balanced Diet Basics',
              'content': 'A balanced diet includes a variety of foods from all food groups: fruits, vegetables, grains, protein, and dairy. Aim for colorful plates and proper portions.',
              'readTime': '3 min read'
            },
            {
              'title': 'Hydration Importance',
              'content': 'Staying hydrated is crucial for bodily functions. Aim for 8 glasses of water daily, more if you\'re active or in hot weather.',
              'readTime': '2 min read'
            },
            {
              'title': 'Meal Planning Tips',
              'content': 'Plan your meals ahead to ensure nutritious choices. Prep ingredients on weekends and include variety in your weekly menu.',
              'readTime': '4 min read'
            },
          ]
        },
        {
          'title': 'Exercise & Fitness',
          'description': 'Physical activity for better health',
          'icon': Icons.fitness_center,
          'color': Colors.orange,
          'articles': [
            {
              'title': 'Getting Started with Exercise',
              'content': 'Begin with 150 minutes of moderate aerobic activity weekly. Start slowly and gradually increase intensity and duration.',
              'readTime': '3 min read'
            },
            {
              'title': 'Strength Training Benefits',
              'content': 'Resistance training builds muscle, improves bone density, and boosts metabolism. Include 2-3 sessions per week.',
              'readTime': '4 min read'
            },
            {
              'title': 'Flexibility and Stretching',
              'content': 'Regular stretching improves flexibility, reduces injury risk, and helps with recovery. Include 10-15 minutes daily.',
              'readTime': '2 min read'
            },
          ]
        },
        {
          'title': 'Preventive Care',
          'description': 'Prevention is better than cure',
          'icon': Icons.health_and_safety,
          'color': Colors.blue,
          'articles': [
            {
              'title': 'Regular Health Screenings',
              'content': 'Schedule annual check-ups, blood pressure monitoring, cholesterol checks, and age-appropriate screenings like mammograms.',
              'readTime': '3 min read'
            },
            {
              'title': 'Vaccination Importance',
              'content': 'Stay up-to-date with recommended vaccines including flu shots, COVID-19 boosters, and travel-specific immunizations.',
              'readTime': '2 min read'
            },
            {
              'title': 'Early Detection Signs',
              'content': 'Know warning signs for common conditions. Seek medical attention for persistent symptoms or concerning changes.',
              'readTime': '4 min read'
            },
          ]
        },
        {
          'title': 'Sleep & Recovery',
          'description': 'Quality sleep for optimal health',
          'icon': Icons.bedtime,
          'color': Colors.purple,
          'articles': [
            {
              'title': 'Sleep Hygiene Basics',
              'content': 'Maintain consistent sleep schedule, create comfortable environment, limit screen time before bed, and avoid caffeine late in day.',
              'readTime': '3 min read'
            },
            {
              'title': 'Understanding Sleep Cycles',
              'content': 'Adults need 7-9 hours of sleep. Sleep occurs in cycles including REM and deep sleep phases, both crucial for health.',
              'readTime': '4 min read'
            },
            {
              'title': 'Managing Sleep Disorders',
              'content': 'Common sleep disorders include insomnia, sleep apnea, and restless leg syndrome. Consult healthcare providers for persistent issues.',
              'readTime': '5 min read'
            },
          ]
        },
      ];

      emit(HealthEducationCategoriesLoaded(_categories));
    } catch (e) {
      emit(HealthEducationError('Failed to load health education categories'));
    }
  }

  void _onSelectEducationCategory(
    SelectEducationCategory event,
    Emitter<HealthEducationState> emit,
  ) {
    if (event.categoryIndex < _categories.length) {
      emit(HealthEducationArticlesLoaded(_categories[event.categoryIndex], event.categoryIndex));
    }
  }

  void _onSelectArticle(
    SelectArticle event,
    Emitter<HealthEducationState> emit,
  ) {
    if (event.categoryIndex < _categories.length) {
      final category = _categories[event.categoryIndex];
      final articles = category['articles'] as List<Map<String, dynamic>>;
      
      if (event.articleIndex < articles.length) {
        emit(HealthEducationArticleSelected(
          articles[event.articleIndex],
          category,
          event.categoryIndex,
          event.articleIndex,
        ));
      }
    }
  }

  void _onBackToCategories(
    BackToCategories event,
    Emitter<HealthEducationState> emit,
  ) {
    emit(HealthEducationCategoriesLoaded(_categories));
  }

  void _onBackToArticles(
    BackToArticles event,
    Emitter<HealthEducationState> emit,
  ) {
    final currentState = state;
    if (currentState is HealthEducationArticleSelected) {
      emit(HealthEducationArticlesLoaded(currentState.category, currentState.categoryIndex));
    }
  }
}
