// health_education_event.dart
// Events for health education screen BLoC
import 'package:equatable/equatable.dart';

abstract class HealthEducationEvent extends Equatable {
  const HealthEducationEvent();

  @override
  List<Object> get props => [];
}

class LoadHealthEducationCategories extends HealthEducationEvent {}

class SelectEducationCategory extends HealthEducationEvent {
  final int categoryIndex;

  const SelectEducationCategory(this.categoryIndex);

  @override
  List<Object> get props => [categoryIndex];
}

class SelectArticle extends HealthEducationEvent {
  final int categoryIndex;
  final int articleIndex;

  const SelectArticle(this.categoryIndex, this.articleIndex);

  @override
  List<Object> get props => [categoryIndex, articleIndex];
}

class BackToCategories extends HealthEducationEvent {}

class BackToArticles extends HealthEducationEvent {}
