import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/habit_model.dart';

/// A service class for managing local storage of habit data.
class LocalStorageService {
  /// Key for storing habits data in SharedPreferences.
  static const String habitsKey = 'habits_data';

  /// Key for storing global streak data in SharedPreferences.
  static const String streakKey = 'global_streak';

  /// Key for storing global level data in SharedPreferences.
  static const String levelKey = 'global_level';

  /// Key for storing global XP data in SharedPreferences.
  static const String xpKey = 'global_xp';

  /// Saves a list of habits to local storage.
  ///
  /// \param habits The list of Habit objects to save.
  Future<void> saveHabits(List<Habit> habits) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonHabits = habits.map((h) => json.encode(h.toMap())).toList();
    await prefs.setStringList(habitsKey, jsonHabits);
  }

  /// Loads a list of habits from local storage.
  ///
  /// \return A Future that resolves to a list of Habit objects.
  Future<List<Habit>> loadHabits() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonHabits = prefs.getStringList(habitsKey) ?? [];
    return jsonHabits.map((jsonStr) {
      final map = json.decode(jsonStr) as Map<String, dynamic>;
      return Habit.fromMap(map);
    }).toList();
  }

  /// Saves the global streak value to local storage.
  ///
  /// \param streak The streak value to save.
  Future<void> saveGlobalStreak(int streak) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(streakKey, streak);
  }

  /// Loads the global streak value from local storage.
  ///
  /// \return A Future that resolves to the streak value.
  Future<int> loadGlobalStreak() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(streakKey) ?? 0;
  }

  /// Saves the global level value to local storage.
  ///
  /// \param level The level value to save.
  Future<void> saveGlobalLevel(int level) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(levelKey, level);
  }

  /// Loads the global level value from local storage.
  ///
  /// \return A Future that resolves to the level value.
  Future<int> loadGlobalLevel() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(levelKey) ?? 1;
  }

  /// Saves the global XP value to local storage.
  ///
  /// \param xp The XP value to save.
  Future<void> saveGlobalXP(int xp) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(xpKey, xp);
  }

  /// Loads the global XP value from local storage.
  ///
  /// \return A Future that resolves to the XP value.
  Future<int> loadGlobalXP() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(xpKey) ?? 0;
  }
}