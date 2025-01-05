// lib/screens/admin_panel_screen.dart

import 'package:flutter/material.dart';
import '../services/local_storage_service.dart';
import '../models/habit_model.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  final LocalStorageService _storageService = LocalStorageService();
  List<Habit> _habits = [];

  @override
  void initState() {
    super.initState();
    _loadHabits();
  }

  Future<void> _loadHabits() async {
    final habits = await _storageService.loadHabits();
    setState(() {
      _habits = habits;
    });
  }

  // Очистка всех привычек
  Future<void> _clearAllHabits() async {
    await _storageService.saveHabits([]); // Пустой список = удаляем все привычки
    await _loadHabits();
  }

  // Добавление тестовых привычек
  Future<void> _addTestHabits() async {
    final existingHabits = await _storageService.loadHabits();

    // Пример тестовых привычек
    final List<Habit> testHabits = [
      Habit(
        title: 'Meditate 5 min (Test)',
        days: [true, false, true, false, true, false, false],
        time: '09:00',
        reminder: 'Once a day',
        colorIndex: 1,
      ),
      Habit(
        title: 'Read 10 pages (Test)',
        days: [true, true, false, false, true, true, false],
        time: '21:00',
        reminder: 'Never',
        colorIndex: 0,
      ),
    ];

    // Просто дополняем список текущих
    existingHabits.addAll(testHabits);
    await _storageService.saveHabits(existingHabits);
    await _loadHabits();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Кнопка очистки
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: _clearAllHabits,
              child: const Text('Clear All Habits'),
            ),
            const SizedBox(height: 10),

            // Кнопка добавления тестовых привычек
            ElevatedButton(
              onPressed: _addTestHabits,
              child: const Text('Add Test Habits'),
            ),
            const SizedBox(height: 20),

            // Отображаем список текущих привычек
            Text(
              'Current habits:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            _habits.isEmpty
                ? const Text('No habits in storage.')
                : Column(
              children: _habits.map((habit) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        habit.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Time: ${habit.time}'),
                      Text('Reminder: ${habit.reminder}'),
                      Text('Days: ${_formatDays(habit.days)}'),
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

  // Просто переводим [true, false, true, ...] в "M, W, F" и т.д.
  String _formatDays(List<bool> days) {
    final dayLabels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    List<String> selectedDays = [];
    for (int i = 0; i < days.length; i++) {
      if (days[i]) {
        selectedDays.add(dayLabels[i]);
      }
    }
    return selectedDays.isEmpty ? 'No days selected' : selectedDays.join(', ');
  }
}
