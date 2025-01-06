// lib/screens/explore_screen.dart

import 'package:flutter/material.dart';
import '../widgets/placeholder_image.dart';
import 'package:habit_tracker_app/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

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
      child: Padding(
        padding: const EdgeInsets.only(top: 50.0, left: 30.0, right: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Explore",
              style: GoogleFonts.coiny(
                textStyle: Theme.of(context).textTheme.displayLarge,
                fontSize: 40,
                fontWeight: FontWeight.w400,
                color: habitAccent2,
              ),
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 16),
            Center(
              child: Container(
                width: 240,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () => setState(() => _selectedTab = 0),
                      style: ButtonStyle(
                        backgroundColor: _selectedTab == 0
                            ? MaterialStateProperty.all<Color>(habitPrimary)
                            : MaterialStateProperty.all<Color>(
                                Colors.transparent),
                        elevation: MaterialStateProperty.all<double>(0),
                      ),
                      child: Text(
                        'CHALLENGES',
                        style: GoogleFonts.nunitoSans(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          height: 1.57,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => setState(() => _selectedTab = 1),
                      style: ButtonStyle(
                        backgroundColor: _selectedTab == 1
                            ? MaterialStateProperty.all<Color>(habitPrimary)
                            : MaterialStateProperty.all<Color>(
                                Colors.transparent),
                        elevation: MaterialStateProperty.all<double>(0),
                      ),
                      child: Text(
                        'LEARN',
                        style: GoogleFonts.nunitoSans(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          height: 1.57,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: _selectedTab == 0 ? _buildChallenges() : _buildLearn(),
            ),
          ],
        ),
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
