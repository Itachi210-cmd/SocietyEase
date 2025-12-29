import 'package:flutter/material.dart';
import 'new_flat_screen.dart'; // Import the new screen
import 'edit_flat_screen.dart'; // Import the edit screen

// Simple model for our flat data
class Flat {
  String number;
  String status;
  Flat({required this.number, required this.status});
}

class FlatOccupancyScreen extends StatefulWidget {
  const FlatOccupancyScreen({super.key});
  @override
  State<FlatOccupancyScreen> createState() => _FlatOccupancyScreenState();
}

class _FlatOccupancyScreenState extends State<FlatOccupancyScreen> {
  final List<Flat> _flats = [
    Flat(number: 'Flat 101', status: 'Owner-occupied'),
    Flat(number: 'Flat 102', status: 'Rented'),
    Flat(number: 'Flat 103', status: 'Vacant'),
  ];

  // Function to navigate to the Add Flat form
  void _navigateToAddFlat() async {
    final newFlat = await Navigator.push<Flat>(
      context,
      MaterialPageRoute(builder: (context) => const NewFlatScreen()),
    );
    if (newFlat != null) {
      setState(() => _flats.add(newFlat));
    }
  }

  // Function to navigate to the Edit Flat form
  void _navigateToEditFlat(Flat flat) async {
    final updatedFlat = await Navigator.push<Flat>(
      context,
      MaterialPageRoute(builder: (context) => EditFlatScreen(flat: flat)),
    );
    if (updatedFlat != null) {
      setState(() {
        // Find the original flat and update it (or just refresh)
        final index = _flats.indexWhere((f) => f.number == flat.number);
        if (index != -1) {
          _flats[index] = updatedFlat;
        }
      });
    }
  }

  void _showStatusChangeDialog(Flat flat) {
    // ... this function is the same as before ...
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flat Occupancy Status')),
      body: ListView.builder(
        itemCount: _flats.length,
        itemBuilder: (context, index) {
          final flat = _flats[index];
          return ListTile(
            title: Text(flat.number),
            subtitle: Text(flat.status), // Subtitle for status
            trailing: IconButton( // ✅ Edit button added
              icon: const Icon(Icons.edit_note),
              onPressed: () => _navigateToEditFlat(flat),
            ),
            onTap: () => _showStatusChangeDialog(flat), // Tap to change status
          );
        },
      ),
      // ✅ Add button added
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddFlat,
        child: const Icon(Icons.add),
      ),
    );
  }
}