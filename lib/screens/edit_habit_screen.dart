// lib/screens/edit_habit_screen.dart

import 'package:flutter/material.dart';
import '../services/local_storage_service.dart';
import '../models/habit_model.dart';
import 'package:habit_tracker_app/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

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
// 1. Добавим переменную для хранения старого названия
  late String _oldTitle;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arg = ModalRoute.of(context)?.settings.arguments;
    if (arg is Habit) {
      _habit = arg;
      _titleController.text = _habit!.title;
      _oldTitle = _habit!.title; // Сохраняем старое название
      _days = List<bool>.from(_habit!.days);
      _time = _habit!.time;
      _reminder = _habit!.reminder;
      _colorIndex = _habit!.colorIndex;
    }
  }

  Future<void> _updateHabit() async {
    if (_habit == null) return;

    // Присваиваем полям новые значения
    _habit!
      ..title = _titleController.text
      ..days = _days
      ..time = _time
      ..reminder = _reminder
      ..colorIndex = _colorIndex;

    final habits = await _storageService.loadHabits();

    // 2. Ищем по старому названию
    final index = habits.indexWhere((h) => h.title == _oldTitle);

    if (index != -1) {
      print('_habit!.time = ${_habit!.time}');
      print('_habit!.reminder = ${_habit!.reminder}');
      print('Будем сохранять index = $index в списке habits');

      habits[index] = _habit!;
      await _storageService.saveHabits(habits);
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Habit not found in storage!')),
      );
    }
  }



  Future<void> _deleteHabit() async {
    if (_habit == null) return;

    final habits = await _storageService.loadHabits();

    // Удаляем привычку из списка
    habits.removeWhere((h) => h.title == _habit!.title);

    // Сохраняем обновленный список
    await _storageService.saveHabits(habits);

    Navigator.pop(context, true); // Возвращаем результат успешного удаления
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
        title: Text(
          'Edit Habit',
          style: GoogleFonts.coiny(fontSize: 32, color: habitAccent2),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 50.0, left: 30.0, right: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Habit Name',
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

            Text(
              'Days of the Week',
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
            // Время
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
                        print('Выбрали val=$val');
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
                    backgroundColor:
                        MaterialStateProperty.all<Color>(habitPrimary)),
                onPressed: _updateHabit,
                child: Text(
                  'Update Habit',
                  style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: habitText,
                  ),
                ),
              ),
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
