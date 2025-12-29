import 'package:flutter/material.dart';
import '../../core/widgets/visitor_card.dart';
import 'pre_approve_guest_screen.dart'; // Import the new screen

class VisitorScreen extends StatefulWidget {
  const VisitorScreen({super.key});

  @override
  State<VisitorScreen> createState() => _VisitorScreenState();
}

class _VisitorScreenState extends State<VisitorScreen> {
  // The list is now a state variable that can be changed
  final List<Visitor> _recentVisitors = [
    Visitor(name: 'Ethan Carter', arrivalTime: '10:00 AM', imageUrl: 'https://i.pravatar.cc/150?img=68'),
  ];

  // Function to navigate to the form and wait for a result
  void _navigateToPreApproveForm() async {
    final newVisitor = await Navigator.push<Visitor>(
      context,
      MaterialPageRoute(builder: (context) => const PreApproveGuestScreen()),
    );

    // If the form returns a new visitor, add it to the list
    if (newVisitor != null) {
      setState(() {
        _recentVisitors.insert(0, newVisitor); // Add new guest to the top of the list
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Visitor Management')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Pre-approve Button
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: ElevatedButton.icon(
              onPressed: _navigateToPreApproveForm, // Use the new function
              icon: const Icon(Icons.check_circle_outline),
              label: const Text('Pre-approve Guest'),
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12)),
            ),
          ),
          const Divider(height: 24),

          // QR Code Section
          const Center(
            child: Text('For Walk-in Visitors', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 8),
          Center(
            child: Image.asset(
              'assets/images/visitor form.png', // ✅ Make sure this name exactly matches your file
              width: 200,
              errorBuilder: (context, error, stackTrace) {
                return const Text('Error: Image not found.\nCheck filename in code and pubspec.yaml');
              },
            ),
          ),
          const SizedBox(height: 8),
          Center(child: Text('Ask walk-in visitors to scan this code.', style: TextStyle(color: Colors.grey[700]))),
          const Divider(height: 24),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text('Recent & Pre-approved Visitors', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),

          // List of Visitors
          Expanded(
            child: ListView.builder(
              itemCount: _recentVisitors.length,
              itemBuilder: (context, index) {
                return VisitorCard(visitor: _recentVisitors[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}