// lib/main.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:habit_tracker_app/screens/add_habit_screen.dart';
import 'package:habit_tracker_app/screens/edit_habit_screen.dart';
import 'package:habit_tracker_app/screens/all_habits_screen.dart';
// Добавляем импорт экрана админ-панели
import 'screens/admin_panel_screen.dart';
import 'screens/main_screen.dart';
import 'package:habit_tracker_app/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Инициализация SharedPreferences (по желанию можно просто вызвать в сервисе)
  await SharedPreferences.getInstance();

  runApp(const MyApp());
}

// Фрагмент в main.dart:

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habits App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: habitBG,
        primaryColor: habitPrimary,
        appBarTheme: const AppBarTheme(
          backgroundColor: habitBG,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: habitPrimary,
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

