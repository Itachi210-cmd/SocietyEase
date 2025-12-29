import 'package:flutter/material.dart';

// Updated Model
class Parcel {
  final String orderId;
  final String sender;
  bool isCollected;
  String? otp; // For the collection OTP

  Parcel({
    required this.orderId,
    required this.sender,
    this.isCollected = false,
    this.otp,
  });
}

class ParcelCard extends StatelessWidget {
  final Parcel parcel;
  final VoidCallback onCollect; // Callback for when the collect button is tapped

  const ParcelCard({super.key, required this.parcel, required this.onCollect});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Icon(Icons.inventory_2_outlined, size: 40, color: Colors.grey),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order #${parcel.orderId}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text('From: ${parcel.sender}'),
                ],
              ),
            ),
            // This part changes based on the 'isCollected' status
            if (parcel.isCollected)
              const Text(
                'Collected',
                style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              )
            else
              ElevatedButton(
                onPressed: onCollect, // Use the callback
                child: const Text('Collect'),
              ),
          ],
        ),
      ),
    );
  }
}