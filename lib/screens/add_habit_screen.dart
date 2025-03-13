// lib/screens/add_habit_screen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/local_storage_service.dart';
import '../models/habit_model.dart';
import 'package:habit_tracker_app/constants/colors.dart';
import '../services/notification_service.dart';
import 'package:uuid/uuid.dart';

class AddHabitScreen extends StatefulWidget {
  const AddHabitScreen({Key? key}) : super(key: key);

  @override
  State<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final List<bool> _selectedDays = List.generate(7, (index) => false);
  bool _reminderEnabled = false;
  TimeOfDay _reminderTime = const TimeOfDay(hour: 9, minute: 0);
  final _notificationService = NotificationService();

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _reminderTime,
    );
    if (picked != null && picked != _reminderTime) {
      setState(() {
        _reminderTime = picked;
      });
    }
  }

  Future<void> _saveHabit() async {
    if (_formKey.currentState!.validate()) {
      final habit = Habit(
        id: const Uuid().v4(),
        title: _titleController.text,
        days: _selectedDays,
        reminderEnabled: _reminderEnabled,
        reminderTime: _reminderTime,
      );

      final storageService = LocalStorageService();
      await storageService.saveHabit(habit);

      if (_reminderEnabled) {
        await _notificationService.scheduleHabitNotification(habit);
      }

      if (mounted) {
        Navigator.pop(context, true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New Habit',
          style: GoogleFonts.nunitoSans(
            color: habitText,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Habit Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Text(
              'Select Days',
              style: GoogleFonts.nunitoSans(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: habitText,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              children: [
                'Mo',
                'Tu',
                'We',
                'Th',
                'Fr',
                'Sa',
                'Su'
              ].asMap().entries.map((entry) {
                return FilterChip(
                  label: Text(entry.value),
                  selected: _selectedDays[entry.key],
                  onSelected: (selected) {
                    setState(() {
                      _selectedDays[entry.key] = selected;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            SwitchListTile(
              title: Text(
                'Enable Reminder',
                style: GoogleFonts.nunitoSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: habitText,
                ),
              ),
              value: _reminderEnabled,
              onChanged: (value) {
                setState(() {
                  _reminderEnabled = value;
                });
              },
            ),
            if (_reminderEnabled) ...[
              ListTile(
                title: Text(
                  'Reminder Time',
                  style: GoogleFonts.nunitoSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: habitText,
                  ),
                ),
                subtitle: Text(
                  _reminderTime.format(context),
                  style: GoogleFonts.nunitoSans(
                    fontSize: 14,
                    color: habitText,
                  ),
                ),
                trailing: const Icon(Icons.access_time),
                onTap: _selectTime,
              ),
            ],
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveHabit,
              style: ElevatedButton.styleFrom(
                backgroundColor: habitPrimary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Save Habit',
                style: GoogleFonts.nunitoSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
