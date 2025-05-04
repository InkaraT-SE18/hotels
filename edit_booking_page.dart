// lib/pages/edit_booking_page.dart
import 'package:flutter/material.dart';
import '../models/booking.dart';
import '../db/booking_database.dart';

class EditBookingPage extends StatefulWidget {
  final Booking booking;

  const EditBookingPage({super.key, required this.booking});

  @override
  State<EditBookingPage> createState() => _EditBookingPageState();
}

class _EditBookingPageState extends State<EditBookingPage> {
  final _formKey = GlobalKey<FormState>();

  late String _roomType;
  late int _guests;

  @override
  void initState() {
    super.initState();
    _roomType = widget.booking.roomType;
    _guests = widget.booking.guests;
  }

  void _submitUpdate() async {
    if (_formKey.currentState!.validate()) {
      final updatedBooking = widget.booking.copyWith(
        roomType: _roomType,
        guests: _guests,
      );

      final db = await BookingDatabase.instance.database;
      await db.update(
        'bookings',
        updatedBooking.toMap(),
        where: 'id = ?',
        whereArgs: [updatedBooking.id],
      );

      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Редактировать бронирование')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text('Отель: ${widget.booking.hotelName}', style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _roomType,
                decoration: const InputDecoration(labelText: 'Класс номера'),
                items: ['Люкс', 'Средний', 'Эконом']
                    .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _roomType = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Количество персон'),
                initialValue: _guests.toString(),
                keyboardType: TextInputType.number,
                validator: (value) {
                  final guests = int.tryParse(value ?? '');
                  if (guests == null || guests < 1) {
                    return 'Введите корректное количество';
                  }
                  return null;
                },
                onChanged: (value) {
                  final parsed = int.tryParse(value);
                  if (parsed != null) _guests = parsed;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitUpdate,
                child: const Text('Сохранить изменения'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
