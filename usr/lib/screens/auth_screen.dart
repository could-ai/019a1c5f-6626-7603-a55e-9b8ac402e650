import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:viora/main.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLoading = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    // IMPORTANT: Supabase project not selected.
    // The actual Supabase auth call is commented out.
    // try {
    //   await supabase.auth.signInWithPassword(
    //     email: _emailController.text.trim(),
    //     password: _passwordController.text.trim(),
    //   );
    // } on AuthException catch (error) {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: Text(error.message),
    //     backgroundColor: Theme.of(context).colorScheme.error,
    //   ));
    // } catch (error) {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: const Text('An unexpected error occurred'),
    //     backgroundColor: Theme.of(context).colorScheme.error,
    //   ));
    // }

    // Simulating a successful login for UI demonstration
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
       Navigator.of(context).pushReplacementNamed('/main');
    }


    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() {
      _isLoading = true;
    });

    // IMPORTANT: Supabase project not selected.
    // The actual Supabase auth call is commented out.
    // try {
    //   await supabase.auth.signUp(
    //     email: _emailController.text.trim(),
    //     password: _passwordController.text.trim(),
    //   );
    //   if (mounted) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(content: Text('Check your email for a confirmation link.')),
    //     );
    //   }
    // } on AuthException catch (error) {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: Text(error.message),
    //     backgroundColor: Theme.of(context).colorScheme.error,
    //   ));
    // } catch (error) {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: const Text('An unexpected error occurred'),
    //     backgroundColor: Theme.of(context).colorScheme.error,
    //   ));
    // }

    // Simulating a successful signup for UI demonstration
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Signup successful! Please sign in.')),
      );
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome to Viora')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Icon(Icons.auto_awesome, size: 80),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                   validator: (value) {
                    if (value == null || value.isEmpty || value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _isLoading ? null : _signIn,
                  child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text('Sign In'),
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: _isLoading ? null : _signUp,
                  child: const Text('Sign Up'),
                ),
                const SizedBox(height: 24),
                const Row(
                  children: <Widget>[
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('OR'),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  icon: const Icon(Icons.login), // Replace with a Google icon if you add an asset
                  label: const Text('Sign In with Google'),
                  onPressed: _isLoading ? null : () {
                     // IMPORTANT: Supabase project not selected.
                     // Google Sign-In logic is not implemented.
                     ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Google Sign-In is not configured.'))
                     );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
