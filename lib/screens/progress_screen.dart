// lib/screens/progress_screen.dart

import 'package:flutter/material.dart';
import '../services/local_storage_service.dart';

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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Progress',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 32),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('Streak', '$_globalStreak 🔥'),
                _buildStatItem('Level', '$_globalLevel'),
                _buildStatItem('XP', '$_globalXP / 50'),
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
