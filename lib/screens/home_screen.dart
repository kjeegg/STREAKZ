import 'package:flutter/material.dart';
import '../services/local_storage_service.dart';
import '../models/habit_model.dart';
import 'package:habit_tracker_app/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

/// HomeScreen is a StatefulWidget that represents the home screen of the habit tracker app.
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

  final List<bool> completed = [false, false, false, false, false];

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

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 50.0, left: 30.0, right: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Home",
                    style: GoogleFonts.coiny(
                      textStyle: Theme.of(context).textTheme.displayLarge,
                      fontSize: 40,
                      fontWeight: FontWeight.w400,
                      color: habitAccent2,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  // Current Streak block
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

                  // Date
                  Text(
                    'Today: $dateStr',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/admin');
                    },
                    child: const Text('Admin Panel'),
                  ),
                  const SizedBox(height: 16),

                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.only(bottom: 80),
                      children: _habits.map((habit) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color: habitAccent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  habit.title,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
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
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/addHabit');
                },
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle, // Круглая форма
                    gradient: LinearGradient(
                      colors: [Colors.orange, Colors.red],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 6,
                        offset: const Offset(0, 3), // Смещение тени
                      ),
                    ],
                  ),
                  child: const Icon(Icons.add, color: Colors.black, size: 36),
                ),
              ),
            ),
          ],
        ),
      ),
      // Floating button to "All Habits" screen
      floatingActionButton: _habits.length > 0
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.pushNamed(context, '/allHabits');
              },
              label: const Text('All Habits'),
              icon: const Icon(Icons.list),
              backgroundColor: Colors.orange,
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
