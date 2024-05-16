import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class MyAuthProvider extends ChangeNotifier {
  var _isLoggedIn = false;
  get isLoggedIn => _isLoggedIn;

  var _email = "";
  get email => _email;

  var _password = "";
  get password => _password;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  MyAuthProvider() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        _isLoggedIn = true;
      } else {
        _isLoggedIn = false;
      }
      notifyListeners();
    });
  }

  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  Future<void> login(Function(String) showSnackbar) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      showSnackbar("Login successful");
    } catch (e) {
      // show snackbar
      showSnackbar(e.toString());
    }
  }

  Future<void> signUp(Function(String) showSnackbar) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      showSnackbar("Sign up successful, now login.");
    } catch (e) {
      // show snackbar
      showSnackbar(e.toString());
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
