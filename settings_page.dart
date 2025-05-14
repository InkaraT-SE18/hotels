import 'package:flutter/material.dart';
import '../main.dart';
import 'notifications_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with TickerProviderStateMixin {
  bool notificationsEnabled = true;
  String selectedLanguage = 'English';

  late AnimationController _controller;
  late List<Animation<Offset>> _slideAnimations;
  late List<Animation<double>> _fadeAnimations;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _slideAnimations = List.generate(5, (index) {
      return Tween<Offset>(
        begin: const Offset(0, 0.2),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(0.1 * index, 0.1 * index + 0.4, curve: Curves.easeOut),
        ),
      );
    });

    _fadeAnimations = List.generate(5, (index) {
      return Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(0.1 * index, 0.1 * index + 0.4, curve: Curves.easeIn),
        ),
      );
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget animatedItem({required int index, required Widget child}) {
    return SlideTransition(
      position: _slideAnimations[index],
      child: FadeTransition(
        opacity: _fadeAnimations[index],
        child: child,
      ),
    );
  }

  Route _createSlideRouteToNotifications() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const NotificationsPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    AppTheme currentTheme = themeNotifier.value;

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          animatedItem(
            index: 0,
            child: const Text(
              'Preferences',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          animatedItem(
            index: 1,
            child: ListTile(
              title: const Text("Language"),
              trailing: DropdownButton<String>(
                value: selectedLanguage,
                items: const [
                  DropdownMenuItem(value: 'Russian', child: Text('Russian')),
                  DropdownMenuItem(value: 'English', child: Text('English')),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedLanguage = value!;
                  });
                },
              ),
            ),
          ),
          animatedItem(
            index: 2,
            child: ListTile(
              leading: const Hero(
                tag: 'notification-icon',
                child: Icon(Icons.notifications),
              ),
              title: const Text('Notifications'),
              onTap: () {
                Navigator.of(context).push(_createSlideRouteToNotifications());
              },
            ),
          ),
        
animatedItem(
  index: 3,
  child: ListTile(
    title: const Text('Theme'),
    trailing: DropdownButton<AppTheme>(
      value: currentTheme,
      items: const [
        DropdownMenuItem(
          value: AppTheme.light,
          child: Text('Light'),
        ),
        DropdownMenuItem(
          value: AppTheme.dark,
          child: Text('Dark'),
        ),
        DropdownMenuItem(
          value: AppTheme.blue,
          child: Text('Blue'),
        ),
        DropdownMenuItem(
          value: AppTheme.green,
          child: Text('Green'),
        ),
      ],
      onChanged: (value) {
        setState(() {
          themeNotifier.value = value!;
        });
      },
    ),
  ),
),

          const Divider(height: 32),
          animatedItem(
            index: 4,
            child: const ListTile(
              title: Text("About App"),
              subtitle: Text("Hotel Booking v1.0\n created by AITU ❤️"),
            ),
          ),
        ],
      ),
    );
  }
}
