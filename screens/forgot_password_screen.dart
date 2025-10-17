import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final AuthService authService;

  const ForgotPasswordScreen({Key? key, required this.authService}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String? _errorMessage;
  bool _loading = false;
  bool _emailSent = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _loading = true;
      _errorMessage = null;
      _emailSent = false;
    });

    _formKey.currentState!.save();

    final error = await widget.authService.resetPassword(email: _email);

    if (error != null) {
      setState(() {
        _errorMessage = error;
        _loading = false;
      });
    } else {
      setState(() {
        _emailSent = true;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_errorMessage != null)
              Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
            if (_emailSent)
              Text(
                'Password reset email sent! Please check your inbox.',
                style: const TextStyle(color: Colors.green),
              ),
            Form(
              key: _formKey,
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value == null || value.isEmpty ? 'Enter your email' : null,
                onSaved: (value) => _email = value!.trim(),
              ),
            ),
            const SizedBox(height: 20),
            _loading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _submit,
              child: const Text('Send Password Reset Email'),
            ),
          ],
        ),
      ),
    );
  }
}
