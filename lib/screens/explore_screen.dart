// lib/screens/explore_screen.dart

import 'package:flutter/material.dart';
import '../widgets/placeholder_image.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Text(
            'Explore',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 32),
          ),
          const SizedBox(height: 16),
          const PlaceholderImage(placeholderName: 'Explore Banner'),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => setState(() => _selectedTab = 0),
                child: const Text('CHALLENGES'),
              ),
              TextButton(
                onPressed: () => setState(() => _selectedTab = 1),
                child: const Text('LEARN'),
              ),
            ],
          ),
          Expanded(
            child: _selectedTab == 0 ? _buildChallenges() : _buildLearn(),
          ),
        ],
      ),
    );
  }

  Widget _buildChallenges() {
    final challenges = [
      '3 Days Active Challenge',
      '7 Days Healthy Eating',
      'Book Reading Challenge',
    ];
    return ListView.builder(
      itemCount: challenges.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(challenges[index]),
          trailing: ElevatedButton(
            onPressed: () {},
            child: const Text('Join'),
          ),
        );
      },
    );
  }

  Widget _buildLearn() {
    final learnItems = [
      'Habits 101',
      'How to break bad habits?',
      'Self-Discipline Tips',
    ];
    return ListView.builder(
      itemCount: learnItems.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(learnItems[index]),
          subtitle: const Text('Details...'),
        );
      },
    );
  }
}
