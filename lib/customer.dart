import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class Customer extends StatefulWidget {
  const Customer({super.key});

  @override
  State<Customer> createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {
  String? _selectedServiceType; // Holds the selected service type
  List<String> _serviceTypes = []; // List of service types
  bool _isLoading = false;

  // List to hold service providers fetched from Firestore
  List<DocumentSnapshot> _serviceProviders = [];

  @override
  void initState() {
    super.initState();
    _fetchServiceTypes(); // Fetch distinct service types on page load
    _fetchProviders(); // Fetch all service providers by default
  }

  // Fetch distinct service types from Firestore
  Future<void> _fetchServiceTypes() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'provider')
        .get();

    List<String> serviceTypes = querySnapshot.docs
        .map((doc) => doc.get('serviceType') as String)
        .toSet()
        .toList();

    setState(() {
      _serviceTypes = serviceTypes;
    });
  }

  // Fetch service providers, filtered by service type if selected
  Future<void> _fetchProviders() async {
    setState(() {
      _isLoading = true;
    });

    Query query = FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'provider');

    // If a service type is selected, apply the filter
    if (_selectedServiceType != null && _selectedServiceType!.isNotEmpty) {
      query = query.where('serviceType', isEqualTo: _selectedServiceType);
    }

    // Fetch the results from Firestore
    QuerySnapshot querySnapshot = await query.get();

    setState(() {
      _serviceProviders = querySnapshot.docs;
      _isLoading = false;
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer"),
        actions: [
          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Column(
        children: [
          _buildServiceTypeFilter(),
          const SizedBox(height: 16),
          _buildSearchButton(),
          const SizedBox(height: 16),
          Expanded(child: _buildServiceProviderList()),
        ],
      ),
    );
  }

  // Build service type dropdown filter
  Widget _buildServiceTypeFilter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: DropdownButtonFormField<String>(
        value: _selectedServiceType,
        decoration: const InputDecoration(
          labelText: "Select Service Type",
          border: OutlineInputBorder(),
        ),
        items: _serviceTypes
            .map((serviceType) => DropdownMenuItem(
                  value: serviceType,
                  child: Text(serviceType),
                ))
            .toList(),
        onChanged: (value) {
          setState(() {
            _selectedServiceType = value;
          });
        },
      ),
    );
  }

  // Build search button
  Widget _buildSearchButton() {
    return ElevatedButton(
      onPressed: _fetchProviders,
      child: const Text("Search"),
    );
  }

  // Build service provider list
  Widget _buildServiceProviderList() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_serviceProviders.isEmpty) {
      return const Center(child: Text("No service providers found."));
    }

    return ListView.builder(
      itemCount: _serviceProviders.length,
      itemBuilder: (context, index) {
        DocumentSnapshot provider = _serviceProviders[index];

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text(
              "${provider['firstName']} ${provider['lastName']}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Service Type: ${provider['serviceType']}"),
                Text("Charge: \$${provider['charge']}"),
                Text("Email: ${provider['email']}"),
                Text("Gender: ${provider['gender']}"),
              ],
            ),
          ),
        );
      },
    );
  }
}
