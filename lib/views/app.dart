import 'package:flutter/material.dart';
import 'package:mad_quiz_app/provider/auth_provider.dart';
import 'package:mad_quiz_app/views/auth_views/login_screen.dart';
import 'package:mad_quiz_app/views/home_screen.dart';
import 'package:mad_quiz_app/views/leaderboard_screen/leaderboard_screen.dart';
import 'package:mad_quiz_app/views/profile_screen/profile_screen.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App({super.key});

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
    return Consumer<MyAuthProvider>(builder: (context, state, child) {
      return Scaffold(
          appBar: state.isLoggedIn
              ? AppBar(
                  title: Text(selectedIndex == 0
                      ? "Quiz"
                      : selectedIndex == 1
                          ? "Profile"
                          : "Leaderboard"),
                  actions: [
                    IconButton(
                        onPressed: () {
                          //logout
                          state.logout();
                        },
                        icon: const Row(
                          children: [
                            Text("Logout"),
                            Padding(padding: EdgeInsets.only(left: 4)),
                            Icon(Icons.logout),
                          ],
                        ))
                  ],
                )
              : AppBar(
                  title: const Text("Login or Signup"),
                ),
          bottomNavigationBar: state.isLoggedIn
              ? NavigationBar(
                  selectedIndex: selectedIndex,
                  destinations: destinations,
                  onDestinationSelected: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                )
              : const SizedBox(),
          body: state.isLoggedIn
              ? IndexedStack(
                  index: selectedIndex,
                  children: const <Widget>[
                    HomeScreen(),
                    ProfileScreen(),
                    LeaderboardScreen(),
                  ],
                )
              : const LoginScreen());
    });
  }
}
