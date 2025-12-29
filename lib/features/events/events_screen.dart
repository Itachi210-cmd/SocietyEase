import 'package:flutter/material.dart';
import '../../core/widgets/event_card.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  // ✅ List to keep track of which events the user has RSVP'd to
  final Set<String> _rsvpdEventIds = {};

  // Dummy Data
  final List<Event> _upcomingEvents = [
    Event(id: 'event1', title: 'Summer BBQ', description: 'Join us for a fun-filled evening...', dateTime: 'Sat, Aug 12, 6:00 PM'),
    Event(id: 'event2', title: 'Movie Night', description: 'Enjoy a classic film under the stars...', dateTime: 'Fri, Aug 18, 8:00 PM'),
    Event(id: 'event3', title: 'Yoga in the Park', description: 'Start your day with a relaxing yoga session...', dateTime: 'Sun, Aug 20, 9:00 AM'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events RSVP'),
      ),
      body: ListView.builder(
        itemCount: _upcomingEvents.length,
        itemBuilder: (context, index) {
          final event = _upcomingEvents[index];
          final isRsvpd = _rsvpdEventIds.contains(event.id);

          return EventCard(
            event: event,
            isRsvpd: isRsvpd,
            onRsvpPressed: () {
              // ✅ Update the state when the button is pressed
              setState(() {
                if (isRsvpd) {
                  _rsvpdEventIds.remove(event.id);
                } else {
                  _rsvpdEventIds.add(event.id);
                }
              });
            },
          );
        },
      ),
    );
  }
}