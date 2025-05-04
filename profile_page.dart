import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
    
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/hotels/hotel1.jpg'), 
            ),
            const SizedBox(height: 16),

            
            const Text(
              'Айгерим О.',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

           
            const Text(
              'aigerim@gmail.com',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),

            const SizedBox(height: 24),

            
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Настройки'),
              onTap: () {
               
              },
            ),
            ListTile(
              leading: const Icon(Icons.help_outline),
              title: const Text('Помощь'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Выход'),
              onTap: () {
                
              },
            ),
          ],
        ),
      ),
    );
  }
}