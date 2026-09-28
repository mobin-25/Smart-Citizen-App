import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState
    extends State<NotificationsScreen> {
  // =========================
  // NOTIFICATIONS DATA
  // =========================

  List<Map<String, dynamic>> notifications = [
    {
      'title': 'Complaint Processed',
      'message':
          'Your complaint CMP-2026-002 has been processed and assigned to the concerned department.',
      'time': '2 hours ago',
      'icon': Icons.assignment_turned_in,
      'color': Colors.blue,
      'isRead': false,
    },
    {
      'title': 'Complaint In Progress',
      'message':
          'Your complaint CMP-2026-001 is currently being worked on by the Road Maintenance Department.',
      'time': '5 hours ago',
      'icon': Icons.engineering,
      'color': Colors.orange,
      'isRead': false,
    },
    {
      'title': 'Complaint Submitted',
      'message':
          'Your complaint has been submitted successfully. You can track its status from My Complaints.',
      'time': 'Yesterday',
      'icon': Icons.check_circle,
      'color': Colors.green,
      'isRead': true,
    },
    {
      'title': 'Complaint Resolved',
      'message':
          'Your complaint CMP-2026-003 has been resolved successfully.',
      'time': '2 days ago',
      'icon': Icons.task_alt,
      'color': Colors.green,
      'isRead': true,
    },
  ];

  // =========================
  // UNREAD COUNT
  // =========================

  int get unreadCount {
    return notifications
        .where((notification) =>
            notification['isRead'] == false)
        .length;
  }

  // =========================
  // MARK ALL AS READ
  // =========================

  void markAllAsRead() {
    setState(() {
      for (final notification in notifications) {
        notification['isRead'] = true;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'All notifications marked as read.',
        ),
      ),
    );
  }

  // =========================
  // MARK ONE AS READ
  // =========================

  void markAsRead(int index) {
    setState(() {
      notifications[index]['isRead'] = true;
    });
  }

  // =========================
  // BUILD
  // =========================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,

      // =========================
      // APP BAR
      // =========================

      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,

        actions: [
          if (unreadCount > 0)
            IconButton(
              onPressed: markAllAsRead,
              tooltip: 'Mark all as read',
              icon: const Icon(
                Icons.done_all,
              ),
            ),
        ],
      ),

      // =========================
      // BODY
      // =========================

      body: notifications.isEmpty
          ? _buildEmptyState()
          : Column(
              children: [

                // =========================
                // HEADER
                // =========================

                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(
                    16,
                    16,
                    16,
                    8,
                  ),
                  padding: const EdgeInsets.all(18),

                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.shade600,
                        Colors.blue.shade400,
                      ],
                    ),
                    borderRadius:
                        BorderRadius.circular(18),
                  ),

                  child: Row(
                    children: [

                      Container(
                        height: 52,
                        width: 52,
                        decoration: BoxDecoration(
                          color: Colors.white
                              .withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.notifications_active,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),

                      const SizedBox(width: 15),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [

                            const Text(
                              'Stay Updated',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 4),

                            Text(
                              unreadCount == 0
                                  ? 'You are all caught up!'
                                  : '$unreadCount unread notification${unreadCount == 1 ? '' : 's'}',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // =========================
                // MARK ALL READ
                // =========================

                if (unreadCount > 0)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        onPressed: markAllAsRead,
                        icon: const Icon(
                          Icons.done_all,
                          size: 18,
                        ),
                        label: const Text(
                          'Mark all as read',
                        ),
                      ),
                    ),
                  ),

                // =========================
                // NOTIFICATION LIST
                // =========================

                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(
                      16,
                      4,
                      16,
                      20,
                    ),
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      return _buildNotificationCard(
                        index,
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  // =========================
  // NOTIFICATION CARD
  // =========================

  Widget _buildNotificationCard(int index) {
    final notification = notifications[index];

    final bool isRead =
        notification['isRead'] as bool;

    final Color iconColor =
        notification['color'] as Color;

    return GestureDetector(
      onTap: () {
        markAsRead(index);
      },

      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 200,
        ),

        margin: const EdgeInsets.only(
          bottom: 12,
        ),

        padding: const EdgeInsets.all(15),

        decoration: BoxDecoration(
          color: isRead
              ? Colors.white
              : Colors.blue.shade50,

          borderRadius:
              BorderRadius.circular(16),

          border: Border.all(
            color: isRead
                ? Colors.grey.shade200
                : Colors.blue.shade100,
          ),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(
                alpha: 0.04,
              ),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),

        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            // =========================
            // ICON
            // =========================

            Container(
              height: 48,
              width: 48,

              decoration: BoxDecoration(
                color: iconColor.withValues(
                  alpha: 0.12,
                ),
                shape: BoxShape.circle,
              ),

              child: Icon(
                notification['icon'] as IconData,
                color: iconColor,
                size: 25,
              ),
            ),

            const SizedBox(width: 13),

            // =========================
            // CONTENT
            // =========================

            Expanded(
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
                          notification['title']
                              as String,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: isRead
                                ? FontWeight.w600
                                : FontWeight.bold,
                          ),
                        ),
                      ),

                      if (!isRead)
                        Container(
                          width: 9,
                          height: 9,
                          margin:
                              const EdgeInsets.only(
                            top: 5,
                            left: 8,
                          ),
                          decoration:
                              const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  Text(
                    notification['message']
                        as String,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.4,
                      color: isRead
                          ? Colors.grey.shade600
                          : Colors.grey.shade800,
                    ),
                  ),

                  const SizedBox(height: 9),

                  Row(
                    children: [

                      Icon(
                        Icons.access_time,
                        size: 14,
                        color: Colors.grey.shade500,
                      ),

                      const SizedBox(width: 4),

                      Text(
                        notification['time']
                            as String,
                        style: TextStyle(
                          fontSize: 12,
                          color:
                              Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================
  // EMPTY STATE
  // =========================

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [

            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.notifications_none,
                size: 55,
                color: Colors.blue.shade400,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'No Notifications',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'You will see updates about your complaints here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}