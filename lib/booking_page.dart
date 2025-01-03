 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookingPage extends StatefulWidget {
  final DocumentSnapshot provider;

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
  List<Map<String, dynamic>> _feedbackList = []; // To store feedback data
  List<DateTime> _unavailableDates = [];

  final List<String> _timeSlots = ['9-12', '2-5'];
  final TextEditingController _remarksController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchCustomerDetails();
    _fetchUnavailableDates();
    _fetchFeedback(); // Fetch feedback for the selected provider
  }

  Future<void> _fetchCustomerDetails() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      DocumentSnapshot customerSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();

      if (customerSnapshot.exists && customerSnapshot['role'] == 'Customer') {
        setState(() {
          _customerEmail = customerSnapshot['email'];
          _customerPhone = customerSnapshot['phone'];
          _customerCity = customerSnapshot['city'];
        });
      }
    }
  }

  Future<void> _fetchUnavailableDates() async {
    final bookedDates = await FirebaseFirestore.instance
        .collection('bookings')
        .where('providerEmail', isEqualTo: widget.provider['email'])
        .get();

    setState(() {
      _unavailableDates = bookedDates.docs.map((doc) {
        Timestamp timestamp = doc['date'];
        return timestamp.toDate();
      }).toList();
    });
  }

  Future<void> _fetchFeedback() async {
    final feedbackSnapshot = await FirebaseFirestore.instance
        .collection('feedback')
        .where('providerEmail', isEqualTo: widget.provider['email'])
        .get();

    setState(() {
      _feedbackList = feedbackSnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
      selectableDayPredicate: (date) {
        // Disable dates that are in the unavailableDates list
        return !_unavailableDates.any((unavailableDate) =>
            unavailableDate.year == date.year &&
            unavailableDate.month == date.month &&
            unavailableDate.day == date.day);
      },
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

    await FirebaseFirestore.instance.collection('bookings').add({
      'providerEmail': widget.provider['email'],
      'customerEmail': _customerEmail,
      'customerPhone': _customerPhone,
      'customerCity': _customerCity,
      'date': _selectedDate,
      'slot': _selectedSlot,
      'status': "requested",
      'remarks': _remarksController.text, // Store remarks in Firestore
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
        backgroundColor: const Color.fromARGB(255, 243, 173, 103),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
              const SizedBox(height: 8),
              Text("Additional info: ${widget.provider['additionalDetails']}"),
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

              // Remarks TextField
              TextField(
                controller: _remarksController,
                decoration: const InputDecoration(
                  labelText: "Remarks",
                  hintText: "Add any additional information or requirements",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),

              // Booking button
              ElevatedButton(
                onPressed: _bookService,
                child: const Text("Book Now"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 243, 173, 103),
                ),
              ),
              const SizedBox(height: 24),

              // Feedback section
              const Text(
                "Feedback",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _feedbackList.isEmpty
                  ? const Text("No feedback available.")
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _feedbackList.length,
                      itemBuilder: (context, index) {
                        final feedback = _feedbackList[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            title: Text("Rating: ${feedback['rating']}"),
                            subtitle: Text(feedback['comment'] ?? "No comment provided"),
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
 


/*
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
  List<DateTime> _unavailableDates = []; // List to store unavailable dates

  final List<String> _timeSlots = ['9-12', '2-5'];

  @override
  void initState() {
    super.initState();
    _fetchCustomerDetails();
    _fetchUnavailableDates(); // Fetch unavailable dates on init
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

  Future<void> _fetchUnavailableDates() async {
    final bookedDates = await FirebaseFirestore.instance
        .collection('bookings')
        .where('providerEmail', isEqualTo: widget.provider['email'])
        .get();

    setState(() {
      _unavailableDates = bookedDates.docs.map((doc) {
        Timestamp timestamp = doc['date'];
        return timestamp.toDate();
      }).toList();
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
      selectableDayPredicate: (date) {
        // Disable dates that are already booked by this provider
        return !_unavailableDates.any((unavailableDate) =>
            unavailableDate.year == date.year &&
            unavailableDate.month == date.month &&
            unavailableDate.day == date.day);
      },
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
*/