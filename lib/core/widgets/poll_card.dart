import 'package:flutter/material.dart';

class Poll {
  final String id;
  final String title;
  final String status;
  final bool isActive;
  final Map<String, double>? results;

  Poll({
    required this.id,
    required this.title,
    required this.status,
    this.isActive = true,
    this.results,
  });
}

class PollCard extends StatelessWidget {
  final Poll poll;
  final VoidCallback onPressed;
  const PollCard({super.key, required this.poll, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(poll.title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(poll.status, style: TextStyle(color: Colors.grey[600])),
                ElevatedButton(
                  onPressed: onPressed,
                  child: Text(poll.isActive ? 'Vote' : 'View Results'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}