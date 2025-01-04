import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../../../core/di/service_locator.dart';

class VerificationSuccessScreen extends StatelessWidget {
  const VerificationSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _authService = getIt<AuthService>();

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
              const Text(
                'Verify Account',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF424242),
                ),
              ),
              const SizedBox(height: 24),
              // Success illustration
              Image.asset(
                'assets/verification_success.png',
                height: 200,
              ),
              const SizedBox(height: 24),
              // Success message
              const Text(
                'Your Account has been\nVerified Successfully!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF424242),
                ),
              ),
              const Spacer(),
              // Go to Dashboard button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      // Kiểm tra lại trạng thái xác thực
                      await _authService.checkAuthStatus();
                      if (_authService.isAuthenticated) {
                        if (context.mounted) {
                          // Xóa tất cả các routes trước đó và chuyển đến home
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            '/home',
                            (route) => false,
                          );
                        }
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: $e')),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0066FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Go to Dashboard',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
} 