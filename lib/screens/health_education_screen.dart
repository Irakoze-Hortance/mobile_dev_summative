// health_education_screen.dart
// Health education and wellness information screen
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/health_education/health_education_bloc.dart';
import '../blocs/health_education/health_education_event.dart';
import '../blocs/health_education/health_education_state.dart';

class HealthEducationScreen extends StatelessWidget {
  const HealthEducationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HealthEducationBloc()..add(LoadHealthEducationCategories()),
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          backgroundColor: const Color(0xFF2D7D79),
          elevation: 0,
          title: const Text(
            'Health Education',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: BlocBuilder<HealthEducationBloc, HealthEducationState>(
          builder: (context, state) {
            if (state is HealthEducationLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF2D7D79),
                ),
              );
            }
            
            if (state is HealthEducationError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red[300],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<HealthEducationBloc>().add(LoadHealthEducationCategories());
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            
            if (state is HealthEducationCategoriesLoaded) {
              return _buildCategoriesView(context, state.categories);
            }
            
            if (state is HealthEducationArticlesLoaded) {
              return _buildArticlesView(context, state.selectedCategory, state.categoryIndex);
            }
            
            if (state is HealthEducationArticleSelected) {
              return _buildArticleView(context, state);
            }
            
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildCategoriesView(BuildContext context, List<Map<String, dynamic>> categories) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome message
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF2D7D79).withOpacity(0.8),
                  const Color(0xFF2D7D79).withOpacity(0.6),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Health Education Center',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Learn about various health topics to improve your wellbeing and make informed decisions.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Categories title
          const Text(
            'Health Topics',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D7D79),
            ),
          ),
          const SizedBox(height: 16),

          // Category cards
          ...categories.asMap().entries.map((entry) {
            final index = entry.key;
            final category = entry.value;
            
            return _buildCategoryCard(context, category, index);
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, Map<String, dynamic> category, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: (category['color'] as Color).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            category['icon'] as IconData,
            color: category['color'] as Color,
            size: 28,
          ),
        ),
        title: Text(
          category['title'] as String,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D7D79),
          ),
        ),
        subtitle: Text(
          category['description'] as String,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Color(0xFF2D7D79),
          size: 18,
        ),
        onTap: () {
          context.read<HealthEducationBloc>().add(SelectEducationCategory(index));
        },
      ),
    );
  }

  Widget _buildArticlesView(BuildContext context, Map<String, dynamic> category, int categoryIndex) {
    final articles = category['articles'] as List<Map<String, dynamic>>;
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back button
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  context.read<HealthEducationBloc>().add(BackToCategories());
                },
              ),
              Expanded(
                child: Text(
                  category['title'] as String,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D7D79),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Articles
          ...articles.asMap().entries.map((entry) {
            final index = entry.key;
            final article = entry.value;
            
            return _buildArticleCard(context, article, categoryIndex, index);
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildArticleCard(BuildContext context, Map<String, dynamic> article, int categoryIndex, int articleIndex) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          article['title'] as String,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D7D79),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              article['readTime'] as String,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              article['content'] as String,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Color(0xFF2D7D79),
          size: 18,
        ),
        onTap: () {
          context.read<HealthEducationBloc>().add(SelectArticle(categoryIndex, articleIndex));
        },
      ),
    );
  }

  Widget _buildArticleView(BuildContext context, HealthEducationArticleSelected state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back button
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  context.read<HealthEducationBloc>().add(BackToArticles());
                },
              ),
              const Expanded(
                child: Text(
                  'Article',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D7D79),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Article content
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.selectedArticle['title'] as String,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D7D79),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  state.selectedArticle['readTime'] as String,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  state.selectedArticle['content'] as String,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.6,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
