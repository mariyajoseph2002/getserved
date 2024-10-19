import 'package:flutter/material.dart';

// Assuming you have CustomerPage and ContracterPage widgets
import 'customer.dart'; // Import your CustomerPage widget
import 'Contracter.dart'; // Import your TeacherPage widget

class HomePage extends StatefulWidget {
  final String userRole; // 'student' or 'teacher'

  const HomePage({super.key, required this.userRole});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _navigateBasedOnRole();
  }

  void _navigateBasedOnRole() {
    if (widget.userRole == 'Customer') {
      // Navigate to CustomerPage
      Future.microtask(() => Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Customer())));
    } else if (widget.userRole == 'Contracter') {
      // Navigate to ContracterPage
      Future.microtask(() => Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Contracter())));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Corrected method signature
    // You can return a temporary placeholder widget while routing happens.
    return Scaffold(
      appBar: AppBar(
        title: const Text("Homepage"),
      ),
      body: const Center(
        child: CircularProgressIndicator(), // Loading indicator while routing
      ),
    );
  }
}
