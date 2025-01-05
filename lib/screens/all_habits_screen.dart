// lib/screens/all_habits_screen.dart

import 'package:flutter/material.dart';
import '../services/local_storage_service.dart';
import '../models/habit_model.dart';

class AllHabitsScreen extends StatefulWidget {
  const AllHabitsScreen({Key? key}) : super(key: key);

  @override
  State<AllHabitsScreen> createState() => _AllHabitsScreenState();
}

class _AllHabitsScreenState extends State<AllHabitsScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Habits'),
      ),
      body: ListView.builder(
        itemCount: _habits.length,
        itemBuilder: (context, index) {
          final habit = _habits[index];
          return ListTile(
            title: Text(habit.title),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.pushNamed(context, '/editHabit', arguments: habit)
                    .then((_) => _loadHabits());
              },
            ),
          );
        },
      ),
    );
  }
}
