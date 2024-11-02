import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CBooking extends StatefulWidget {
  final DocumentSnapshot provider;

  const CBooking({super.key, required this.provider});

  @override
  State<CBooking> createState() => _CBookingState();
}

class _CBookingState extends State<CBooking> {
  DateTime? _startDate;
  DateTime? _endDate;
  List<DateTime> _unavailableDates = [];
  final TextEditingController _remarksController = TextEditingController();
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _fetchUnavailableDates();
  }

  Future<void> _fetchUnavailableDates() async {
    // Fetch bookings for both contractors and customers
    final bookings = await FirebaseFirestore.instance
        .collection('bookings')
        .where('providerId', isEqualTo: widget.provider.id)
        .get();

    setState(() {
      _unavailableDates = bookings.docs
          .expand((doc) {
            var start = (doc['startDate'] as Timestamp).toDate();
            var end = (doc['endDate'] as Timestamp).toDate();
            return List.generate(
              end.difference(start).inDays + 1,
              (i) => start.add(Duration(days: i)),
            );
          })
          .toList();
    });
  }

  Future<void> _bookService() async {
    if (_startDate == null || _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select both start and end dates")),
      );
      return;
    }

    // Check if any selected date conflicts with unavailable dates
    List<DateTime> selectedDates = List.generate(
      _endDate!.difference(_startDate!).inDays + 1,
      (i) => _startDate!.add(Duration(days: i)),
    );

    if (selectedDates.any((date) => _unavailableDates.contains(date))) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Selected dates include already booked dates")),
      );
      return;
    }

    // Save the booking with additional details
    await FirebaseFirestore.instance.collection('bookings').add({
      'providerId': widget.provider.id,
      'providerEmail': widget.provider['email'],
      'contracterEmail': user!.email,
  
      'startDate': _startDate,
      'endDate': _endDate,
      'remarks': _remarksController.text,
      'status': "requested",
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Booking Successful!")),
    );
    Navigator.pop(context);
  }
Future<void> _selectDateRange(BuildContext context) async {
  final picked = await showDateRangePicker(
    context: context,
    firstDate: DateTime.now(),
    lastDate: DateTime(DateTime.now().year + 1),
    builder: (context, child) {
      return child ?? const SizedBox.shrink();
    },
  );

  if (picked != null) {
    // Generate the list of selected dates in the range
    List<DateTime> selectedDates = List.generate(
      picked.end.difference(picked.start).inDays + 1,
      (i) => picked.start.add(Duration(days: i)),
    );

    // Check if any of the selected dates are unavailable
    bool hasUnavailableDates = selectedDates.any((date) => _unavailableDates.contains(date));

    if (hasUnavailableDates) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Selected dates include already booked dates. Please choose a different range.")),
      );
    } else {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book ${widget.provider['firstName']}"),
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
            Text("Charge: Rs.${widget.provider['charge']}/hour"),
            const SizedBox(height: 16),

            // Date Range Picker
            Row(
              children: [
                Text(
                  _startDate == null
                      ? "Select Date Range"
                      : "Selected: ${_startDate!.toLocal()} to ${_endDate!.toLocal()}",
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => _selectDateRange(context),
                  child: const Text("Choose Dates"),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Remarks input field
            TextField(
              controller: _remarksController,
              decoration: const InputDecoration(
                labelText: "Remarks",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),

            // Booking button
            ElevatedButton(
              onPressed: _bookService,
              child: const Text("Book Now"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _remarksController.dispose();
    super.dispose();
  }
}
