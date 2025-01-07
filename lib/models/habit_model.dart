class Habit {
  String title;
  List<bool> days;
  String time;
  String reminder;
  int colorIndex;
  int streakCount;
  DateTime? startDate;
  bool isDone;

  Habit({
    required this.title,
    required this.days,
    required this.time,
    required this.reminder,
    required this.colorIndex,
    this.streakCount = 0,
    this.startDate,
    this.isDone = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'days': days.map((d) => d ? 1 : 0).toList(),
      'time': time,
      'reminder': reminder,
      'colorIndex': colorIndex,
      'streakCount': streakCount,
      'startDate': startDate?.millisecondsSinceEpoch,
      'isDone': isDone ? 1 : 0,
    };
  }

  static Habit fromMap(Map<String, dynamic> map) {
    return Habit(
      title: map['title'] ?? '',
      days: (map['days'] as List).map((e) => e == 1).toList(),
      time: map['time'] ?? '',
      reminder: map['reminder'] ?? 'Never',
      colorIndex: map['colorIndex'] ?? 0,
      streakCount: map['streakCount'] ?? 0,
      startDate: map['startDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['startDate'])
          : null,
      isDone: (map['isDone'] ?? 0) == 1,
    );
  }
}
