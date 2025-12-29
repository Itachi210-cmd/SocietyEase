import 'package:flutter/material.dart';

// Simple model for dummy data
class Bill {
  final String month;
  final String year;
  String status; // Not final to allow changes
  bool isPaid; // Not final to allow changes

  Bill({
    required this.month,
    required this.year,
    required this.status,
    this.isPaid = false,
  });
}

class BillCard extends StatelessWidget {
  final Bill bill;
  final VoidCallback? onPayNow;
  final VoidCallback? onDownload; // ✅ Callback for the download button

  const BillCard({super.key, required this.bill, this.onPayNow, this.onDownload});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              Icons.receipt_long,
              size: 40,
              color: bill.isPaid ? Colors.grey : Theme.of(context).primaryColor,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bill - ${bill.month} ${bill.year}',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(bill.status),
                ],
              ),
            ),
            // ✅ Show a download button for paid bills
            if (bill.isPaid)
              IconButton(
                icon: const Icon(Icons.download_for_offline_outlined, color: Colors.blue),
                onPressed: onDownload,
                tooltip: 'Download Bill',
              )
            else
              ElevatedButton(
                onPressed: onPayNow,
                child: const Text('Pay Now'),
              )
          ],
        ),
      ),
    );
  }
}