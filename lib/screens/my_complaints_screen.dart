import 'package:flutter/material.dart';
import 'status_tracking_screen.dart';

class MyComplaintsScreen extends StatelessWidget {
  const MyComplaintsScreen({super.key});

  // Sample complaints
  final List<Map<String, String>> complaints = const [
    {
      'id': 'CMP-2026-001',
      'category': 'Road / Pothole',
      'description': 'Large pothole near the main road.',
      'location': 'Main Road, Mumbai',
      'department': 'Road Maintenance Department',
      'status': 'In Progress',
      'date': '27 Sep 2026',
    },
    {
      'id': 'CMP-2026-002',
      'category': 'Garbage',
      'description': 'Garbage has not been collected for several days.',
      'location': 'Station Road, Mumbai',
      'department': 'Waste Management Department',
      'status': 'Processed',
      'date': '26 Sep 2026',
    },
    {
      'id': 'CMP-2026-003',
      'category': 'Streetlight',
      'description': 'Streetlight is not working.',
      'location': 'MG Road, Mumbai',
      'department': 'Electrical Department',
      'status': 'Resolved',
      'date': '24 Sep 2026',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Complaints'),
        centerTitle: true,
      ),

      body: complaints.isEmpty
          ? const Center(
              child: Text(
                'No complaints submitted yet.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: complaints.length,
              itemBuilder: (context, index) {
                final complaint = complaints[index];

                return _buildComplaintCard(
                  context,
                  complaint,
                );
              },
            ),
    );
  }

  // =========================
  // COMPLAINT CARD
  // =========================

  Widget _buildComplaintCard(
    BuildContext context,
    Map<String, String> complaint,
  ) {
    final String status = complaint['status'] ?? '';

    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // =========================
            // ID + STATUS
            // =========================

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Expanded(
                  child: Text(
                    complaint['id'] ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                _buildStatusChip(status),
              ],
            ),

            const SizedBox(height: 15),

            // =========================
            // CATEGORY
            // =========================

            Row(
              children: [
                const Icon(
                  Icons.category,
                  size: 20,
                  color: Colors.blue,
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: Text(
                    complaint['category'] ?? '',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // =========================
            // DESCRIPTION
            // =========================

            Text(
              complaint['description'] ?? '',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 12),

            // =========================
            // LOCATION
            // =========================

            Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                const Icon(
                  Icons.location_on,
                  size: 20,
                  color: Colors.blue,
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: Text(
                    complaint['location'] ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // =========================
            // DATE
            // =========================

            Row(
              children: [

                const Icon(
                  Icons.calendar_today,
                  size: 18,
                  color: Colors.blue,
                ),

                const SizedBox(width: 8),

                Text(
                  complaint['date'] ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            const Divider(),

            const SizedBox(height: 5),

            // =========================
            // TRACK STATUS BUTTON
            // =========================

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          StatusTrackingScreen(
                        complaintId:
                            complaint['id'] ?? '',
                        category:
                            complaint['category'] ?? '',
                        description:
                            complaint['description'] ?? '',
                        location:
                            complaint['location'] ?? '',
                        department:
                            complaint['department'] ?? '',
                        currentStatus:
                            complaint['status'] ?? '',
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.track_changes,
                ),
                label: const Text(
                  'Track Status',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================
  // STATUS CHIP
  // =========================

  Widget _buildStatusChip(String status) {
    Color backgroundColor;
    Color textColor;

    switch (status) {
      case 'Resolved':
        backgroundColor = Colors.green.shade100;
        textColor = Colors.green.shade800;
        break;

      case 'In Progress':
        backgroundColor = Colors.orange.shade100;
        textColor = Colors.orange.shade800;
        break;

      case 'Processed':
        backgroundColor = Colors.blue.shade100;
        textColor = Colors.blue.shade800;
        break;

      case 'Under Review':
        backgroundColor = Colors.purple.shade100;
        textColor = Colors.purple.shade800;
        break;

      default:
        backgroundColor = Colors.grey.shade200;
        textColor = Colors.grey.shade800;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}


