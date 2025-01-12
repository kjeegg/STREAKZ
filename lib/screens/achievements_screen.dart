// lib/screens/achievements_screen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';
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
        padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
        child: Column(
          children: [
            Text(
              "Achievements",
              style: GoogleFonts.coiny(
                textStyle: Theme.of(context).textTheme.displayLarge,
                fontSize: 40,
                fontWeight: FontWeight.w400,
                color: habitAccent2,
              ),
            ),
            const SizedBox(height: 30),
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
