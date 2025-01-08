// lib/screens/add_habit_screen.dart

import 'package:flutter/material.dart';
import '../services/local_storage_service.dart';
import '../models/habit_model.dart';
import 'package:habit_tracker_app/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AddHabitScreen extends StatefulWidget {
  const AddHabitScreen({Key? key}) : super(key: key);

  @override
  State<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final LocalStorageService _storageService = LocalStorageService();

  final TextEditingController _titleController = TextEditingController();
  List<bool> _days = [false, false, false, false, false, false, false];
  String _time = '09:00';
  String _reminder = 'Never';
  int _colorIndex = 0;

  Future<void> _saveHabit() async {
    final newHabit = Habit(
      title: _titleController.text,
      days: _days,
      time: _time,
      reminder: _reminder,
      colorIndex: _colorIndex,
    );
    final habits = await _storageService.loadHabits();
    habits.add(newHabit);
    await _storageService.saveHabits(habits);
    Navigator.pop(context, true);
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

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Habit',
          style: GoogleFonts.coiny(fontSize: 32, color: habitAccent2),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 50.0, left: 30.0, right: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Название привычки
            Text(
              'I want to',
              style: GoogleFonts.nunitoSans(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: habitText,
              ),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: _titleController,
              style: GoogleFonts.nunitoSans(
                fontSize: 18,
                color: habitText,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: habitWhite,
                hintText: 'Read 20 pages',
                hintStyle: GoogleFonts.nunitoSans(
                  fontSize: 18,
                  color: habitGrey,
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 30.0),
            // Выбор дней
            Text(
              'When?',
              style: GoogleFonts.nunitoSans(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: habitText,
              ),
            ),
            const SizedBox(height: 10.0),
            Wrap(
              children: List.generate(7, (index) {
                return ChoiceChip(
                  disabledColor: habitWhite,
                  selectedColor: habitPrimary,
                  showCheckmark: false,
                  shape: CircleBorder(),
                  label: Text(dayLabels[index]),
                  selected: _days[index],
                  onSelected: (val) {
                    setState(() {
                      _days[index] = val;
                    });
                  },
                );
              }),
            ),
            const SizedBox(height: 30.0),
            // Время (для упрощения - Dropdown)
            Row(
              children: [
                Text(
                  'Time',
                  style: GoogleFonts.nunitoSans(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: habitText,
                  ),
                ),
                const SizedBox(width: 20.0),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: habitWhite,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      dropdownColor: habitWhite,
                      style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: habitText,
                      ),
                      value: _time,
                      items: [
                        '06:00',
                        '07:00',
                        '08:00',
                        '09:00',
                        '10:00',
                        '11:00',
                        '12:00',
                        '13:00',
                        '14:00',
                        '15:00',
                        '16:00',
                        '17:00',
                        '18:00',
                        '19:00',
                        '20:00',
                      ]
                          .map(
                              (t) => DropdownMenuItem(value: t, child: Text(t)))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          _time = val ?? '09:00';
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30.0),
            // Напоминание
            Row(
              children: [
                Text(
                  'Reminder',
                  style: GoogleFonts.nunitoSans(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: habitText,
                  ),
                ),
                const SizedBox(width: 20.0),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: habitWhite,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      dropdownColor: habitWhite,
                      style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: habitText,
                      ),
                      value: _reminder,
                      items: ['Never', 'Once a day', 'Twice a day']
                          .map(
                              (r) => DropdownMenuItem(value: r, child: Text(r)))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          _reminder = val ?? 'Never';
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30.0),
            // Цвет
            Text(
              'Color',
              style: GoogleFonts.nunitoSans(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: habitText,
              ),
            ),

            const SizedBox(height: 10.0),
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
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 3.0,
                        color: _colorIndex == index
                            ? Colors.black
                            : Colors.transparent,
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 30.0),
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(habitPrimary)),
                onPressed: _saveHabit,
                child: Text(
                  'Add Habit',
                  style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: habitText,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
