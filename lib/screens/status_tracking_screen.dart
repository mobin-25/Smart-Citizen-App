import 'package:flutter/material.dart';

class StatusTrackingScreen extends StatelessWidget {
  final String complaintId;
  final String category;
  final String description;
  final String location;
  final String department;
  final String currentStatus;

  const StatusTrackingScreen({
    super.key,
    required this.complaintId,
    required this.category,
    required this.description,
    required this.location,
    required this.department,
    required this.currentStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Complaint'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Complaint Details
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Complaint Details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    _buildDetailRow(
                      icon: Icons.confirmation_number,
                      title: 'Complaint ID',
                      value: complaintId,
                    ),

                    const SizedBox(height: 16),

                    _buildDetailRow(
                      icon: Icons.category,
                      title: 'Category',
                      value: category,
                    ),

                    const SizedBox(height: 16),

                    _buildDetailRow(
                      icon: Icons.description,
                      title: 'Description',
                      value: description,
                    ),

                    const SizedBox(height: 16),

                    _buildDetailRow(
                      icon: Icons.location_on,
                      title: 'Location',
                      value: location,
                    ),

                    const SizedBox(height: 16),

                    _buildDetailRow(
                      icon: Icons.business,
                      title: 'Assigned Department',
                      value: department,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              'Complaint Timeline',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // Submitted
            _buildTimeline(
              title: 'Complaint Submitted',
              description:
                  'Your complaint has been submitted successfully.',
              date: '26 Sep 2026, 10:30 AM',
              isCompleted: true,
              isCurrent: currentStatus == 'Submitted',
              isLast: false,
            ),

            // Under Review
            _buildTimeline(
              title: 'Under Review',
              description:
                  'Your complaint is being reviewed by the concerned authorities.',
              date: '26 Sep 2026, 11:15 AM',
              isCompleted: _isStatusReached('Under Review'),
              isCurrent: currentStatus == 'Under Review',
              isLast: false,
            ),

            // Processed
            _buildTimeline(
              title: 'Processed',
              description:
                  'Your complaint has been processed and assigned to the concerned department.',
              date: '26 Sep 2026, 2:00 PM',
              isCompleted: _isStatusReached('Processed'),
              isCurrent: currentStatus == 'Processed',
              isLast: false,
            ),

            // In Progress
            _buildTimeline(
              title: 'In Progress',
              description:
                  'The concerned department is working on resolving the issue.',
              date: '27 Sep 2026, 9:00 AM',
              isCompleted: _isStatusReached('In Progress'),
              isCurrent: currentStatus == 'In Progress',
              isLast: false,
            ),

            // Resolved
            _buildTimeline(
              title: 'Resolved',
              description:
                  'The complaint has been resolved successfully.',
              date: currentStatus == 'Resolved'
                  ? '27 Sep 2026, 4:30 PM'
                  : 'Pending',
              isCompleted: currentStatus == 'Resolved',
              isCurrent: currentStatus == 'Resolved',
              isLast: true,
            ),

            const SizedBox(height: 25),

            // Last Updated
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(
                      Icons.update,
                      size: 30,
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Last Updated',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            _getLastUpdated(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Complaint detail row
  Widget _buildDetailRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Colors.blue,
          size: 24,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Check whether a status has been reached
  bool _isStatusReached(String status) {
    const List<String> statusOrder = [
      'Submitted',
      'Under Review',
      'Processed',
      'In Progress',
      'Resolved',
    ];

    final int currentIndex =
        statusOrder.indexOf(currentStatus);

    final int statusIndex =
        statusOrder.indexOf(status);

    if (currentIndex == -1 || statusIndex == -1) {
      return false;
    }

    return statusIndex <= currentIndex;
  }

  // Last updated time
  String _getLastUpdated() {
    switch (currentStatus) {
      case 'Submitted':
        return '26 Sep 2026, 10:30 AM';

      case 'Under Review':
        return '26 Sep 2026, 11:15 AM';

      case 'Processed':
        return '26 Sep 2026, 2:00 PM';

      case 'In Progress':
        return '27 Sep 2026, 9:00 AM';

      case 'Resolved':
        return '27 Sep 2026, 4:30 PM';

      default:
        return 'Not available';
    }
  }

  // Timeline item
  Widget _buildTimeline({
    required String title,
    required String description,
    required String date,
    required bool isCompleted,
    required bool isCurrent,
    required bool isLast,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline icon and line
        Column(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted
                    ? Colors.green
                    : Colors.grey.shade300,
              ),
              child: Icon(
                isCompleted
                    ? Icons.check
                    : Icons.circle_outlined,
                size: 20,
                color: isCompleted
                    ? Colors.white
                    : Colors.grey,
              ),
            ),

            if (!isLast)
              Container(
                width: 2,
                height: 85,
                color: isCompleted
                    ? Colors.green
                    : Colors.grey.shade300,
              ),
          ],
        ),

        const SizedBox(width: 15),

        // Timeline content
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 20,
            ),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isCurrent
                    ? Colors.blue.shade50
                    : Colors.white,
                border: Border.all(
                  color: isCurrent
                      ? Colors.blue
                      : Colors.grey.shade300,
                  width: isCurrent ? 2 : 1,
                ),
                borderRadius:
                    BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight:
                                FontWeight.bold,
                            color: isCompleted
                                ? Colors.black
                                : Colors.grey,
                          ),
                        ),
                      ),

                      if (isCurrent)
                        Container(
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color:
                                Colors.blue.shade100,
                            borderRadius:
                                BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Current',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.blue,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: isCompleted
                          ? Colors.grey.shade700
                          : Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    date,
                    style: TextStyle(
                      fontSize: 13,
                      color: isCompleted
                          ? Colors.blueGrey
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
