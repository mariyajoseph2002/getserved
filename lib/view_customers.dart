// cViewCustomers.dart
import 'package:flutter/material.dart';

class ViewCustomers extends StatelessWidget {
  const ViewCustomers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("cViewCustomers"),
      ),
      body: Center(
        child: Text(
          "View cViewCustomers Page",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
