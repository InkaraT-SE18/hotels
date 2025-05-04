// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import '../data/hotels.dart';
import '../models/hotel.dart';
import 'hotel_detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final List<String> cities = const ['Astana', 'Almaty', 'Shymkent'];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: cities.map((city) {
        final List<Hotel> cityHotels = allHotels
            .where((hotel) => hotel.city.toLowerCase() == city.toLowerCase())
            .toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(city, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 9),
            SizedBox(
              height: 350,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: cityHotels.length,
                itemBuilder: (context, index) {
                  final hotel = cityHotels[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HotelDetailPage(hotel: hotel),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.only(right: 12),
                      child: SizedBox(
                        width: 250,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              hotel.imagePath,
                              height: 270,
                              width: 250,
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(hotel.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                                  Text(hotel.description, maxLines: 2, overflow: TextOverflow.ellipsis),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        );
      }).toList(),
    );
  }
}
