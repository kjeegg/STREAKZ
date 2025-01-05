// lib/services/local_storage_service.dart

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/habit_model.dart';

class LocalStorageService {
  static const String habitsKey = 'habits_data';
  static const String streakKey = 'global_streak';
  static const String levelKey = 'global_level';
  static const String xpKey = 'global_xp';

  // Сохраняем список привычек
  Future<void> saveHabits(List<Habit> habits) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonHabits = habits.map((h) => json.encode(h.toMap())).toList();
    await prefs.setStringList(habitsKey, jsonHabits);
  }

  // Загружаем список привычек
  Future<List<Habit>> loadHabits() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonHabits = prefs.getStringList(habitsKey) ?? [];
    return jsonHabits.map((jsonStr) {
      final map = json.decode(jsonStr) as Map<String, dynamic>;
      return Habit.fromMap(map);
    }).toList();
  }

  // Сохраняем глобальный streak
  Future<void> saveGlobalStreak(int streak) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(streakKey, streak);
  }

  Future<int> loadGlobalStreak() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(streakKey) ?? 0;
  }

  // Сохраняем уровень
  Future<void> saveGlobalLevel(int level) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(levelKey, level);
  }

  Future<int> loadGlobalLevel() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(levelKey) ?? 1;
  }

  // Сохраняем XP
  Future<void> saveGlobalXP(int xp) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(xpKey, xp);
  }

  Future<int> loadGlobalXP() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(xpKey) ?? 0;
  }
}
