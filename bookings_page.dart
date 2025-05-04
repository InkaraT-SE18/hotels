// lib/pages/bookings_page.dart
import 'package:flutter/material.dart';
import '../db/booking_database.dart';
import '../models/booking.dart';
import 'edit_booking_page.dart';

class BookingsPage extends StatefulWidget {
  const BookingsPage({super.key});

  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {
  List<Booking> bookings = [];

  @override
  void initState() {
    super.initState();
    _loadBookings();
  }

  Future<void> _loadBookings() async {
    final data = await BookingDatabase.instance.readAllBookings();
    setState(() {
      bookings = data;
    });
  }

  Future<void> _deleteBooking(int id) async {
    await BookingDatabase.instance.delete(id);
    _loadBookings();
  }

  void _editBooking(Booking booking) async {
    final updated = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditBookingPage(booking: booking),
      ),
    );
    if (updated == true) {
      _loadBookings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bookings.isEmpty
          ? const Center(child: Text('Нет активных бронирований'))
          : ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final b = bookings[index];
                return Dismissible(
                  key: Key(b.id.toString()),
                  background: Container(color: Colors.red, alignment: Alignment.centerRight, padding: const EdgeInsets.only(right: 20), child: const Icon(Icons.delete, color: Colors.white)),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    _deleteBooking(b.id!);
                  },
                  child: ListTile(
                    title: Text(b.hotelName),
                    subtitle: Text('${b.dateRange}, ${b.roomType}, ${b.guests} чел.'),
                    trailing: const Icon(Icons.edit),
                    onTap: () => _editBooking(b),
                  ),
                );
              },
            ),
    );
  }
}
