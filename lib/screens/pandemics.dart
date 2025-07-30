import 'package:flutter/material.dart';

class PandemicPage extends StatelessWidget {
  const PandemicPage({super.key});

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
        title: const Text('Pandemics'),
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
            const Text(
              'Outbreaks in region',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            // Outbreaks in region card (mocked with a placeholder)
            Card(
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.warning_amber, size: 28.0, color: Colors.orange),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Text(
                        'Information about current outbreaks in your region.',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            const Text(
              'Past Hazards',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),

            // List of past hazards (e.g., Covid 19 entries)
            _buildHazardEntry(
              context,
              title: 'Covid 19',
              date: 'Posted on 19 Mar 2022',
            ),
            const SizedBox(height: 12.0),
            _buildHazardEntry(
              context,
              title: 'Covid 19',
              date: 'Posted on 19 Mar 2022',
            ),
            const SizedBox(height: 12.0),
            _buildHazardEntry(
              context,
              title: 'Covid 19',
              date: 'Posted on 19 Mar 2022',
            ),
            const SizedBox(height: 12.0),
            // Add more entries as needed
          ],
        ),
      ),
    );
  }

  // Helper method to build individual hazard entries
  Widget _buildHazardEntry(BuildContext context, {
    required String title,
    required String date,
  }) {
    return Card(
      elevation: 1.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                // Handle "Read More" tap
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade100, // Light blue background
                foregroundColor: Colors.blue.shade800, // Darker blue text
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                elevation: 0, // No shadow
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              child: const Text(
                'Read More',
                style: TextStyle(fontSize: 12.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
