import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Добавьте
import 'package:firebase_core/firebase_core.dart';
// Если генерировали файл с настройками автоматом flutterfire configure,
// подключите его. Иначе можете использовать пустой Firebase.initializeApp().
//import 'firebase_options.dart'; // <- если есть

import 'package:habit_tracker_app/screens/add_habit_screen.dart';
import 'package:habit_tracker_app/screens/edit_habit_screen.dart';
import 'package:habit_tracker_app/screens/all_habits_screen.dart';
import 'screens/admin_panel_screen.dart';
import 'screens/main_screen.dart';
import 'package:habit_tracker_app/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

/// The main function initializes the app and runs the MyApp widget.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Инициализация SharedPreferences
  await SharedPreferences.getInstance();

  // Инициализация Firebase
  await Firebase.initializeApp(
    // Если у вас создан файл firebase_options.dart (через flutterfire),
    // используйте его:

  );

  runApp(const MyApp());
}

/// Создаёт PageRouteBuilder с анимацией слайд-перехода.
Route createSlideRoute(Widget page) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final begin = const Offset(1.0, 0.0);
      final end = Offset.zero;
      final curve = Curves.easeInOut;

      final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      final offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

/// The main widget of the application.
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
      initialRoute: '/',
      routes: {
        '/': (ctx) => const MainScreen(),
        '/addHabit': (ctx) => const AddHabitScreen(),
        '/editHabit': (ctx) => const EditHabitScreen(),
        '/allHabits': (ctx) => const AllHabitsScreen(),
        '/admin': (context) => AdminPanelScreen(),
      },
    );
  }
}
