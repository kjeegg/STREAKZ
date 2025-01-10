// lib/screens/edit_habit_screen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/local_storage_service.dart';
import '../models/habit_model.dart';
import 'package:habit_tracker_app/constants/colors.dart';

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

  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInitialized) {
      final arg = ModalRoute.of(context)?.settings.arguments;
      if (arg is Habit) {
        _habit = arg;
        _titleController.text = _habit!.title;
        _days = List<bool>.from(_habit!.days);
        _time = _habit!.time;
        _reminder = _habit!.reminder;
        _colorIndex = _habit!.colorIndex;
      }
      _isInitialized = true;
    }
  }


  Future<void> _updateHabit() async {
    if (_habit == null) return;

    // Загружаем список:
    final habits = await _storageService.loadHabits();

    // Ищем по ID, а не по старому title
    final index = habits.indexWhere((h) => h.id == _habit!.id);

    if (index != -1) {
      // Обновляем поля
      _habit!.title = _titleController.text;
      _habit!.time = _time;
      _habit!.reminder = _reminder;
      _habit!.days = _days;
      _habit!.colorIndex = _colorIndex;

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
    // Точно так же - удаляем по id
    habits.removeWhere((h) => h.id == _habit!.id);

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
          // Внутри build, на месте вашего "Time" dropdown
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: habitWhite,
                ),
                onPressed: () async {
                  // Парсим текущее _time (в формате 'HH:mm') в TimeOfDay
                  final parts = _time.split(':');
                  final hour = int.tryParse(parts[0]) ?? 9;
                  final minute = int.tryParse(parts[1]) ?? 0;

                  // Показываем диалог выбора времени
                  final TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay(hour: hour, minute: minute),
                  );

                  // Если пользователь выбрал время и нажал "ОК":
                  if (pickedTime != null) {
                    setState(() {
                      // Преобразуем обратно в строку "HH:mm"
                      final hh = pickedTime.hour.toString().padLeft(2, '0');
                      final mm = pickedTime.minute.toString().padLeft(2, '0');
                      _time = '$hh:$mm';
                      print('Выьранное время: $_time');
                    });
                  }
                },
                child: Text(
                  (() {
                    print('Отображаемое время: $_time'); // Выводим значение в консоль
                    return _time;
                  })(), // Используем анонимную функцию для выполнения логики
                  style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: habitText,
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
