import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login.dart';
import 'reviews_ratings.dart'; // Assume this page exists for displaying reviews and ratings

class Provider extends StatefulWidget {
  const Provider({super.key});

  @override
  State<Provider> createState() => _ProviderState();
}

class _ProviderState extends State<Provider> {
  User? user = FirebaseAuth.instance.currentUser; // Current logged-in user
  String? providerEmail;
  int _selectedIndex = 0; // Index for bottom navigation

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
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: providerEmail == null
          ? const Center(child: CircularProgressIndicator())
          : bookingDetails(), // Load booking details by provider email
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ReviewsRatingsPage()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Reviews & Ratings',
          ),
        ],
      ),
    );
  }

  // Widget to display the booking details
  Widget bookingDetails() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('bookings')
          .where('providerEmail', isEqualTo: providerEmail)
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
            DateTime? date;
            try {
              date = (booking['date'] as Timestamp).toDate(); // Convert Timestamp to DateTime
            } catch (e) {
              date = null; // In case of any error, set date to null
            }

            return Card(
              margin: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Booking ID: ${booking.id}'),
                    const SizedBox(height: 8),
                    Text('Date: ${date != null ? date.toLocal().toString().split(' ')[0] : 'No date available'}'), // Display date if available
                    Text('Slot: ${booking['slot']}'),
                    Text('Customer Phone: ${booking['customerPhone']}'),
                    Text('Customer City: ${booking['customerCity']}'),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Status: ${booking['status']}'),
                        ElevatedButton(
                          onPressed: booking['status'] == 'done'
                              ? null
                              : () => markWorkDone(booking.id),
                          child: const Text('Work Done'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> markWorkDone(String bookingId) async {
    try {
      await FirebaseFirestore.instance
          .collection('bookings')
          .doc(bookingId)
          .update({'status': 'done'});

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Status updated to 'done'")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update status: $e")),
      );
    }
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }
}
