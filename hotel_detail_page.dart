import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../models/hotel.dart';
import 'booking_form_page.dart';
import 'live_location_page.dart';

class HotelDetailPage extends StatelessWidget {
  final Hotel hotel;

  const HotelDetailPage({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(hotel.name)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              hotel.imagePath,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(hotel.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(hotel.city, style: const TextStyle(fontSize: 16, color: Color.fromARGB(255, 20, 1, 1))),
                  const SizedBox(height: 16),
                  Text(hotel.description),
                  const SizedBox(height: 16),
                  SizedBox(
  width: double.infinity,
  height: 200,
  child: InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LiveLocationPage(),
        ),
      );
    },
    child: FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(hotel.latitude, hotel.longitude),
        initialZoom: 13.0,
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.all,

        ),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: const ['a', 'b', 'c'],
          userAgentPackageName: 'com.example.booking_hotels',
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: LatLng(hotel.latitude, hotel.longitude),
              width: 40,
              height: 40,
              child: const Icon(Icons.location_pin, size: 40, color: Colors.red),
            ),
          ],
        ),
      ],
    ),
  ),
),

const SizedBox(height: 16), // отступ между картой и кнопками

// Кнопка "Посмотреть на карте (Live Location)"
SizedBox(
  width: double.infinity,
  child: ElevatedButton.icon(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LiveLocationPage(),
        ),
      );
    },
    icon: const Icon(Icons.map),
    label: const Text('Посмотреть на карте (Live Location)'),
  ),
),

const SizedBox(height: 10), // небольшой отступ между кнопками

SizedBox(
  width: double.infinity,
  child: ElevatedButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookingFormPage(hotel: hotel),
        ),
      );
    },
    child: const Text("Перейти к бронированию"),
  ),
),


 
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
