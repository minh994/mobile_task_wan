import 'package:flutter/material.dart';
import '../../features/auth/services/auth_service.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../di/service_locator.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  final _authService = getIt<AuthService>();

  @override
  void initState() {
    super.initState();
    _authService.checkAuthStatus();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _authService,
      builder: (context, user, _) {
        if (_authService.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (_authService.error != null) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${_authService.error}'),
                  ElevatedButton(
                    onPressed: () => _authService.checkAuthStatus(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        return _authService.isAuthenticated 
          ? const HomeScreen() 
          : const LoginScreen();
      },
    );
  }
} 