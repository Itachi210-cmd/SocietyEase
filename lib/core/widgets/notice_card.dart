import 'package:flutter/material.dart';
import '../../features/notices/notice_detail_screen.dart';

// Simple Notice model for dummy data
class Notice {
  final String title;
  final String category;
  final String content;

  Notice({required this.title, required this.category, required this.content});
}

class NoticeCard extends StatelessWidget {
  final Notice notice;
  const NoticeCard({super.key, required this.notice});

  @override
  Widget build(BuildContext context) {
    IconData getIconForCategory(String category) {
      if (category == 'Maintenance') return Icons.build;
      if (category == 'Events') return Icons.celebration;
      return Icons.info;
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListTile(
        leading: Icon(getIconForCategory(notice.category), color: Theme.of(context).primaryColor),
        title: Text(notice.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(notice.category),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => NoticeDetailScreen(notice: notice)));
        },
      ),
    );
  }
}