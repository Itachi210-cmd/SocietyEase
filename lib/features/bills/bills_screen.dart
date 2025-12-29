import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart'; // Import path_provider
import 'package:open_file/open_file.dart';       // Import open_file
import 'dart:io';                                // Import for file operations
import '../../core/widgets/bills_card.dart';

class BillsScreen extends StatefulWidget {
  const BillsScreen({super.key});

  @override
  State<BillsScreen> createState() => _BillsScreenState();
}

class _BillsScreenState extends State<BillsScreen> {
  final List<Bill> _currentBills = [
    Bill(month: 'October', year: '2025', status: 'Due on Oct 15'),
  ];
  final List<Bill> _pastBills = [
    Bill(month: 'September', year: '2025', status: 'Paid on Sep 5', isPaid: true),
    Bill(month: 'August', year: '2025', status: 'Paid on Aug 4', isPaid: true),
  ];

  Future<void> _markAsPaid(Bill bill) async {
    // ... same payment logic as before ...
  }

  // ✅ Function to simulate creating and opening a PDF
  Future<void> _simulateDownloadAndOpen(Bill bill) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      // 1. Get the directory to save the file
      final dir = await getApplicationDocumentsDirectory();
      final filePath = '${dir.path}/Maintenance-Bill-${bill.month}-${bill.year}.pdf';

      // 2. Create a dummy file with some text
      final file = File(filePath);
      await file.writeAsString('This is a dummy PDF for the bill of ${bill.month} ${bill.year}.');

      // 3. Open the file
      final result = await OpenFile.open(filePath);
      if (result.type != ResultType.done) {
        throw Exception('Could not open file: ${result.message}');
      }

    } catch (e) {
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text('Error: Could not open file. ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Monthly Bills')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text('Current Bill', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            ..._currentBills.map((bill) => BillCard(
              bill: bill,
              onPayNow: () => _markAsPaid(bill),
            )),
            const Divider(height: 32),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Text('Past Bills', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            // ✅ Pass the download function to the BillCard's callback
            ..._pastBills.map((bill) => BillCard(
              bill: bill,
              onDownload: () => _simulateDownloadAndOpen(bill),
            )),
          ],
        ),
      ),
    );
  }
}