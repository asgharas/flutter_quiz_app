import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mad_quiz_app/firebase_options.dart';
import 'package:mad_quiz_app/provider/auth_provider.dart';
import 'package:mad_quiz_app/provider/quiz_provider.dart';
import 'package:mad_quiz_app/views/app.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => QuizProvider()),
          ChangeNotifierProvider(create: (context) => MyAuthProvider()),
        ],
        child: MaterialApp(
            theme: ThemeData(
              primaryColor: Colors.deepPurple,
              // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
            ),
            home: const App()));
  }
}
