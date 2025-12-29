import 'dart:math';
import 'package:flutter/material.dart';

import '../../core/widgets/parcel_card.dart';

class ParcelScreen extends StatefulWidget {
  const ParcelScreen({super.key});

  @override
  State<ParcelScreen> createState() => _ParcelScreenState();
}

class _ParcelScreenState extends State<ParcelScreen> {
  // Lists are now state variables
  final List<Parcel> _pendingParcels = [
    Parcel(orderId: '1234567890', sender: 'Amazon'),
    Parcel(orderId: '9876543210', sender: 'Flipkart'),
  ];
  final List<Parcel> _collectedParcels = [
    Parcel(orderId: '5432167890', sender: 'Myntra', isCollected: true),
  ];

  // Function to show OTP and handle collection
  void _showOtpAndCollect(Parcel parcel) {
    // Generate a random 4-digit OTP
    final String otp = (1000 + Random().nextInt(9000)).toString();
    parcel.otp = otp;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Show this OTP to Collect'),
        content: Text(
          'Your OTP for Order #${parcel.orderId} is:',
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          Center(
            child: Text(
              otp,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 8),
            ),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              // Move the parcel from pending to collected
              setState(() {
                parcel.isCollected = true;
                _pendingParcels.remove(parcel);
                _collectedParcels.insert(0, parcel);
              });
              Navigator.of(ctx).pop();
            },
            child: const Text('Collected'),
          ),
        ],
        actionsAlignment: MainAxisAlignment.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parcel Tracking'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text('Pending Parcels', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            ..._pendingParcels.map((parcel) => ParcelCard(
              parcel: parcel,
              onCollect: () => _showOtpAndCollect(parcel),
            )),
            const Divider(height: 32),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Text('Collected Parcels', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            ..._collectedParcels.map((parcel) => ParcelCard(
              parcel: parcel,
              onCollect: () {}, // No action for collected parcels
            )),
          ],
        ),
      ),
    );
  }
}