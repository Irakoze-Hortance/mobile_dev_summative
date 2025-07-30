// health_education_state.dart
// States for health education screen BLoC
import 'package:equatable/equatable.dart';

abstract class HealthEducationState extends Equatable {
  const HealthEducationState();

  @override
  List<Object> get props => [];
}

class HealthEducationInitial extends HealthEducationState {}

class HealthEducationLoading extends HealthEducationState {}

class HealthEducationCategoriesLoaded extends HealthEducationState {
  final List<Map<String, dynamic>> categories;

  const HealthEducationCategoriesLoaded(this.categories);

  @override
  List<Object> get props => [categories];
}

class HealthEducationArticlesLoaded extends HealthEducationState {
  final Map<String, dynamic> selectedCategory;
  final int categoryIndex;

  const HealthEducationArticlesLoaded(this.selectedCategory, this.categoryIndex);

  @override
  List<Object> get props => [selectedCategory, categoryIndex];
}

class HealthEducationArticleSelected extends HealthEducationState {
  final Map<String, dynamic> selectedArticle;
  final Map<String, dynamic> category;
  final int categoryIndex;
  final int articleIndex;

  const HealthEducationArticleSelected(
    this.selectedArticle,
    this.category,
    this.categoryIndex,
    this.articleIndex,
  );

  @override
  List<Object> get props => [selectedArticle, category, categoryIndex, articleIndex];
}

class HealthEducationError extends HealthEducationState {
  final String message;

  const HealthEducationError(this.message);

  @override
  List<Object> get props => [message];
}
