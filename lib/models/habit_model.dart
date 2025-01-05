// lib/models/habit_model.dart

class Habit {
  String title;
  List<bool> days;  // дни недели [Пн..Вс], отмечаем true/false
  String time;      // например, "09:00"
  String reminder;  // например, "Never", "Once a day"
  int colorIndex;   // индекс цвета
  int streakCount;  // пример: счётчик стрика по данной привычке

  Habit({
    required this.title,
    required this.days,
    required this.time,
    required this.reminder,
    required this.colorIndex,
    this.streakCount = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'days': days.map((d) => d ? 1 : 0).toList(),
      'time': time,
      'reminder': reminder,
      'colorIndex': colorIndex,
      'streakCount': streakCount,
    };
  }

  static Habit fromMap(Map<String, dynamic> map) {
    return Habit(
      title: map['title'] ?? '',
      days: (map['days'] as List).map((val) => val == 1).toList(),
      time: map['time'] ?? '',
      reminder: map['reminder'] ?? 'Never',
      colorIndex: map['colorIndex'] ?? 0,
      streakCount: map['streakCount'] ?? 0,
    );
  }
}
