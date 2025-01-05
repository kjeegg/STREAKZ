// lib/screens/achievements_screen.dart

import 'package:flutter/material.dart';
import '../widgets/placeholder_image.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final achievements = [
      '7-Days Streak',
      '5-Days Streak',
      '3-Days Streak',
      'Check 3 habits',
      'Check 1 habit',
    ];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Achievements',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 32),
            ),
            const SizedBox(height: 16),
            // Заглушка картинки или реальная картинка
            const PlaceholderImage(placeholderName: 'Achievements Banner'),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: achievements.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.emoji_events, color: Colors.orange),
                    title: Text(achievements[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
