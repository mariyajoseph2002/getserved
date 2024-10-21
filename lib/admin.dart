import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.dart';
import 'add_provider.dart';  // Add your respective pages here
import 'view_customers.dart';
import 'view_contractors.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("Admin Dashboard"),
        actions: [
          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      drawer: _buildDrawer(context), // Adding the Drawer here
      body: const Center(
        child: Text(
          "Welcome, Admin",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  // Drawer widget to create the sidebar
  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.teal,
            ),
            child: Text(
              'Admin Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          // Add Provider
          ListTile(
            leading: const Icon(Icons.person_add),
            title: const Text('Add Provider'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddProvider(),
                ),
              );
            },
          ),
          // View Customers
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('View Customers'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ViewCustomers(),
                ),
              );
            },
          ),
          // View Contractors
          ListTile(
            leading: const Icon(Icons.build),
            title: const Text('View Contractors'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ViewContractors(),
                ),
              );
            },
          ),
          // Log out option
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              logout(context);
            },
          ),
        ],
      ),
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
