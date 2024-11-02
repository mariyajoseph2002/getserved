import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.dart';
import 'previouscontracterbooking.dart';
import 'cbooking.dart';

class Contracter extends StatefulWidget {
  const Contracter({super.key});

  @override
  State<Contracter> createState() => _ContracterState();
}

class _ContracterState extends State<Contracter> {
  int _selectedIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contracter"),
        actions: [
          IconButton(
            onPressed: () => logout(context),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: _selectedIndex == 0 ? _buildProviderList() : const PreviousContracterBooking(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Providers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Previous Bookings',
          ),
        ],
      ),
    );
  }

  // Build provider list with details in a card format
  Widget _buildProviderList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: 'provider')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        var providers = snapshot.data!.docs;

        return ListView.builder(
          itemCount: providers.length,
          itemBuilder: (context, index) {
            var provider = providers[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: ListTile(
                contentPadding: const EdgeInsets.all(10),
                title: Text(
                  "${provider['firstName']} ${provider['lastName']}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Service: ${provider['serviceType'] ?? 'N/A'}"),
                    Text("Email: ${provider['email'] ?? 'N/A'}"),
                    Text("Phone: ${provider['phone'] ?? 'N/A'}"),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CBooking(provider: provider),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }
}
