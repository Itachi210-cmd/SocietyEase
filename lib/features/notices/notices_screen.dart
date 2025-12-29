import 'package:flutter/material.dart';

import '../../core/widgets/notice_card.dart';

class NoticesScreen extends StatelessWidget {
  const NoticesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Simple dummy data list
    final List<Notice> notices = [
      Notice(title: 'Annual General Meeting', category: 'General', content: 'This is the full content for the AGM notice.'),
      Notice(title: 'Water Supply Interruption', category: 'Maintenance', content: 'Water supply will be interrupted tomorrow for maintenance.'),
      Notice(title: 'Diwali Celebration', category: 'Events', content: 'Join us for the Diwali celebration in the clubhouse.'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Digital Notices'),
      ),
      body: ListView.builder(
        itemCount: notices.length,
        itemBuilder: (context, index) {
          return NoticeCard(notice: notices[index]);
        },
      ),
    );
  }
}