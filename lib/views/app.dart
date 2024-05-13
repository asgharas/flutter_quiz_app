import 'package:flutter/material.dart';
import 'package:mad_quiz_app/views/home_screen.dart';
import 'package:mad_quiz_app/views/leaderboard_screen/leaderboard_screen.dart';
import 'package:mad_quiz_app/views/profile_screen/profile_screen.dart';

class App extends StatefulWidget {
  const App({super.key });

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  var selectedIndex = 0;
  var destinations = <Widget>[
    const NavigationDestination(
      icon: Icon(Icons.assignment),
      label: "Quiz",
    ),
    const NavigationDestination(
      icon: Icon(Icons.person),
      label: "Profile",
    ),
    const NavigationDestination(
      icon: Icon(Icons.leaderboard),
      label: "Leaderboard",
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( selectedIndex == 0 ? "Quiz" : selectedIndex == 1 ? "Profile" : "Leaderboard"),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        destinations: destinations,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
      body: IndexedStack(
        index: selectedIndex,
        children: const <Widget>[
          HomeScreen(),
          ProfileScreen(),
          LeaderboardScreen(),
        ],
      )
    );
  }
}