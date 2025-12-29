import 'package:flutter/material.dart';

// ✅ Updated Model
class Event {
  final String id;
  final String title;
  final String description;
  final String dateTime;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
  });
}

class EventCard extends StatelessWidget {
  final Event event;
  final bool isRsvpd; // ✅ To know if the user has RSVP'd
  final VoidCallback onRsvpPressed; // ✅ Callback for the button

  const EventCard({
    super.key,
    required this.event,
    required this.isRsvpd,
    required this.onRsvpPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.dateTime.toUpperCase(),
                  style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 12),
                ),
                const SizedBox(height: 8),
                Text(event.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(event.description, style: TextStyle(color: Colors.grey[700])),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  // ✅ Button changes based on isRsvpd status
                  child: ElevatedButton.icon(
                    onPressed: onRsvpPressed,
                    icon: Icon(isRsvpd ? Icons.check : Icons.event_available),
                    label: Text(isRsvpd ? 'Attending' : 'RSVP Now'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isRsvpd ? Colors.green : Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}