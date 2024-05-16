import 'package:flutter/material.dart';
import 'package:mad_quiz_app/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyAuthProvider>(builder: (context, state, child) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                    hintText: "Email", border: OutlineInputBorder()),
                onChanged: (value) {
                  state.setEmail(value);
                },
              ),
              const Padding(padding: EdgeInsets.all(8)),
              TextField(
                decoration: const InputDecoration(
                    hintText: "Password", border: OutlineInputBorder()),
                onChanged: (value) {
                  state.setPassword(value);
                },
              ),
              const Padding(padding: EdgeInsets.all(16)),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        state.login((msg) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(msg),
                            ),
                          );
                        });
                      },
                      child: const Text("Log In")),
                  const Padding(padding: EdgeInsets.all(8)),
                  ElevatedButton(
                      onPressed: () {
                        state.signUp((msg) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(msg),
                            ),
                          );
                        });
                      },
                      child: const Text("Sign Up")),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
