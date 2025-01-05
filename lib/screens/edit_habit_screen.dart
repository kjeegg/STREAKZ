// lib/screens/edit_habit_screen.dart

import 'package:flutter/material.dart';
import '../services/local_storage_service.dart';
import '../models/habit_model.dart';

class EditHabitScreen extends StatefulWidget {
  const EditHabitScreen({Key? key}) : super(key: key);

  @override
  State<EditHabitScreen> createState() => _EditHabitScreenState();
}

class _EditHabitScreenState extends State<EditHabitScreen> {
  final LocalStorageService _storageService = LocalStorageService();
  final TextEditingController _titleController = TextEditingController();

  Habit? _habit;
  List<bool> _days = [false, false, false, false, false, false, false];
  String _time = '09:00';
  String _reminder = 'Never';
  int _colorIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arg = ModalRoute.of(context)?.settings.arguments;
    if (arg is Habit) {
      _habit = arg;
      _titleController.text = _habit!.title;
      _days = List<bool>.from(_habit!.days);
      _time = _habit!.time;
      _reminder = _habit!.reminder;
      _colorIndex = _habit!.colorIndex;
    }
  }

  Future<void> _updateHabit() async {
    if (_habit == null) return;

    _habit!
      ..title = _titleController.text
      ..days = _days
      ..time = _time
      ..reminder = _reminder
      ..colorIndex = _colorIndex;

    final habits = await _storageService.loadHabits();
    final index = habits.indexWhere((h) => h.title == _habit!.title);
    if (index != -1) {
      habits[index] = _habit!;
    }
    await _storageService.saveHabits(habits);

    Navigator.pop(context);
  }

  Future<void> _deleteHabit() async {
    if (_habit == null) return;
    final habits = await _storageService.loadHabits();
    habits.removeWhere((h) => h.title == _habit!.title);
    await _storageService.saveHabits(habits);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final dayLabels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    final colorOptions = [
      Colors.red,
      Colors.orange,
      Colors.brown,
      Colors.grey,
      Colors.green,
      Colors.purple,
    ];

    if (_habit == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Edit Habit')),
        body: const Center(child: Text('Habit not found')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Habit'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Habit name'),
            ),
            const SizedBox(height: 10),
            const Text('Days of the week:'),
            Wrap(
              children: List.generate(7, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text(dayLabels[index]),
                    selected: _days[index],
                    onSelected: (val) {
                      setState(() {
                        _days[index] = val;
                      });
                    },
                  ),
                );
              }),
            ),
            const SizedBox(height: 10),
            // Время
            Row(
              children: [
                const Text('Time: '),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: _time,
                  items: [
                    '06:00','07:00','08:00','09:00','10:00',
                    '11:00','12:00','13:00','14:00','15:00',
                    '16:00','17:00','18:00','19:00','20:00'
                  ].map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                  onChanged: (val) {
                    setState(() {
                      _time = val ?? '09:00';
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Напоминание
            Row(
              children: [
                const Text('Reminder: '),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: _reminder,
                  items: ['Never','Once a day','Twice a day']
                      .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      _reminder = val ?? 'Never';
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Цвет
            const Text('Color:'),
            Wrap(
              children: List.generate(colorOptions.length, (index) {
                final color = colorOptions[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _colorIndex = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _colorIndex == index ? Colors.black : Colors.transparent,
                        width: 2,
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateHabit,
              child: const Text('Update'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: _deleteHabit,
              child: const Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}
