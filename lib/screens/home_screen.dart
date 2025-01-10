import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // для форматирования месяца
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

  // Список названий дней недели (по умолчанию: Понедельник = 0, ... , Воскресенье = 6)
  final List<String> _weekdays = ['Mo','Tu','We','Th','Fr','Sa','Su'];

  // Индекс выбранного дня недели (0..6). В DateTime: Mon=1..Sun=7, поэтому немного сдвигаем.
  late int _selectedDayIndex;

  @override
  void initState() {
    super.initState();
    _loadData();
    // При загрузке сразу выделим «сегодня»
    final today = DateTime.now();
    // today.weekday: 1..7 (1 = Пн, 7 = Вс)
    // Приведём к 0..6
    _selectedDayIndex = (today.weekday - 1) % 7;
  }

  /// Загрузка данных из локального хранилища
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
    // Текущее время и текущий месяц (без года)
    final now = DateTime.now();
    final String currentMonthName = DateFormat.MMMM().format(now); // например, "January"

    // Найдём понедельник текущей недели (чтобы дни шли Mo..Su подряд):
    final DateTime mondayThisWeek = now.subtract(Duration(days: now.weekday - 1));

    // Фильтруем привычки, которые относятся к выбранному (_selectedDayIndex) дню
    final List<Habit> habitsForSelectedDay = _habits.where((habit) {
      if (_selectedDayIndex < habit.days.length) {
        return habit.days[_selectedDayIndex];
      }
      return false;
    }).toList();

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0, left: 30.0, right: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Заголовок экрана
                  Text(
                    "Home",
                    style: GoogleFonts.coiny(
                      textStyle: Theme.of(context).textTheme.displayLarge,
                      fontSize: 40,
                      fontWeight: FontWeight.w400,
                      color: habitAccent2,
                    ),
                  ),
                  const SizedBox(height: 20.0),

                  // Блок Current Streak
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

                  // -----------------------------
                  // РЯД: "Название месяца" слева + "7 дней" справа
                  // -----------------------------
        Row(
          // Месяц слева, дни справа
          children: [
            // 1) Название месяца
            Text(
              currentMonthName,
              style: GoogleFonts.nunitoSans(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: habitText,
              ),
            ),

            // 2) Пространство между месяцем и днями
            const SizedBox(width: 16),

            // 3) Блок с днями ( Expanded или Flexible )
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(7, (index) {
                  final day = mondayThisWeek.add(Duration(days: index));
                  final dayNum = day.day;
                  final isSelected = (index == _selectedDayIndex);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDayIndex = index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: isSelected ? habitPrimary : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min, // чтобы высота подстраивалась
                        children: [
                          Text(
                            _weekdays[index], // Mo, Tu, ...
                            style: GoogleFonts.nunitoSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: isSelected ? Colors.black : habitText,
                            ),
                          ),
                          Text(
                            '$dayNum',
                            style: GoogleFonts.nunitoSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: isSelected ? Colors.black : habitText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
                  // -----------------------------
                  // Кнопка Admin Panel
                  // -----------------------------
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/admin').then((result) {
                        if (result == true) {
                          _loadData(); // Обновляем данные после возврата
                        }
                      });
                    },
                    child: const Text('Admin Panel'),
                  ),
                  const SizedBox(height: 16),

                  // -----------------------------
                  // Список привычек для выбранного дня (_selectedDayIndex)
                  // -----------------------------
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.only(bottom: 80),
                      children: habitsForSelectedDay.map((habit) {
                        // Если habit.isDone = true => зачёркиваем
                        final textStyle = GoogleFonts.nunitoSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          decoration: habit.isDone ? TextDecoration.lineThrough : null,
                        );
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: habitAccent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  habit.title,
                                  style: textStyle,
                                ),
                              ),
                              // Иконка isDone
                              IconButton(
                                icon: habit.isDone
                                    ? const Icon(Icons.check_circle)
                                    : const Icon(Icons.radio_button_unchecked),
                                onPressed: () async {
                                  setState(() {
                                    habit.isDone = !habit.isDone;
                                  });
                                  // Сохраним изменения
                                  await _storageService.saveHabits(_habits);
                                },
                              ),
                              // Иконка редактировать
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/editHabit',
                                    arguments: habit, // Передаём объект Habit
                                  ).then((result) {
                                    if (result == true) {
                                      _loadData();
                                    }
                                  });
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

            // Кнопка добавления новой привычки (снизу справа)
            Positioned(
              bottom: 20,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/addHabit').then((result) {
                    if (result == true) {
                      _loadData(); // Обновляем данные
                    }
                  });
                },
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [Colors.orange, Colors.red],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
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

      // FAB "All Habits" - если список не пуст
      floatingActionButton: _habits.isNotEmpty
          ? FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/allHabits');
        },
        label: const Text('All Habits'),
        icon: const Icon(Icons.list),
        backgroundColor: habitPrimary,
      )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
