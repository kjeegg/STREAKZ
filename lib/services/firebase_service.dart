// firebase_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/habit_model.dart';

class FirebaseService {
  // Название коллекции может быть любым, например "habits"
  final CollectionReference<Map<String, dynamic>> _habitsCollection =
  FirebaseFirestore.instance.collection('habits');

  /// Сохранение конкретной привычки по ID:
  Future<void> saveHabit(Habit habit) async {
    try {
      // toMap() - это ваш метод в модели Habit, который конвертирует объект в Map
      await _habitsCollection.doc(habit.id).set(habit.toMap());
    } catch (e) {
      rethrow;
    }
  }

  /// Загрузка всех привычек
  Future<List<Habit>> loadAllHabits() async {
    try {
      final querySnapshot = await _habitsCollection.get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        // Используем ваш fromMap() из модели Habit
        return Habit.fromMap(data);
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  /// Загрузка привычки по ID
  Future<Habit?> loadHabitById(String habitId) async {
    try {
      final docSnapshot = await _habitsCollection.doc(habitId).get();
      if (!docSnapshot.exists) {
        return null;
      }
      final data = docSnapshot.data()!;
      return Habit.fromMap(data);
    } catch (e) {
      rethrow;
    }
  }

  /// Удаление привычки
  Future<void> deleteHabit(String habitId) async {
    try {
      print('Deleting habit with ID: $habitId');
      await _habitsCollection.doc(habitId).delete();
    } catch (e) {
      rethrow;
    }
  }
}
