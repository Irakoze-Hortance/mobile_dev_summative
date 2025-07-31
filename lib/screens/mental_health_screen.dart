
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/mental_health/mental_health_bloc.dart';
import '../blocs/mental_health/mental_health_event.dart';
import '../blocs/mental_health/mental_health_state.dart';

class MentalHealthScreen extends StatelessWidget {
  const MentalHealthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MentalHealthBloc()..add(LoadMentalHealthResources()),
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          backgroundColor: const Color(0xFF2D7D79),
          elevation: 0,
          title: const Text(
            'Mental Health',
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
        body: BlocBuilder<MentalHealthBloc, MentalHealthState>(
          builder: (context, state) {
            if (state is MentalHealthLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF2D7D79),
                ),
              );
            }
            
            if (state is MentalHealthError) {
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
                        context.read<MentalHealthBloc>().add(LoadMentalHealthResources());
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            
            if (state is MentalHealthLoaded) {
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
                            'Your Mental Health Matters',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Find resources, support, and techniques to support your mental wellbeing.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Mental Health Resources
                    const Text(
                      'Mental Health Resources',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D7D79),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Resource cards
                    ...state.resources.asMap().entries.map((entry) {
                      final index = entry.key;
                      final resource = entry.value;
                      final isSelected = state.selectedResourceIndex == index;
                      
                      return _buildResourceCard(
                        context,
                        resource,
                        index,
                        isSelected,
                      );
                    }).toList(),

                    const SizedBox(height: 32),

                    // Emergency Contacts section
                    _buildEmergencyContactsSection(context, state),
                  ],
                ),
              );
            }
            
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildResourceCard(
    BuildContext context,
    Map<String, dynamic> resource,
    int index,
    bool isSelected,
  ) {
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
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: (resource['color'] as Color).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                resource['icon'] as IconData,
                color: resource['color'] as Color,
                size: 28,
              ),
            ),
            title: Text(
              resource['title'] as String,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D7D79),
              ),
            ),
            subtitle: Text(
              resource['description'] as String,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            trailing: Icon(
              isSelected ? Icons.expand_less : Icons.expand_more,
              color: const Color(0xFF2D7D79),
            ),
            onTap: () {
              context.read<MentalHealthBloc>().add(
                SelectMentalHealthResource(index),
              );
            },
          ),
          if (isSelected)
            Container(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  const SizedBox(height: 8),
                  ...(resource['content'] as List<String>).map(
                    (item) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 8, right: 12),
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: resource['color'] as Color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              item,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).toList(),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEmergencyContactsSection(
    BuildContext context,
    MentalHealthLoaded state,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.red[200]!),
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.emergency,
                color: Colors.red[600],
                size: 28,
              ),
            ),
            title: const Text(
              'Emergency Contacts',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            subtitle: const Text(
              'Crisis support and emergency help',
              style: TextStyle(
                fontSize: 14,
                color: Colors.red,
              ),
            ),
            trailing: Icon(
              state.isEmergencyContactsExpanded 
                  ? Icons.expand_less 
                  : Icons.expand_more,
              color: Colors.red[600],
            ),
            onTap: () {
              if (state.isEmergencyContactsExpanded) {
                context.read<MentalHealthBloc>().add(CollapseEmergencyContacts());
              } else {
                context.read<MentalHealthBloc>().add(ExpandEmergencyContacts());
              }
            },
          ),
          if (state.isEmergencyContactsExpanded)
            Container(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                children: [
                  const Divider(color: Colors.red),
                  ...state.emergencyContacts.map(
                    (contact) => Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.red[200]!),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            contact['name'] as String,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            contact['number'] as String,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF2D7D79),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            contact['description'] as String,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).toList(),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
