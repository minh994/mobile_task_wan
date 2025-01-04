import 'package:flutter/material.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../di/service_locator.dart';
import '../../features/auth/services/auth_service.dart';

class RouteGuard extends StatelessWidget {
  final Widget child;

  const RouteGuard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final authService = getIt<AuthService>();

    return ValueListenableBuilder(
      valueListenable: authService,
      builder: (context, _, __) {
        if (!authService.isAuthenticated) {
          return const LoginScreen();
        }
        return child;
      },
    );
  }
} 