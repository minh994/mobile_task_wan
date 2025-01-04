import 'package:flutter/material.dart';
import '../../../../core/di/service_locator.dart';
import '../../services/login_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _loginService = getIt<LoginService>();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleGoogleSignIn() async {
    try {
      setState(() => _isLoading = true);
      
      final user = await _loginService.loginWithGoogle();
      
      if (mounted && user != null) {
        if (!user.emailVerified) {
          // Nếu email chưa xác thực, chuyển đến trang xác thực
          Navigator.of(context).pushReplacementNamed(
            '/verify',
            arguments: {'email': user.email},
          );
        } else {
          // Nếu đã xác thực, chuyển đến trang home
          Navigator.of(context).pushReplacementNamed('/home');
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 60),
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
              // Login text
              const Text(
                'Login to your account',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF424242),
                ),
              ),
              const SizedBox(height: 24),
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
                      _isPasswordVisible 
                        ? Icons.visibility_off 
                        : Icons.visibility,
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
              const SizedBox(height: 8),
              // Forgot password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Handle forgot password
                  },
                  child: const Text(
                    'Forgot password?',
                    style: TextStyle(
                      color: Color(0xFF0066FF),
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Login button
              ValueListenableBuilder(
                valueListenable: _loginService,
                builder: (context, _, __) {
                  return SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _loginService.isLoading ? null : _handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0066FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: _loginService.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'Login',
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
              // Social login section
              const Text(
                '- Or Login with -',
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
                    'assets/google.png',
                    _handleGoogleSignIn,
                  ),
                  const SizedBox(width: 32),
                  _buildSocialButton(
                    'assets/facebook.png',
                    () {},
                  ),
                  const SizedBox(width: 32),
                  _buildSocialButton(
                    'assets/twitter.png',
                    () {},
                  ),
                ],
              ),
              const Spacer(),
              // Register text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      color: Color(0xFF9E9E9E),
                      fontSize: 12,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/register'),
                    child: const Text(
                      'Sign Up',
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

  Widget _buildSocialButton(String imagePath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          imagePath,
          width: 24,
          height: 24,
        ),
      ),
    );
  }

  Future<void> _handleLogin() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    try {
      await _loginService.loginWithEmailAndPassword(
        _emailController.text,
        _passwordController.text,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }
} 