class Habit {
  final String id;        // <-- Новый уникальный идентификатор
  final String title;
  final List<bool> days;
  String time;
  bool isDone;
  final bool reminderEnabled;
  final DateTime reminderTime;
  int colorIndex;
  int streakCount;
  DateTime? startDate;

  Habit({
    required this.id,     // теперь id обязателен в конструкторе
    required this.title,
    required this.days,
    required this.time,
    this.isDone = false,
    this.reminderEnabled = false,
    DateTime? reminderTime,
    required this.colorIndex,
    this.streakCount = 0,
    this.startDate,
  }) : reminderTime = reminderTime ?? const TimeOfDay(hour: 9, minute: 0);

  Map<String, dynamic> toMap() {
    return {
      'id': id,                         // сохраняем id в JSON
      'title': title,
      'days': days.map((d) => d ? 1 : 0).toList(),
      'time': time,
      'isDone': isDone ? 1 : 0,
      'reminderEnabled': reminderEnabled ? 1 : 0,
      'reminderTime': {
        'hour': reminderTime.hour,
        'minute': reminderTime.minute,
      },
      'colorIndex': colorIndex,
      'streakCount': streakCount,
      'startDate': startDate?.millisecondsSinceEpoch,
    };
  }

  static Habit fromMap(Map<String, dynamic> map) {
    return Habit(
      id: map['id'] ?? '',              // загружаем id
      title: map['title'] ?? '',
      days: (map['days'] as List).map((e) => e == 1).toList(),
      time: map['time'] ?? '',
      isDone: (map['isDone'] ?? 0) == 1,
      reminderEnabled: (map['reminderEnabled'] ?? 0) == 1,
      reminderTime: TimeOfDay(
        hour: map['reminderTime']['hour'] ?? 9,
        minute: map['reminderTime']['minute'] ?? 0,
      ),
      colorIndex: map['colorIndex'] ?? 0,
      streakCount: map['streakCount'] ?? 0,
      startDate: map['startDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['startDate'])
          : null,
    );
  }

  Habit copyWith({
    String? id,
    String? title,
    List<bool>? days,
    String? time,
    bool? isDone,
    bool? reminderEnabled,
    DateTime? reminderTime,
    int? colorIndex,
    int? streakCount,
    DateTime? startDate,
  }) {
    return Habit(
      id: id ?? this.id,
      title: title ?? this.title,
      days: days ?? this.days,
      time: time ?? this.time,
      isDone: isDone ?? this.isDone,
      reminderEnabled: reminderEnabled ?? this.reminderEnabled,
      reminderTime: reminderTime ?? this.reminderTime,
      colorIndex: colorIndex ?? this.colorIndex,
      streakCount: streakCount ?? this.streakCount,
      startDate: startDate ?? this.startDate,
    );
  }
}
