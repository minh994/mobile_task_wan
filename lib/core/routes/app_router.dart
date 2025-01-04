import 'package:flutter/material.dart';
import '../auth/auth_wrapper.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/home/presentation/screens/profile_screen.dart';
import 'route_guard.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const AuthWrapper());
      
      case '/home':
        return MaterialPageRoute(
          builder: (_) => const RouteGuard(child: HomeScreen()),
        );
        
      case '/profile':
        return MaterialPageRoute(
          builder: (_) => const RouteGuard(child: ProfileScreen()),
        );
        
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
} 