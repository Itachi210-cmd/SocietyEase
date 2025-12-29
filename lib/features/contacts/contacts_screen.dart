import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


// ✅ Updated Model to include category
class EssentialContact {
  final String role;
  final String name;
  final String phone;
  final String category;

  EssentialContact({
    required this.role,
    required this.name,
    required this.phone,
    required this.category,
  });
}

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = "";

  // Original list of all contacts
  final List<EssentialContact> _allContacts = [
    EssentialContact(role: 'Security Main Gate', name: 'Ramesh Singh', phone: '9876543210', category: 'Emergency'),
    EssentialContact(role: 'Fire Department', name: 'Emergency Services', phone: '101', category: 'Emergency'),
    EssentialContact(role: 'Electrician', name: 'Rajesh Verma', phone: '9876543211', category: 'Maintenance'),
    EssentialContact(role: 'Plumber', name: 'Arun Joshi', phone: '9876543212', category: 'Maintenance'),
    EssentialContact(role: 'Society Manager', name: 'Mr. Sharma', phone: '9876543213', category: 'Management'),
    EssentialContact(role: 'Clubhouse Booking', name: 'Office', phone: '9876543214', category: 'Management'),
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String scheme, String path) async {
    final Uri launchUri = Uri(scheme: scheme, path: path);
    if (!await launchUrl(launchUri)) {
      throw 'Could not launch $launchUri';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Filter contacts based on search query
    final filteredContacts = _allContacts.where((contact) {
      final query = _searchQuery.toLowerCase();
      return contact.role.toLowerCase().contains(query) || contact.name.toLowerCase().contains(query);
    }).toList();

    // Group the filtered contacts by category
    final Map<String, List<EssentialContact>> groupedContacts = {};
    for (var contact in filteredContacts) {
      (groupedContacts[contact.category] ??= []).add(contact);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Essential Contacts'),
      ),
      body: Column(
        children: [
          // ✅ Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search by name or role',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          // ✅ Grouped List
          Expanded(
            child: ListView.builder(
              itemCount: groupedContacts.keys.length,
              itemBuilder: (context, index) {
                final category = groupedContacts.keys.elementAt(index);
                final contactsInCategory = groupedContacts[category]!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: Text(
                        category,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ...contactsInCategory.map((contact) {
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        child: ListTile(
                          leading: const Icon(Icons.person_pin_circle_outlined),
                          title: Text(contact.role, style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(contact.name),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.message_outlined, color: Colors.blue),
                                onPressed: () => _launchUrl('sms', contact.phone),
                              ),
                              IconButton(
                                icon: const Icon(Icons.call_outlined, color: Colors.green),
                                onPressed: () => _launchUrl('tel', contact.phone),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}