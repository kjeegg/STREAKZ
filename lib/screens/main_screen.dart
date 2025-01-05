// lib/screens/main_screen.dart

import 'package:flutter/material.dart';
import 'package:habit_tracker_app/constants/colors.dart';

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
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Image.asset('lib/assets/icons/add_habit_button.png'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        onDestinationSelected: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: habitSecondary,
        indicatorColor: Colors.transparent,
        selectedIndex: _currentIndex,
        destinations: [
          NavigationDestination(
            selectedIcon: Image.asset(
              'lib/assets/icons/home_on.png',
              width: 47,
              height: 47,
            ),
            icon: Image.asset(
              'lib/assets/icons/home.png',
              width: 47,
              height: 47,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Image.asset(
              'lib/assets/icons/progress_on.png',
              width: 47,
              height: 47,
            ),
            icon: Image.asset(
              'lib/assets/icons/progress.png',
              width: 47,
              height: 47,
            ),
            label: 'Notifications',
          ),
          NavigationDestination(
            selectedIcon: Image.asset(
              'lib/assets/icons/explore_on.png',
              width: 47,
              height: 47,
            ),
            icon: Image.asset(
              'lib/assets/icons/explore.png',
              width: 47,
              height: 47,
            ),
            label: 'Notifications',
          ),
          NavigationDestination(
            selectedIcon: Image.asset(
              'lib/assets/icons/settings_on.png',
              width: 47,
              height: 47,
            ),
            icon: Image.asset(
              'lib/assets/icons/settings.png',
              width: 47,
              height: 47,
            ),
            label: 'Messages',
          ),
        ],
      ),

      // bottomNavigationBar:
      // BottomAppBar(
      //   shape: const CircularNotchedRectangle(),
      //   notchMargin: 8.0,
      //   color: Colors.white,
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     children: [
      //       IconButton(
      //         icon: const Icon(Icons.home),
      //         color: _currentIndex == 0 ? Theme.of(context).primaryColor : Colors.grey,
      //         onPressed: () => setState(() => _currentIndex = 0),
      //       ),
      //       IconButton(
      //         icon: const Icon(Icons.bar_chart),
      //         color: _currentIndex == 1 ? Theme.of(context).primaryColor : Colors.grey,
      //         onPressed: () => setState(() => _currentIndex = 1),
      //       ),
      //       const SizedBox(width: 48), // пространство для FAB
      //       IconButton(
      //         icon: const Icon(Icons.explore),
      //         color: _currentIndex == 2 ? Theme.of(context).primaryColor : Colors.grey,
      //         onPressed: () => setState(() => _currentIndex = 2),
      //       ),
      //       IconButton(
      //         icon: const Icon(Icons.emoji_events), // Achievements
      //         color: _currentIndex == 3 ? Theme.of(context).primaryColor : Colors.grey,
      //         onPressed: () => setState(() => _currentIndex = 3),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
