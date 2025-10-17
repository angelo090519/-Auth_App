import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'register_screen.dart'; // import the RegisterScreen

class LoginScreen extends StatefulWidget {
  final AuthService authService;

  const LoginScreen({Key? key, required this.authService}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // your login screen variables, form, etc.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Your login form here

            // The navigation button/link:
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterScreen(authService: widget.authService),
                  ),
                );
              },
              child: Text("Don't have an account? Register here"),
            ),
          ],
        ),
      ),
    );
  }
}
