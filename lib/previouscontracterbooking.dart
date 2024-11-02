import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'contracter.dart'; // Import the customer page
import 'feedback_page.dart'; // Import the Feedback page

class PreviousContracterBooking extends StatefulWidget {
  const PreviousContracterBooking({super.key});

  @override
  _PreviouscontracterbookingState createState() => _PreviouscontracterbookingState();
}

class _PreviouscontracterbookingState extends State<PreviousContracterBooking> {
  int _selectedIndex = 1; // Set the initial index to 1 (Previous ContracterBookingPreviouscontracterbooking)

  void _onItemTapped(int index) {
    if (index == 0) {
      // Navigate to the Home (Contractor) page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Contracter()),
      );
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Previous Orders"),
        backgroundColor: const Color.fromARGB(255, 243, 173, 103),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('bookings')
            .where('customerEmail', isEqualTo: user?.email) // Filter by the logged-in contractor's email
            .where('status', isEqualTo: 'done') // Filter by status 'done'
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No completed bookings available."));
          }

          final orders = snapshot.data!.docs;

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              var order = orders[index];
              DateTime startDate = (order['startDate'] as Timestamp).toDate();
              DateTime endDate = (order['endDate'] as Timestamp).toDate();

              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text('Booking ID: ${order.id}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Provider: ${order['providerEmail']}'),
                      Text('Start Date: ${startDate.toLocal()}'.split(' ')[0]),
                      Text('End Date: ${endDate.toLocal()}'.split(' ')[0]),
                    ],
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FeedbackPage(
                            customerEmail: user!.email!,
                            providerEmail: order['providerEmail'],
                          ),
                        ),
                      );
                    },
                    child: const Text("Add Feedback"),
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Previous Orders',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 142, 142, 142),
        onTap: _onItemTapped,
      ),
    );
  }
}
