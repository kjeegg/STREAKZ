// lib/screens/progress_screen.dart

import 'package:flutter/material.dart';
import '../services/local_storage_service.dart';
import 'package:habit_tracker_app/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  final LocalStorageService _storageService = LocalStorageService();
  int _globalStreak = 0;
  int _globalLevel = 1;
  int _globalXP = 0;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    final streak = await _storageService.loadGlobalStreak();
    final level = await _storageService.loadGlobalLevel();
    final xp = await _storageService.loadGlobalXP();

    setState(() {
      _globalStreak = streak;
      _globalLevel = level;
      _globalXP = xp;
    });
  }

  Future<void> _addXp() async {
    setState(() {
      _globalXP += 10;
      if (_globalXP >= 50) {
        _globalLevel++;
        _globalXP = 0;
      }
    });
    await _storageService.saveGlobalXP(_globalXP);
    await _storageService.saveGlobalLevel(_globalLevel);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Progress",
              style: GoogleFonts.coiny(
                textStyle: Theme.of(context).textTheme.displayLarge,
                fontSize: 40,
                fontWeight: FontWeight.w400,
                color: habitAccent2,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 136,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Streak',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunitoSans(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          height: 0.92,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '$_globalStreak',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.nunitoSans(
                              color: Color(0xFF181611),
                              fontSize: 40,
                              fontWeight: FontWeight.w700,
                              height: 0.55,
                            ),
                          ),
                          Image.asset(
                            'lib/assets/images/streak_flame.png',
                            width: 34,
                            height: 44,
                          ),
                        ],
                      ),
                      Text(
                        'Best Streak: 12',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunitoSans(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          height: 1.83,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 136,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Level',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunitoSans(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          height: 0.92,
                        ),
                      ),
                      Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                        Image.asset(
                          'lib/assets/images/level_badge.png',
                            width: 61,
                            height: 71,
                        ),
                        Text(
                          '$_globalLevel',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunitoSans(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                            height: 0.55,
                          ),
                        ),
                      ]),
                      Text(
                        '$_globalXP / 50 XP',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunitoSans(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          height: 1.83,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addXp,
              child: const Text('+10 XP'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(label),
      ],
    );
  }
}
