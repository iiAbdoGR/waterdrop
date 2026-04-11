import 'package:flutter/material.dart';

class CustomBottomNav extends StatelessWidget {
  final String current;
  const CustomBottomNav({super.key, required this.current});

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    switch (current) {
      case 'home':
        currentIndex = 0;
        break;
      case 'history':
        currentIndex = 1;
        break;
      case 'sensors':
        currentIndex = 2;
        break;
      case 'settings':
        currentIndex = 3;
        break;
    }

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF0A5C71),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: BottomNavigationBar(
          backgroundColor: const Color(0xFF0A5C71),
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          selectedLabelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          currentIndex: currentIndex,
          onTap: (index) {
            if (index == currentIndex) return;
            switch (index) {
              case 0:
                Navigator.pushReplacementNamed(context, '/home');
                break;
              case 1:
                Navigator.pushReplacementNamed(context, '/history');
                break;
              case 2:
                Navigator.pushReplacementNamed(context, '/sensors');
                break;
              case 3:
                Navigator.pushReplacementNamed(context, '/settings');
                break;
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sensors),
              label: 'Sensors Info',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
