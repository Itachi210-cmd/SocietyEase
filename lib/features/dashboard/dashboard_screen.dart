import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../core/widgets/feature_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _isAdmin = false;
  bool _isLoading = true;
  String _userName = 'Resident';

  @override
  void initState() {
    super.initState();
    _checkUserRole();
  }

  Future<void> _checkUserRole() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (mounted) {
        setState(() {
          _isAdmin = doc.data()?['role'] == 'admin';
          _userName = doc.data()?['name'] ?? 'Resident'; // Assuming 'name' field exists
          _isLoading = false;
        });
      }
    } else {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Widget _buildBentoItem(String title, String subtitle, IconData icon, Color color, String route, {bool isLarge = false}) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        padding: const EdgeInsets.all(12), // Uniform padding
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center, // Centered content
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              padding: const EdgeInsets.all(8), // Uniform icon padding
              decoration: BoxDecoration(color: color.withOpacity(0.2), shape: BoxShape.circle),
              child: Icon(icon, color: color, size: isLarge ? 30 : 24),
            ),
            SizedBox(height: isLarge ? 12 : 8), // Dynamic gap
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: isLarge ? 18 : 15,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface // Responsive Text Color
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)), // Responsive Subtitle
                   maxLines: 1,
                   overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const Scaffold(body: Center(child: CircularProgressIndicator()));

    return Scaffold(
      // backgroundColor uses Theme default (Cool Gray)
      body: SafeArea(
        child: AnimationLimiter(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 375),
                childAnimationBuilder: (widget) => SlideAnimation(
                  horizontalOffset: 50.0,
                  child: FadeInAnimation(child: widget),
                ),
                children: [
                  // App Bar / Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Welcome back,', style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7), fontSize: 16)),
                          Text(_userName, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface)),
                        ],
                      ),
                      CircleAvatar(backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1), child: const Icon(Icons.person)),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Priority / Large Bento items (Row of 3)
                  SizedBox(
                    height: 180, // Taller to accommodate narrow width
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildBentoItem('Complaints', 'Report', Icons.warning_amber_rounded, Colors.orange, '/complaints', isLarge: true),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildBentoItem('Notices', 'Updates', Icons.campaign_rounded, Colors.blue, '/notices', isLarge: true),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildBentoItem('Bills', 'Pay', Icons.receipt_long_rounded, Colors.green, '/bills', isLarge: true),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Section Title
                  Text('Quick Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface)),
                  const SizedBox(height: 12),

                  // Grid for other items
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2, // Switched to 2 columns for better layout
                    crossAxisSpacing: 10, // Standard spacing
                    mainAxisSpacing: 10, // Standard spacing
                    childAspectRatio: 1.3, // Taller tiles to prevent bottom overflow
                    children: [
                      _buildBentoItem('Visitors', 'Mngmt', Icons.group_add_rounded, Colors.purple, '/visitors'),
                      _buildBentoItem('Parcels', 'Collect', Icons.local_shipping_rounded, Colors.brown, '/parcels'),
                      _buildBentoItem('Facilities', 'Book', Icons.pool_rounded, Colors.teal, '/events'),
                      _buildBentoItem('Parking', 'Slots', Icons.local_parking_rounded, Colors.indigo, '/parking'),
                      _buildBentoItem('Directory', 'Contacts', Icons.contacts_rounded, Colors.pink, '/contacts'),
                      _buildBentoItem('Feedback', 'Rate', Icons.star_rounded, Colors.amber, '/feedback'),
                    ],
                  ),

                  if (_isAdmin) ...[
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: Colors.red.withOpacity(0.05), borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Admin Zone', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red)),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(child: _buildBentoItem('Occupancy', 'Manage Flats', Icons.home_work_rounded, Colors.red, '/occupancy')),
                              const SizedBox(width: 12),
                              Expanded(child: _buildBentoItem('Analytics', 'Insights', Icons.analytics_rounded, Colors.red, '/admin')),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}