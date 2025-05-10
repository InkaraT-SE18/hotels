import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<Map<String, dynamic>> notifications = [
    {
      'title': '📅 Booking approaching',
      'subtitle': 'Rixos Astana — Check-in April 20',
      'category': 'reminder',
      'read': false,
    },
    {
      'title': '🏨 Check-in in 3 days',
      'subtitle': 'Hilton Astana — April 23',
      'category': 'reminder',
      'read': false,
    },
    {
      'title': '🔥 20% discount on Ritz Almaty',
      'subtitle': 'Until April 25!',
      'category': 'offer',
      'read': false,
    },
    {
      'title': '🚀 Dark theme added',
      'subtitle': 'Change in profile or settings',
      'category': 'update',
      'read': false,
    },
  ];

  void markAsRead(int index) {
    setState(() {
      notifications[index]['read'] = true;
    });

    // Remove with animation
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) {
        setState(() {
          notifications.removeAt(index);
        });
      }
    });
  }

  void clearAll() async {
    for (int i = notifications.length - 1; i >= 0; i--) {
      setState(() {
        notifications[i]['read'] = true;
      });
      await Future.delayed(const Duration(milliseconds: 150));
      if (mounted) {
        setState(() {
          notifications.removeAt(i);
        });
      }
    }
  }

  Widget buildNotificationItem(int index) {
    final item = notifications[index];

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      transitionBuilder: (child, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: FadeTransition(opacity: animation, child: child),
        );
      },
      child: item['read']
          ? const SizedBox.shrink()
          : ListTile(
              key: ValueKey(item['title']),
              leading: const Icon(Icons.notifications_active, color: Colors.blue),
              title: Text(
                item['title'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(item['subtitle']),
              trailing: const Icon(Icons.mark_email_read_outlined, size: 18),
              onTap: () => markAsRead(index),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        actions: [
          if (notifications.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_forever),
              tooltip: 'Clear all',
              onPressed: clearAll,
            ),
        ],
      ),
      body: notifications.isEmpty
          ? const Center(child: Text("No notifications"))
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) => buildNotificationItem(index),
            ),
    );
  }
}
