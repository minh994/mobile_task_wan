import 'package:flutter/foundation.dart';
import '../domain/repositories/i_auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginService extends ValueNotifier<User?> {
  final IAuthRepository _authRepository;
  bool _isLoading = false;
  String? _error;

  LoginService(this._authRepository) : super(null);

  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      _setLoading(true);
      // Implement email/password login
      _error = null;
    } catch (e) {
      _error = e.toString();
      throw LoginException('Failed to login: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<User?> loginWithGoogle() async {
    try {
      _setLoading(true);
      value = await _authRepository.signInWithGoogle();
      _error = null;
      return value;
    } catch (e) {
      _error = e.toString();
      throw LoginException('Failed to login with Google: $e');
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}

class LoginException implements Exception {
  final String message;
  LoginException(this.message);
  
  @override
  String toString() => message;
} 