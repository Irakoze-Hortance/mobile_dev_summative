import 'package:flutter/material.dart';

class ReproductiveHealthPage extends StatelessWidget {
  const ReproductiveHealthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
        title: const Text('Reproductive Health'),
        centerTitle: false, // Align title to the left
        actions: [
          // Language selection dropdown (mocked)
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: DropdownButton<String>(
              value: 'Eng',
              icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
              underline: const SizedBox(), // Remove the underline
              onChanged: (String? newValue) {
                // Handle language change
              },
              items: <String>['Eng', 'Kinyarwanda', 'French']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Confidential & Safe Card
            _buildInfoCard(
              context,
              title: 'Confidential & Safe',
              description: 'All information is private and culturally sensitive',
              icon: Icons.lock_outline, // Placeholder icon
            ),
            const SizedBox(height: 16.0),
            // Maternal Health Card
            _buildInfoCard(
              context,
              title: 'Maternal Health',
              description: 'Prenatal care, safe delivery, and postnatal support for mothers and babies.',
              icon: Icons.pregnant_woman, // Placeholder icon
            ),
            const SizedBox(height: 16.0),
            // Sexual Health Card
            _buildInfoCard(
              context,
              title: 'Sexual Health',
              description: 'STI prevention, testing, and treatment information in a safe, judgment-free environment.',
              icon: Icons.favorite_border, // Placeholder icon
            ),
            const SizedBox(height: 32.0),

            // Women's Helpline Button
            _buildActionButton(
              context,
              text: 'Women\'s Helpline',
              icon: Icons.phone,
              color: Colors.pink.shade300, // Matching the screenshot's color
              onPressed: () {
                // Handle Women's Helpline tap
              },
            ),
            const SizedBox(height: 16.0),
            // Women's Clinic Button
            _buildActionButton(
              context,
              text: 'Women\'s clinic',
              icon: Icons.local_hospital,
              color: Colors.green.shade300, // Matching the screenshot's color
              onPressed: () {
                // Handle Women's Clinic tap
              },
            ),
            const SizedBox(height: 16.0),
            // Private Consultation Button
            _buildActionButton(
              context,
              text: 'Private consultation',
              icon: Icons.chat_bubble_outline,
              color: Colors.deepPurple.shade300, // Matching the screenshot's color
              onPressed: () {
                // Handle Private Consultation tap
              },
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build information cards
  Widget _buildInfoCard(BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
  }) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 28.0, color: Theme.of(context).primaryColor),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build action buttons
  Widget _buildActionButton(BuildContext context, {
    required String text,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity, // Make button full width
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white),
        label: Text(
          text,
          style: const TextStyle(fontSize: 16.0, color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 2.0,
        ),
      ),
    );
  }
}
