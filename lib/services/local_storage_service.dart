import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/habit_model.dart';

// Добавляем наш сервис:
import 'firebase_service.dart';

/// A service class for managing local storage of habit data.
/// And optionally syncing with Firebase.
class LocalStorageService {
  static const String habitsKey = 'habits_data';
  static const String streakKey = 'global_streak';
  static const String levelKey = 'global_level';
  static const String xpKey = 'global_xp';

  final _firebaseService = FirebaseService();

  Future<void> saveHabits(List<Habit> habits) async {
    // 1) Сохраняем локально
    final prefs = await SharedPreferences.getInstance();
    final jsonHabits = habits.map((h) => json.encode(h.toMap())).toList();
    await prefs.setStringList(habitsKey, jsonHabits);

    // 2) Сохраняем в Firebase (например, по очереди)
    for (final habit in habits) {
      await _firebaseService.saveHabit(habit);
    }
  }

  Future<List<Habit>> loadHabits() async {
    // 1) Загружаем локально
    final prefs = await SharedPreferences.getInstance();
    final jsonHabits = prefs.getStringList(habitsKey) ?? [];

    final localHabits = jsonHabits.map((jsonStr) {
      final map = json.decode(jsonStr) as Map<String, dynamic>;
      return Habit.fromMap(map);
    }).toList();

    // 2) Загружаем из Firebase
    final remoteHabits = await _firebaseService.loadAllHabits();

    // Варианты:
    // - Вернуть только локальные
    // - Вернуть только удалённые
    // - Или как-то объединить/мержить данные

    // Допустим, будем отдавать то, что есть на Firebase (главная БД),
    // а локальное – как fallback, если оттуда пусто.
    return remoteHabits.isNotEmpty ? remoteHabits : localHabits;
  }

  /// Остальные методы (глобальный streak, xp и т.д.) можно не трогать
  /// или тоже дублировать в Firebase, если нужно.
  Future<void> saveGlobalStreak(int streak) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(streakKey, streak);
  }

  Future<int> loadGlobalStreak() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(streakKey) ?? 0;
  }

  Future<void> saveGlobalLevel(int level) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(levelKey, level);
  }

  Future<int> loadGlobalLevel() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(levelKey) ?? 1;
  }

  Future<void> saveGlobalXP(int xp) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(xpKey, xp);
  }

  Future<int> loadGlobalXP() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(xpKey) ?? 0;
  }
}
