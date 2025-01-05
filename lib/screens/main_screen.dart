// lib/screens/main_screen.dart

import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'progress_screen.dart';
import 'explore_screen.dart';
import 'achievements_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    ProgressScreen(),
    ExploreScreen(),
    AchievementsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],

      // Плавающая кнопка «+» (для добавления привычки)
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Переходим на экран добавления привычки
          Navigator.pushNamed(context, '/addHabit');
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              color: _currentIndex == 0 ? Theme.of(context).primaryColor : Colors.grey,
              onPressed: () => setState(() => _currentIndex = 0),
            ),
            IconButton(
              icon: const Icon(Icons.bar_chart),
              color: _currentIndex == 1 ? Theme.of(context).primaryColor : Colors.grey,
              onPressed: () => setState(() => _currentIndex = 1),
            ),
            const SizedBox(width: 48), // пространство для FAB
            IconButton(
              icon: const Icon(Icons.explore),
              color: _currentIndex == 2 ? Theme.of(context).primaryColor : Colors.grey,
              onPressed: () => setState(() => _currentIndex = 2),
            ),
            IconButton(
              icon: const Icon(Icons.emoji_events), // Achievements
              color: _currentIndex == 3 ? Theme.of(context).primaryColor : Colors.grey,
              onPressed: () => setState(() => _currentIndex = 3),
            ),
          ],
        ),
      ),
    );
  }
}
