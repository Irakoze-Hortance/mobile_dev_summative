
import 'package:flutter/material.dart';

class HealthEducationScreen extends StatefulWidget {
  const HealthEducationScreen({Key? key}) : super(key: key);

  @override
  State<HealthEducationScreen> createState() => _HealthEducationScreenState();
}

class _HealthEducationScreenState extends State<HealthEducationScreen> {
  final List<Map<String, dynamic>> _educationCategories = [
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
          'content': 'Common issues include insomnia, sleep apnea, and restless leg syndrome. Consult healthcare providers for persistent problems.',
          'readTime': '3 min read'
        },
      ]
    },
    {
      'title': 'Women\'s Health',
      'description': 'Specialized health topics for women',
      'icon': Icons.woman,
      'color': Colors.pink,
      'articles': [
        {
          'title': 'Reproductive Health',
          'content': 'Regular gynecological exams, understanding menstrual health, contraception options, and family planning resources.',
          'readTime': '4 min read'
        },
        {
          'title': 'Pregnancy & Maternal Care',
          'content': 'Prenatal care, nutrition during pregnancy, exercise guidelines, and postpartum health considerations.',
          'readTime': '5 min read'
        },
        {
          'title': 'Menopause Management',
          'content': 'Understanding hormonal changes, managing symptoms, bone health, and maintaining quality of life through menopause.',
          'readTime': '4 min read'
        },
      ]
    },
    {
      'title': 'Heart Health',
      'description': 'Cardiovascular wellness information',
      'icon': Icons.favorite,
      'color': Colors.red,
      'articles': [
        {
          'title': 'Heart-Healthy Lifestyle',
          'content': 'Regular exercise, balanced diet low in saturated fats, maintaining healthy weight, and avoiding smoking.',
          'readTime': '3 min read'
        },
        {
          'title': 'Understanding Blood Pressure',
          'content': 'Normal ranges, risk factors for hypertension, monitoring at home, and lifestyle modifications to control BP.',
          'readTime': '4 min read'
        },
        {
          'title': 'Cholesterol Management',
          'content': 'Types of cholesterol, dietary impacts, exercise benefits, and when medication might be necessary.',
          'readTime': '3 min read'
        },
      ]
    },
  ];

  String _selectedCategory = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: _selectedCategory.isEmpty
          ? _buildCategoriesView()
          : _buildArticlesView(),
    );
  }

  Widget _buildCategoriesView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF2D7D79),
                  const Color(0xFF2D7D79).withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.school,
                      color: Colors.white,
                      size: 32,
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Learn About Your Health',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Access evidence-based health information to make informed decisions about your wellbeing',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          const Text(
            'Health Topics',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.9,
            ),
            itemCount: _educationCategories.length,
            itemBuilder: (context, index) {
              final category = _educationCategories[index];
              return _buildCategoryCard(category);
            },
          ),
          const SizedBox(height: 24),

          // Quick Tips Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue[200]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.lightbulb, color: Colors.blue[600], size: 24),
                    const SizedBox(width: 8),
                    const Text(
                      'Quick Health Tips',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ..._buildQuickTips(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedCategory = category['title'];
          });
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: category['color'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(
                  category['icon'],
                  color: category['color'],
                  size: 30,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                category['title'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                category['description'],
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildArticlesView() {
    final category = _educationCategories.firstWhere(
      (cat) => cat['title'] == _selectedCategory,
    );

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          color: category['color'].withOpacity(0.1),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _selectedCategory = '';
                  });
                },
                icon: Icon(Icons.arrow_back, color: category['color']),
              ),
              Icon(category['icon'], color: category['color'], size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category['title'],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: category['color'],
                      ),
                    ),
                    Text(
                      category['description'],
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: category['articles'].length,
            itemBuilder: (context, index) {
              final article = category['articles'][index];
              return _buildArticleCard(article, category['color']);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildArticleCard(Map<String, dynamic> article, Color categoryColor) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => _showArticleDetails(article, categoryColor),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      article['title'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: categoryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      article['readTime'],
                      style: TextStyle(
                        fontSize: 12,
                        color: categoryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                article['content'],
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  height: 1.4,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.arrow_forward, color: categoryColor, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    'Read More',
                    style: TextStyle(
                      color: categoryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildQuickTips() {
    final tips = [
      'Drink water first thing in the morning',
      'Take the stairs instead of elevator',
      'Add more vegetables to your meals',
      'Get 7-9 hours of sleep nightly',
      'Practice deep breathing daily',
    ];

    return tips.map((tip) => Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.blue[600],
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              tip,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    )).toList();
  }

  void _showArticleDetails(Map<String, dynamic> article, Color categoryColor) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: categoryColor.withOpacity(0.1),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          article['title'],
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          article['readTime'],
                          style: TextStyle(
                            color: categoryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Text(
                  article['content'],
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.6,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
