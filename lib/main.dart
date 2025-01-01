import 'package:flutter/material.dart';
import 'package:habit_tracker_app/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: habitBG,
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //home
                Container(
                  margin: EdgeInsets.only(
                      top: 100, left: 30, right: 30, bottom: 25),
                  child: Text(
                    "Home",
                    style: GoogleFonts.coiny(
                      textStyle: Theme.of(context).textTheme.displayLarge,
                      fontSize: 40,
                      fontWeight: FontWeight.w400,
                      color: habitAccent2,
                    ),
                  ),
                ),

                //streak counter
                Center(
                  child: Container(
                    width: 301,
                    height: 62,
                    padding: const EdgeInsets.all(20),
                    decoration: ShapeDecoration(
                      color: Color(0xFFFFFAE7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    margin: EdgeInsets.only(left: 30, right: 30, bottom: 25),
                    child: Row(children: [
                      Text(
                        'Current Streak',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunitoSans(
                          color: habitText,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          height: 0.92,
                        ),
                      ),
                      const SizedBox(width: 38),
                      Text(
                        '4',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunitoSans(
                          color: habitText,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          height: 0.92,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Image.asset(
                        'lib/assets/images/streak_flame.png',
                        width: 16,
                        height: 23,
                      ),
                    ]),
                  ),
                ),
                //date picker
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  margin: EdgeInsets.only(bottom: 40),
                  width: 407,
                  height: 44,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'December',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunitoSans(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          height: 0.92,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 21,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 24,
                                    child: Text(
                                      'Mo',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontFamily: 'Nunito Sans',
                                        fontWeight: FontWeight.w700,
                                        height: 1.57,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      '1',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontFamily: 'Nunito Sans',
                                        fontWeight: FontWeight.w700,
                                        height: 1.38,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 11),
                            Container(
                              width: 21,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 24,
                                    child: Text(
                                      'Tu',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontFamily: 'Nunito Sans',
                                        fontWeight: FontWeight.w700,
                                        height: 1.57,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      '2',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontFamily: 'Nunito Sans',
                                        fontWeight: FontWeight.w700,
                                        height: 1.38,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 11),
                            Container(
                              width: 21,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 24,
                                    child: Text(
                                      'We',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontFamily: 'Nunito Sans',
                                        fontWeight: FontWeight.w700,
                                        height: 1.57,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      '3',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontFamily: 'Nunito Sans',
                                        fontWeight: FontWeight.w700,
                                        height: 1.38,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 11),
                            Container(
                              width: 21,
                              decoration: ShapeDecoration(
                                color: Color(0xFFCC822C),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 24,
                                    child: Text(
                                      'Th',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontFamily: 'Nunito Sans',
                                        fontWeight: FontWeight.w700,
                                        height: 1.57,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      '4',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'Nunito Sans',
                                        fontWeight: FontWeight.w700,
                                        height: 1.38,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 11),
                            Container(
                              width: 21,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 24,
                                    child: Text(
                                      'Fr',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontFamily: 'Nunito Sans',
                                        fontWeight: FontWeight.w700,
                                        height: 1.57,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      '5',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontFamily: 'Nunito Sans',
                                        fontWeight: FontWeight.w700,
                                        height: 1.38,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 11),
                            Container(
                              width: 21,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 24,
                                    child: Text(
                                      'Sa',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontFamily: 'Nunito Sans',
                                        fontWeight: FontWeight.w700,
                                        height: 1.57,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      '6',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontFamily: 'Nunito Sans',
                                        fontWeight: FontWeight.w700,
                                        height: 1.38,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 11),
                            Container(
                              width: 21,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 24,
                                    child: Text(
                                      'Su',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontFamily: 'Nunito Sans',
                                        fontWeight: FontWeight.w700,
                                        height: 1.57,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      '7',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontFamily: 'Nunito Sans',
                                        fontWeight: FontWeight.w700,
                                        height: 1.38,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //habit list
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(20),
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: ShapeDecoration(
                          color: Color(0xFFE7CA8F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Habit 1',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.nunitoSans(
                                color: habitText,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                height: 0.92,
                              ),
                            ),
                            IconButton(
                              icon: Image.asset(
                                  'lib/assets/icons/habit_circle_unchecked.png'),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: ShapeDecoration(
                          color: Color(0xFFE7CA8F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Habit 2',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.nunitoSans(
                                color: habitText,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                height: 0.92,
                              ),
                            ),
                            IconButton(
                              icon: Image.asset(
                                  'lib/assets/icons/habit_circle_unchecked.png'),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: ShapeDecoration(
                          color: Color(0xFFE7CA8F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Habit 3',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.nunitoSans(
                                color: habitText,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                height: 0.92,
                              ),
                            ),
                            IconButton(
                              icon: Image.asset(
                                  'lib/assets/icons/habit_circle_unchecked.png'),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: ShapeDecoration(
                          color: Color(0xFFE7CA8F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Habit 4',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.nunitoSans(
                                color: habitText,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                height: 0.92,
                              ),
                            ),
                            IconButton(
                              icon: Image.asset(
                                  'lib/assets/icons/habit_circle_unchecked.png'),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: ShapeDecoration(
                          color: Color(0xFFE7CA8F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Habit 5',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.nunitoSans(
                                color: habitText,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                height: 0.92,
                              ),
                            ),
                            IconButton(
                              icon: Image.asset(
                                  'lib/assets/icons/habit_circle_unchecked.png'),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        child: Text(
                          'All Habits',
                          style: GoogleFonts.nunitoSans(
                            color: habitText,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            height: 0.92,
                          ),
                        ),
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll<Color>(habitPrimary),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
            // Add Habit Button
            Positioned(
              top: 700,
              right: 40,
              child: IconButton(
                icon: Image.asset('lib/assets/icons/add_habit_button.png'),
                tooltip: 'Add new habit',
                onPressed: () {},
              ),
            ),
          ],
        ),
        bottomNavigationBar: NavigationBottom(),
      ),
    );
  }
}

class NavigationBottom extends StatefulWidget {
  const NavigationBottom({super.key});

  @override
  State<NavigationBottom> createState() => _NavigationBottomState();
}

class _NavigationBottomState extends State<NavigationBottom> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return NavigationBar(
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      onDestinationSelected: (int index) {
        setState(() {
          currentPageIndex = index;
        });
      },
      backgroundColor: habitSecondary,
      indicatorColor: Colors.transparent,
      selectedIndex: currentPageIndex,
      destinations: [
        NavigationDestination(
          selectedIcon: Image.asset(
            'lib/assets/icons/home_on.png',
            width: 47,
            height: 47,
          ),
          icon: Image.asset(
            'lib/assets/icons/home.png',
            width: 47,
            height: 47,
          ),
          label: 'Home',
        ),
        NavigationDestination(
          selectedIcon: Image.asset(
            'lib/assets/icons/progress_on.png',
            width: 47,
            height: 47,
          ),
          icon: Image.asset(
            'lib/assets/icons/progress.png',
            width: 47,
            height: 47,
          ),
          label: 'Notifications',
        ),
        NavigationDestination(
          selectedIcon: Image.asset(
            'lib/assets/icons/explore_on.png',
            width: 47,
            height: 47,
          ),
          icon: Image.asset(
            'lib/assets/icons/explore.png',
            width: 47,
            height: 47,
          ),
          label: 'Notifications',
        ),
        NavigationDestination(
          selectedIcon: Image.asset(
            'lib/assets/icons/settings_on.png',
            width: 47,
            height: 47,
          ),
          icon: Image.asset(
            'lib/assets/icons/settings.png',
            width: 47,
            height: 47,
          ),
          label: 'Messages',
        ),
      ],
    );
  }
}
