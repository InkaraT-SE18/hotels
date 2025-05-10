// lib/pages/bookings_page.dart
import 'package:flutter/material.dart';
import '../db/booking_database.dart';
import '../models/booking.dart';

class BookingsPage extends StatefulWidget {
  const BookingsPage({super.key});

  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<Booking> _bookings = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBookings();
  }

  Future<void> _loadBookings() async {
    final bookings = await BookingDatabase().getAll();
    setState(() {
      _bookings.addAll(bookings);
      _isLoading = false;
      // Инициируем добавление элементов в AnimatedList после загрузки
      for (int i = 0; i < _bookings.length; i++) {
        _listKey.currentState?.insertItem(i);
      }
    });
  }

  Widget _buildItem(BuildContext context, int index, Animation<double> animation) {
    final booking = _bookings[index];
    return SizeTransition(
      sizeFactor: animation,
      child: FadeTransition(
        opacity: animation,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue.shade100,
                child: Text(booking.hotelName[0].toUpperCase()),
              ),
              title: Text(
                booking.hotelName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Даты: ${booking.dateRange}'),
                  Text('Номер: ${booking.roomType}'),
                  Text('Гостей: ${booking.guests}'),
                ],
              ),
              // trailing: const Icon(Icons.arrow_forward_ios),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                SliverAnimatedList(
                  key: _listKey,
                  initialItemCount: _bookings.length,
                  itemBuilder: _buildItem,
                ),
          
        
              ],
            ),
    );
  }
}
