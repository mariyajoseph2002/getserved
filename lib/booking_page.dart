/* import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookingPage extends StatefulWidget {
  final DocumentSnapshot provider; // The selected provider

  const BookingPage({super.key, required this.provider});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime? _selectedDate;
  String? _selectedSlot;
  String? _customerEmail;


  final List<String> _timeSlots = ['9-12', '2-5'];

  @override
  void initState() {
    super.initState();
    _fetchCustomerEmail();
  }

  Future<void> _fetchCustomerEmail() async {
    // Assuming the user is already logged in
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      // Fetch customer details from Firestore
      DocumentSnapshot customerSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();

      if (customerSnapshot.exists && customerSnapshot['role'] == 'Customer') {
        setState(() {
          _customerEmail = customerSnapshot['email'];
        });
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _bookService() async {
    if (_selectedDate == null || _selectedSlot == null || _customerEmail == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a date, slot, and ensure you're logged in")),
      );
      return;
    }

    // Save booking details to Firestore
    await FirebaseFirestore.instance.collection('bookings').add({
      'providerEmail': widget.provider['email'],
      'customerEmail': _customerEmail,
      'date': _selectedDate,
      'slot': _selectedSlot,
      'status': "requested",
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Booking Successful!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book ${widget.provider['firstName']} ${widget.provider['lastName']}"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${widget.provider['firstName']} ${widget.provider['lastName']}",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text("Service Type: ${widget.provider['serviceType']}"),
            const SizedBox(height: 8),
            Text("Charge: Rs.${widget.provider['charge']}"),
            const SizedBox(height: 8),
            Text("Email: ${widget.provider['email']}"),
            const SizedBox(height: 8),
            Text("Gender: ${widget.provider['gender']}"),
            const SizedBox(height: 16),
            // Date Picker
            Row(
              children: [
                Text(
                  _selectedDate == null
                      ? "Select Date"
                      : "Selected Date: ${_selectedDate!.toLocal().toString().split(' ')[0]}",
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: const Text("Choose Date"),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Time Slot Dropdown
            DropdownButton<String>(
              hint: const Text("Select Time Slot"),
              value: _selectedSlot,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedSlot = newValue;
                });
              },
              items: _timeSlots.map((String slot) {
                return DropdownMenuItem<String>(
                  value: slot,
                  child: Text(slot),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            // Booking button
            ElevatedButton(
              onPressed: _bookService,
              child: const Text("Book Now"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 */
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookingPage extends StatefulWidget {
  final DocumentSnapshot provider; // The selected provider

  const BookingPage({super.key, required this.provider});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime? _selectedDate;
  String? _selectedSlot;
  String? _customerEmail;
  String? _customerPhone;
  String? _customerCity;

  final List<String> _timeSlots = ['9-12', '2-5'];

  @override
  void initState() {
    super.initState();
    _fetchCustomerDetails();
  }

  Future<void> _fetchCustomerDetails() async {
    // Assuming the user is already logged in
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      // Fetch customer details from Firestore
      DocumentSnapshot customerSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();

      if (customerSnapshot.exists && customerSnapshot['role'] == 'Customer') {
        setState(() {
          _customerEmail = customerSnapshot['email'];
          _customerPhone = customerSnapshot['phone']; // Fetch phone number
          _customerCity = customerSnapshot['city']; // Fetch city
        });
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _bookService() async {
    if (_selectedDate == null || _selectedSlot == null || _customerEmail == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a date, slot, and ensure you're logged in")),
      );
      return;
    }

    // Save booking details to Firestore
    await FirebaseFirestore.instance.collection('bookings').add({
      'providerEmail': widget.provider['email'],
      'customerEmail': _customerEmail,
      'customerPhone': _customerPhone, // Storing phone number
      'customerCity': _customerCity, // Storing city
      'date': _selectedDate,
      'slot': _selectedSlot,
      'status': "requested",
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Booking Successful!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book ${widget.provider['firstName']} ${widget.provider['lastName']}"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${widget.provider['firstName']} ${widget.provider['lastName']}",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text("Service Type: ${widget.provider['serviceType']}"),
            const SizedBox(height: 8),
            Text("Charge: Rs.${widget.provider['charge']}"),
            const SizedBox(height: 8),
            Text("Email: ${widget.provider['email']}"),
            const SizedBox(height: 8),
            Text("Gender: ${widget.provider['gender']}"),
            const SizedBox(height: 16),
            // Date Picker
            Row(
              children: [
                Text(
                  _selectedDate == null
                      ? "Select Date"
                      : "Selected Date: ${_selectedDate!.toLocal().toString().split(' ')[0]}",
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: const Text("Choose Date"),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Time Slot Dropdown
            DropdownButton<String>(
              hint: const Text("Select Time Slot"),
              value: _selectedSlot,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedSlot = newValue;
                });
              },
              items: _timeSlots.map((String slot) {
                return DropdownMenuItem<String>(
                  value: slot,
                  child: Text(slot),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            // Booking button
            ElevatedButton(
              onPressed: _bookService,
              child: const Text("Book Now"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
