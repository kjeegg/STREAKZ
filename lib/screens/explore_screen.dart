// lib/screens/explore_screen.dart

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/placeholder_image.dart';
import 'package:habit_tracker_app/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

/// A simple model for challenge items
class ChallengeItem {
  final String title;
  bool isJoined;
  String imageSource;
  ChallengeItem(
      {required this.title,
      this.isJoined = false,
      this.imageSource = 'lib/assets/images/challenge_active.png'});
}

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  int _selectedTab = 0;

  /// Challenge data, each item has a title and joined state
  final List<ChallengeItem> _challenges = [
    ChallengeItem(
        title: '3 Days Active Challenge',
        imageSource: 'lib/assets/images/challenge_active.png'),
    ChallengeItem(
        title: '7 Days Healthy Eating',
        imageSource: 'lib/assets/images/challenge_eat_healthy.png'),
    ChallengeItem(
        title: 'Book Reading Challenge',
        imageSource: 'lib/assets/images/challenge_read.png'),
    ChallengeItem(
        title: 'Gratitude Journal Challenge',
        imageSource: 'lib/assets/images/challenge_gratitude.png'),
    ChallengeItem(
        title: '7 Days Meditation',
        imageSource: 'lib/assets/images/challenge_meditation.png'),
  ];

  /// Learning articles
  final List<Map<String, String>> _learningArticles = [
    {
      'title': 'Habits 101',
      'url': 'https://www.heroic.us/101/habits',
    },
    {
      'title': 'How to break bad habits?',
      'url': 'https://newsinhealth.nih.gov/2012/01/breaking-bad-habits',
    },
    {
      'title': 'Self-Discipline Tips',
      'url':
          'https://www.forbes.com/sites/brentgleeson/2020/08/25/8-powerful-ways-to-cultivate-extreme-self-discipline/',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 50.0, left: 30.0, right: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title: Explore
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
            // Buttons: CHALLENGES / LEARN
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
            const SizedBox(height: 16),

            // Main content (CHALLENGES or LEARN tab)
            Expanded(
              child: _selectedTab == 0 ? _buildChallenges() : _buildLearn(),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the Challenges list
  Widget _buildChallenges() {
    return ListView.builder(
      itemCount: _challenges.length,
      itemBuilder: (context, index) {
        final challenge = _challenges[index];
        return Container(
            padding: EdgeInsets.all(15.0),
            margin: EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: habitWhite,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 150,
                        child: Text(
                          challenge.title,
                          style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: habitText,
                          ),
                        ),
                      ),
                      Container(
                        width: 150,
                        child: Text(
                          '+30 XP when completed',
                          style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: const Color.fromARGB(255, 76, 75, 75),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            challenge.isJoined = !challenge.isJoined;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              challenge.isJoined ? habitAccent : habitPrimary,
                        ),
                        child: Text(
                          challenge.isJoined ? 'Leave' : 'Join',
                          style: GoogleFonts.nunitoSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: challenge.isJoined ? const Color.fromARGB(255, 94, 93, 93) : habitText,
                          ),
                          ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Image.asset(
                    challenge.imageSource,
                    width: 150,
                    height: 150,
                  ),
                ),
              ],
            ));
        // return ListTile(
        //   title: Text(challenge.title),
        //   subtitle: challenge.isJoined
        //       ? const Text('You have joined this challenge!')
        //       : null,
        //   trailing: ElevatedButton(
        //     onPressed: () {
        //       setState(() {
        //         challenge.isJoined = !challenge.isJoined;
        //       });
        //     },
        //     style: ElevatedButton.styleFrom(
        //       backgroundColor: challenge.isJoined ? Colors.grey : habitPrimary,
        //     ),
        //     child: Text(challenge.isJoined ? 'Leave' : 'Join'),
        //   ),
        // );
      },
    );
  }

  /// Builds the Learn tab with articles
  Widget _buildLearn() {
    return ListView.builder(
      itemCount: _learningArticles.length,
      itemBuilder: (context, index) {
        final article = _learningArticles[index];
        final title = article['title']!;
        final url = article['url']!;
        return ListTile(
          title: Text(title),
          subtitle: const Text('Tap to read'),
          onTap: () => _openLink(url),
        );
      },
    );
  }

  /// Open link in default browser
  Future<void> _openLink(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open the link')),
      );
    }
  }
}
