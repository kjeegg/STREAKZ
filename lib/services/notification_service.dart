import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';
import '../models/habit_model.dart';
import '../services/local_storage_service.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();
  final LocalStorageService _storageService = LocalStorageService();

  Future<void> initialize() async {
    // Инициализация timezone
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));

    // Настройка уведомлений
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        final payload = response.payload;
        if (payload != null) {
          final parts = payload.split('|');
          if (parts.length == 2) {
            final habitId = parts[0];
            final action = parts[1];
            
            switch (action) {
              case 'done':
                await _markHabitAsDone(habitId);
                break;
              case 'snooze':
                await _snoozeHabit(habitId);
                break;
            }
          }
        }
      },
    );
  }

  Future<void> _markHabitAsDone(String habitId) async {
    final habits = await _storageService.loadHabits();
    final habitIndex = habits.indexWhere((h) => h.id == habitId);
    
    if (habitIndex != -1) {
      final habit = habits[habitIndex];
      habits[habitIndex] = habit.copyWith(isDone: true);
      await _storageService.saveHabits(habits);
      await cancelHabitNotifications(habitId);
    }
  }

  Future<void> _snoozeHabit(String habitId) async {
    final habits = await _storageService.loadHabits();
    final habitIndex = habits.indexWhere((h) => h.id == habitId);
    
    if (habitIndex != -1) {
      final habit = habits[habitIndex];
      // Планируем новое уведомление через 15 минут
      final now = DateTime.now();
      final snoozeTime = now.add(const Duration(minutes: 15));
      
      await _notifications.zonedSchedule(
        habit.id.hashCode + 1, // Используем другой ID для отложенного уведомления
        'Напоминание о привычке',
        'Не забудьте выполнить: ${habit.title}',
        tz.TZDateTime.from(snoozeTime, tz.local),
        NotificationDetails(
          android: AndroidNotificationDetails(
            'habit_reminders',
            'Напоминания о привычках',
            channelDescription: 'Уведомления о необходимости выполнить привычку',
            importance: Importance.high,
            priority: Priority.high,
            actions: [
              const AndroidNotificationAction('done', 'Выполнено'),
              const AndroidNotificationAction('snooze', 'Напомнить позже'),
            ],
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
            actions: [
              DarwinNotificationAction.plain('done', 'Выполнено'),
              DarwinNotificationAction.plain('snooze', 'Напомнить позже'),
            ],
          ),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }

  Future<void> scheduleHabitNotification(Habit habit) async {
    if (!habit.reminderEnabled) return;

    // Удаляем старые уведомления для этой привычки
    await cancelHabitNotifications(habit.id);

    // Создаем новое уведомление
    final now = DateTime.now();
    final scheduledTime = DateTime(
      now.year,
      now.month,
      now.day,
      habit.reminderTime.hour,
      habit.reminderTime.minute,
    );

    // Если время уже прошло сегодня, планируем на завтра
    final effectiveTime = scheduledTime.isBefore(now)
        ? scheduledTime.add(const Duration(days: 1))
        : scheduledTime;

    await _notifications.zonedSchedule(
      habit.id.hashCode,
      'Время для привычки!',
      'Не забудьте выполнить: ${habit.title}',
      tz.TZDateTime.from(effectiveTime, tz.local),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'habit_reminders',
          'Напоминания о привычках',
          channelDescription: 'Уведомления о необходимости выполнить привычку',
          importance: Importance.high,
          priority: Priority.high,
          actions: [
            const AndroidNotificationAction('done', 'Выполнено'),
            const AndroidNotificationAction('snooze', 'Напомнить позже'),
          ],
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
          actions: [
            DarwinNotificationAction.plain('done', 'Выполнено'),
            DarwinNotificationAction.plain('snooze', 'Напомнить позже'),
          ],
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: '${habit.id}|done', // Добавляем payload для идентификации действия
    );
  }

  Future<void> cancelHabitNotifications(String habitId) async {
    await _notifications.cancel(habitId.hashCode);
    await _notifications.cancel(habitId.hashCode + 1); // Отменяем также отложенные уведомления
  }

  Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
  }
} 