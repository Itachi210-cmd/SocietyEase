import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'features/admin/admin_dashboard_screen.dart';
import 'features/admin/flat_occupancy_screen.dart';
import 'features/auth/login_screen.dart';
import 'features/auth/registration_screen.dart';
import 'features/bills/bills_screen.dart';
import 'features/complaints/complaints_screen.dart';
import 'features/complaints/new_complaint_screen.dart';
import 'features/contacts/contacts_screen.dart';
import 'features/dashboard/main_screen.dart';
import 'features/events/events_screen.dart';
import 'features/feedback/feedback_screen.dart';
import 'features/notices/notices_screen.dart';
import 'features/parcels/parcel_screen.dart';
import 'features/parking/parking_screen.dart';
import 'features/polls/polls_screen.dart';
import 'features/profile/edit_profile_screen.dart';
import 'features/profile/profile_screen.dart';
import 'features/staff/new_staff_screen.dart';
import 'features/staff/staff_attendance_screen.dart';
import 'features/visitor_management/visitor_screen.dart';
import 'features/violations/rule_violations_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const SocietyEaseApp());
}



class SocietyEaseApp extends StatelessWidget {
  const SocietyEaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SocietyEase',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const LoginScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/main': (context) => const MainScreen(),
        '/register': (context) => const RegistrationScreen(),
        '/complaints': (context) => const ComplaintsScreen(),
        '/new_complaint': (context) => const NewComplaintScreen(),
        '/notices': (context) => const NoticesScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/edit_profile': (context) => const EditProfileScreen(),
        '/visitors': (context) => const VisitorScreen(),
        '/parcels': (context) => const ParcelScreen(),
        '/bills': (context) => const BillsScreen(),
        '/parking': (context) => const ParkingScreen(),
        '/feedback': (context) => const FeedbackScreen(),
        '/polls': (context) => const PollsScreen(),
        '/staff': (context) => const StaffAttendanceScreen(),
        '/add_staff': (context) => const NewStaffScreen(),
        '/events': (context) => const EventsScreen(),
        '/violations': (context) => const RuleViolationsScreen(),
        '/contacts': (context) => const ContactsScreen(),
        '/occupancy': (context) => const FlatOccupancyScreen(),
        '/admin': (context) => const AdminDashboardScreen(),
      },
    );
  }
}