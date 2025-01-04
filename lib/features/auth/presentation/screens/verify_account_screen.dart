import 'package:flutter/material.dart';
import '../../../../core/di/service_locator.dart';
import '../../services/verification_service.dart';
import '../../services/auth_service.dart';
import 'verification_success_screen.dart';
import 'dart:async';

class VerifyAccountScreen extends StatefulWidget {
  final String email;
  
  const VerifyAccountScreen({
    super.key,
    required this.email,
  });

  @override
  State<VerifyAccountScreen> createState() => _VerifyAccountScreenState();
}

class _VerifyAccountScreenState extends State<VerifyAccountScreen> {
  Timer? _timer;
  final _verificationService = getIt<VerificationService>();
  final _authService = getIt<AuthService>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _sendVerificationEmail();
      _startEmailVerificationCheck();
    });
  }

  void _startEmailVerificationCheck() {
    _timer = Timer.periodic(
      const Duration(seconds: 3),
      (timer) async {
        try {
          await _authService.checkAuthStatus();
          
          final isVerified = await _verificationService.checkEmailVerified();
          if (isVerified && mounted) {
            timer.cancel();
            if (mounted) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/home',
                (route) => false,
              );
            }
          }
        } catch (e) {
          timer.cancel();
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${e.toString()}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      },
    );
  }

  Future<void> _sendVerificationEmail() async {
    try {
      await _verificationService.sendVerificationEmail(widget.email);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Verification email sent')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
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
          child: ValueListenableBuilder(
            valueListenable: _verificationService,
            builder: (context, isVerified, _) {
              return Column(
                children: [
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
                  const Text(
                    'Verify Account',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF424242),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Verification illustration
                  Image.asset(
                    'assets/verification.png',
                    height: 200,
                  ),
                  const SizedBox(height: 24),
                  // Email verification message
                  Text(
                    'We have sent a verification link to\n${widget.email}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF9E9E9E),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Please check your email and click the link\nto verify your account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF9E9E9E),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Resend email button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Didn't receive the email? ",
                        style: TextStyle(
                          color: Color(0xFF9E9E9E),
                          fontSize: 12,
                        ),
                      ),
                      GestureDetector(
                        onTap: _sendVerificationEmail,
                        child: const Text(
                          'Resend',
                          style: TextStyle(
                            color: Color(0xFF0066FF),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
} 