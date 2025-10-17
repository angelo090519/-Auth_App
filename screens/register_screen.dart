import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  final AuthService authService;

  const RegisterScreen({Key? key, required this.authService}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String? _errorMessage;
  bool _loading = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _loading = true;
      _errorMessage = null;
    });

    _formKey.currentState!.save();

    final error = await widget.authService.register(
      email: _email,
      password: _password,
    );

    if (error != null) {
      setState(() {
        _errorMessage = error;
        _loading = false;
      });
    } else {
      // Registration success — you can show a message or navigate
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration successful! Please verify your email.')),
      );
      // Optionally, navigate back to login screen or clear form
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_errorMessage != null)
              Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) =>
                    value == null || value.isEmpty ? 'Enter email' : null,
                    onSaved: (value) => _email = value!.trim(),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (value) =>
                    value == null || value.length < 6 ? 'Password must be at least 6 characters' : null,
                    onSaved: (value) => _password = value!,
                  ),
                  const SizedBox(height: 20),
                  _loading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                    onPressed: _submit,
                    child: const Text('Register'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
