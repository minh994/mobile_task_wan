import 'package:flutter/material.dart';
import '../../../../core/di/service_locator.dart';
import '../../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _authService = getIt<AuthService>();
  
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Back button
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0066FF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Logo và tiêu đề
              const Column(
                children: [
                  Text(
                    'TASK-WAN',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0066FF),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Management App',
                    style: TextStyle(
                      color: Color(0xFF9E9E9E),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              // Create account text
              const Text(
                'Create your account',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF424242),
                ),
              ),
              const SizedBox(height: 24),
              // Username field
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  prefixIcon: Container(
                    padding: const EdgeInsets.all(12),
                    child: const Icon(Icons.person_outline, color: Colors.grey),
                  ),
                  hintText: 'Username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Email field
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  prefixIcon: Container(
                    padding: const EdgeInsets.all(12),
                    child: const Icon(Icons.email_outlined, color: Colors.grey),
                  ),
                  hintText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Password field
              TextField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  prefixIcon: Container(
                    padding: const EdgeInsets.all(12),
                    child: const Icon(Icons.lock_outline, color: Colors.grey),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Confirm Password field
              TextField(
                controller: _confirmPasswordController,
                obscureText: !_isConfirmPasswordVisible,
                decoration: InputDecoration(
                  prefixIcon: Container(
                    padding: const EdgeInsets.all(12),
                    child: const Icon(Icons.lock_outline, color: Colors.grey),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isConfirmPasswordVisible ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                  ),
                  hintText: 'Confirm Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // Register button
              ValueListenableBuilder(
                valueListenable: _authService,
                builder: (context, _, __) {
                  return SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _authService.isLoading ? null : _handleRegister,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0066FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: _authService.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'Register',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              // Social register section
              const Text(
                '- Or Register with -',
                style: TextStyle(
                  color: Color(0xFF9E9E9E),
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 24),
              // Social buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialButton(
                    icon: Icons.g_mobiledata,
                    color: Colors.red,
                    onTap: () => _authService.signInWithGoogle(),
                  ),
                  const SizedBox(width: 32),
                  _buildSocialButton(
                    icon: Icons.facebook,
                    color: Colors.blue,
                    onTap: () {},
                  ),
                  const SizedBox(width: 32),
                  _buildSocialButton(
                    icon: Icons.flutter_dash,
                    color: Colors.lightBlue,
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Login text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account? ',
                    style: TextStyle(
                      color: Color(0xFF9E9E9E),
                      fontSize: 12,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Color(0xFF0066FF),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: color),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color),
      ),
    );
  }

  Future<void> _handleRegister() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    try {
      await _authService.register(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
      );
      
      if (mounted) {
        Navigator.pushNamed(
          context,
          '/verify',
          arguments: {'email': _emailController.text},
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }
} 