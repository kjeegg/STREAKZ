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
  // Индекс текущей вкладки
  int _currentIndex = 0;

  // Контроллер PageView для перелистывания экранов
  final PageController _pageController = PageController(initialPage: 0);

  // Список экранов
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
      // Вместо floatingActionButton — используем Stack в body
      body: Stack(
        children: [
          // Анимированный PageView с экранами
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            children: _screens,
          ),

          // Позиционируем кнопку "Add Habit" где хотим
          Positioned(
            // Например, на 20 пикселей от правого края и на 60 пикселей выше нижнего края
            right: 20,
            bottom: 10,
            child: FloatingActionButton(
              onPressed: () {
                // Переход на экран добавления привычки
                Navigator.pushNamed(context, '/addHabit').then((_) {
                  // Когда вернулись, если надо обновить HomeScreen (индекс 0)
                  if (_currentIndex == 0) {
                    // Например, вызвать метод обновления через GlobalKey или т.п.
                  }
                });
              },
              backgroundColor: Colors.orange,
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),

      // Нижняя панель навигации
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



