// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import '../services/local_storage_service.dart';
import '../models/habit_model.dart';
import 'package:habit_tracker_app/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LocalStorageService _storageService = LocalStorageService();
  List<Habit> _habits = [];
  int _globalStreak = 0;
  int _level = 1;
  int _xp = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final habits = await _storageService.loadHabits();
    final streak = await _storageService.loadGlobalStreak();
    final level = await _storageService.loadGlobalLevel();
    final xp = await _storageService.loadGlobalXP();

    setState(() {
      _habits = habits;
      _globalStreak = streak;
      _level = level;
      _xp = xp;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now();
    final dateStr =
        '${currentDate.day}.${currentDate.month}.${currentDate.year}';

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 30,
          right: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 100, bottom: 25),
              child: Text(
                "Home",
                style: GoogleFonts.coiny(
                  textStyle: Theme.of(context).textTheme.displayLarge,
                  fontSize: 40,
                  fontWeight: FontWeight.w400,
                  color: habitAccent2,
                ),
              ),
            ),
            // Блок "Current Streak"
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Current Streak',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunitoSans(
                      color: habitText,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      height: 0.92,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '$_globalStreak',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunitoSans(
                          color: habitText,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          height: 0.92,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Image.asset(
                        'lib/assets/images/streak_flame.png',
                        width: 16,
                        height: 23,
                      ),

                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Дата
            Text(
              'Сегодня: $dateStr',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/admin');
              },
              child: const Text('Admin Panel'),
            ),

            const SizedBox(height: 16),

            // Список привычек (или текст "нет привычек")
            _habits.isEmpty
                ? const Text(
                    'Пока нет привычек.\nНажмите "+", чтобы добавить новую.',
                    textAlign: TextAlign.center,
                  )
                : Column(
                    children: _habits.map((habit) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                habit.title,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                Navigator.pushNamed(context, '/editHabit',
                                        arguments: habit)
                                    .then((_) => _loadData());
                              },
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
          ],
        ),
      ),
    );
  }
}
