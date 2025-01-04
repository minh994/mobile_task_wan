import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'core/di/service_locator.dart';
import 'features/auth/services/auth_service.dart';
import 'features/home/services/user_service.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/auth/presentation/screens/register_screen.dart';
import 'features/auth/presentation/screens/verify_account_screen.dart';
import 'features/home/presentation/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = getIt<AuthService>();
    final userService = getIt<UserService>();

    return MaterialApp(
      title: 'Task Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: ValueListenableBuilder<User?>(
        valueListenable: authService,
        builder: (context, firebaseUser, _) {
          if (firebaseUser != null) {
            // Load user data when authenticated
            userService.loadUser(firebaseUser.uid);
          }
          return const AuthWrapper();
        },
      ),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/verify') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => VerifyAccountScreen(
              email: args['email'] as String,
            ),
          );
        }
        return null;
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = getIt<AuthService>();

    return ValueListenableBuilder<User?>(
      valueListenable: authService,
      builder: (context, user, _) {
        if (authService.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return authService.isAuthenticated 
          ? const HomeScreen() 
          : const LoginScreen();
      },
    );
  }
}
