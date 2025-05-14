import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/settings_page.dart';
import 'auth/auth_gate.dart';
import 'firebase_options.dart';
import 'pages/home_page.dart';
import 'pages/bookings_page.dart';
import 'pages/profile_page.dart';
import 'pages/notifications_page.dart';

enum AppTheme { light, dark, blue, green }

final ValueNotifier<AppTheme> themeNotifier = ValueNotifier(AppTheme.light);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const HotelBookingApp());
}

class HotelBookingApp extends StatelessWidget {
  const HotelBookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppTheme>(
      valueListenable: themeNotifier,
      builder: (_, AppTheme currentTheme, __) {
        ThemeData themeData;
        
        switch (currentTheme) {
          case AppTheme.dark:
            themeData = ThemeData.dark();
            break;
          case AppTheme.blue:
            themeData = ThemeData(
              colorScheme: ColorScheme.light(
                primary: Colors.blue,
                secondary: Colors.blueAccent,
                surface: const Color.fromARGB(255, 170, 189, 220),
              ),
              scaffoldBackgroundColor: const Color.fromARGB(255, 207, 235, 255),
              appBarTheme: AppBarTheme(
                color: const Color.fromARGB(255, 105, 188, 255),
                foregroundColor: Colors.white,
              ),
            );
            break;
          case AppTheme.green:
            themeData = ThemeData(
              colorScheme: ColorScheme.light(
                primary: Colors.green,
                secondary: Colors.greenAccent,
                surface: const Color.fromARGB(255, 255, 255, 255),
              ),
              scaffoldBackgroundColor: const Color.fromARGB(255, 208, 255, 213),
              appBarTheme: AppBarTheme(
                color: const Color.fromARGB(255, 146, 255, 149),
                foregroundColor: Colors.white,
              ),
            );
            break;
          case AppTheme.light:
          themeData = ThemeData.light();
        }
        
        return MaterialApp(
          title: 'Hotel Booking',
          debugShowCheckedModeBanner: false,
          theme: themeData,
          darkTheme: ThemeData.dark(),
          themeMode: currentTheme == AppTheme.dark ? ThemeMode.dark : ThemeMode.light,
          home: const AuthGate(),
        );
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const BookingsPage(),
    const ProfilePage(),
    const SettingsPage(),
    const NotificationsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<String> _titles = [
    'Home',
    'Booking',
    'Profile',
    'Settings',
    'Notifications',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Booking'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),
        ],
      ),
    );
  }
}
