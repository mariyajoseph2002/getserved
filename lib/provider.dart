import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // For Firestore usage

import 'login.dart';

class Provider extends StatefulWidget {
  const Provider({super.key});

  @override
  State<Provider> createState() => _ProviderState();
}

class _ProviderState extends State<Provider> {
  User? user = FirebaseAuth.instance.currentUser; // Current logged-in user
  String? providerEmail;

  @override
  void initState() {
    super.initState();
    providerEmail = user?.email; // Fetch provider's email
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("Provider"),
        actions: [
          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: const Icon(
              Icons.logout,
            ),
          )
        ],
      ),
      body: providerEmail == null
          ? const Center(child: CircularProgressIndicator())
          : bookingDetails(), // Load booking details by provider email
    );
  }

  // Widget to display the booking details
  Widget bookingDetails() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('bookings') // Assuming your collection name is 'bookings'
          .where('providerEmail', isEqualTo: providerEmail) // Filter bookings by provider's email
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No bookings available.'));
        }

        final bookings = snapshot.data!.docs;

        return ListView.builder(
          itemCount: bookings.length,
          itemBuilder: (context, index) {
            var booking = bookings[index];
            return Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text('Booking ID: ${booking.id}'),
                subtitle: Text('Date: ${booking['date']}\nSlot: ${booking['slot']}'),
                trailing: Text('Status: ${booking['status']}'),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> logout(BuildContext context) async {
    const CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }
}
