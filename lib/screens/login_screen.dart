import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider.dart';
import '../auth/auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailOrUsernameController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;

  Future<void> _login() async {
    final emailOrUsername = _emailOrUsernameController.text.trim();
    final rawPassword = _passwordController.text;

    if (emailOrUsername.isEmpty || rawPassword.isEmpty) {
      setState(() {
        _errorMessage = "Please fill in all fields.";
      });
      return;
    }

    final hashedPassword = hashPassword(rawPassword);

    try {
      await Provider.of<UserProvider>(
        context,
        listen: false,
      ).loginUser(emailOrUsername, hashedPassword);

      if (mounted) {
        Navigator.pushReplacementNamed(context, '/map');
      }
    } catch (e) {
      setState(() {
        _errorMessage = "Login failed: ${e.toString()}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              const Image(
                height: 150,
                image: AssetImage('assets/PinPals_nb.png'),
              ),
              const Text("Welcome! Please Log in."),
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              Form(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailOrUsernameController,
                        decoration: InputDecoration(
                          labelText: "Email or Username",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _login,
                        child: const Text("Sign in"),
                      ),
                      const SizedBox(height: 20),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: const Text("Register"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
