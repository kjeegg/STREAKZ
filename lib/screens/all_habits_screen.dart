import 'package:flutter/material.dart';
import '../services/local_storage_service.dart';
import '../models/habit_model.dart';
import 'package:habit_tracker_app/constants/colors.dart';

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
        child: _habits.isEmpty
            ? const Center(
          child: Text(
            'No habits added yet. Press "+" to add new.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        )
            : ListView.builder(
          itemCount: _habits.length,
          itemBuilder: (context, index) {
            final habit = _habits[index];
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.orange[200],
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
                          .then((_) => _loadHabits());
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
