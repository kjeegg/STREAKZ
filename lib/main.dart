// lib/main.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:habit_tracker_app/screens/add_habit_screen.dart';
import 'package:habit_tracker_app/screens/edit_habit_screen.dart';
import 'package:habit_tracker_app/screens/all_habits_screen.dart';
// Добавляем импорт экрана админ-панели
import 'screens/admin_panel_screen.dart';
import 'screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Инициализация SharedPreferences (по желанию можно просто вызвать в сервисе)
  await SharedPreferences.getInstance();

  runApp(const MyApp());
}

// Фрагмент в main.dart:

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const Color _bgColor = Color(0xFFFFF1D3);
  static const Color _mainOrange = Color(0xFFFF6F00);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habits App',
      theme: ThemeData(
        scaffoldBackgroundColor: _bgColor,
        primaryColor: _mainOrange,
        appBarTheme: const AppBarTheme(
          backgroundColor: _bgColor,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: _mainOrange,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.black54),
        ),
      ),
      // начальный экран - MainScreen
      initialRoute: '/',
      routes: {
        '/': (ctx) => const MainScreen(),
        '/addHabit': (ctx) => const AddHabitScreen(),
        '/editHabit': (ctx) => const EditHabitScreen(),
        '/allHabits': (ctx) => const AllHabitsScreen(),
        // Новый маршрут для админ-панели:
        '/admin': (context) => const AdminPanelScreen(),
      },
    );
  }
}

