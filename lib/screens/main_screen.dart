import 'package:flutter/material.dart';
import 'package:habit_tracker_app/constants/colors.dart';
import 'home_screen.dart';
import 'progress_screen.dart';
import 'explore_screen.dart';
import 'achievements_screen.dart';

/// MainScreen is a StatefulWidget that represents the main screen of the habit tracker app.
/// It contains a PageView to navigate between different screens and a bottom navigation bar.
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  /// Index of the currently selected tab.
  int _currentIndex = 0;

  /// PageController to control the PageView for screen swiping.
  final PageController _pageController = PageController(initialPage: 0);

  /// List of screens to display in the PageView.
  final List<Widget> _screens = const [
    HomeScreen(),
    ProgressScreen(),
    ExploreScreen(),
    AchievementsScreen(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: _screens,
      ),

      /// Bottom navigation bar to switch between different screens.
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
          _pageController.animateToPage(
            newIndex,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        backgroundColor: Colors.orange[100],
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
            label: 'Progress',
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
            label: 'Explore',
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
            label: 'Achievements',
          ),
        ],
      ),
    );
  }
}