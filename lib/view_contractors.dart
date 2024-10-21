// Contractors.dart
import 'package:flutter/material.dart';

class ViewContractors extends StatelessWidget {
  const ViewContractors({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contractors"),
      ),
      body: Center(
        child: Text(
          "View Contractors Page",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
