import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/widgets/poll_card.dart';

class PollsScreen extends StatefulWidget {
  const PollsScreen({super.key});
  @override
  State<PollsScreen> createState() => _PollsScreenState();
}

class _PollsScreenState extends State<PollsScreen> {
  Map<String, double>? _selectedPollResults;

  @override
  Widget build(BuildContext context) {
    final List<Poll> activePolls = [
      Poll(id: 'poll1', title: 'Should we install a new playground?', status: 'Voting ends in 3 days'),
    ];
    final List<Poll> pastPolls = [
      Poll(id: 'poll2', title: 'Renovation of the community hall', status: 'Closed 2 weeks ago', isActive: false, results: {'Yes': 75, 'No': 25}),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Polls & Decisions')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_selectedPollResults != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text('Poll Results', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 200,
                      child: PieChart(
                        PieChartData(
                          sections: _selectedPollResults!.entries.map((entry) {
                            return PieChartSectionData(
                              value: entry.value,
                              title: '${entry.key}\n${entry.value.toInt()}%',
                              radius: 80,
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              ),
            const Padding(padding: EdgeInsets.all(16), child: Text('Active Polls', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
            ...activePolls.map((poll) => PollCard(poll: poll, onPressed: () {})),
            const Divider(),
            const Padding(padding: EdgeInsets.all(16), child: Text('Past Polls', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
            ...pastPolls.map((poll) => PollCard(poll: poll, onPressed: () => setState(() => _selectedPollResults = poll.results))),
          ],
        ),
      ),
    );
  }
}