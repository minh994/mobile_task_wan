import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../domain/repositories/i_auth_repository.dart';
import '../../home/data/repositories/user_repository.dart';
import '../../home/domain/models/user.dart' as app_user;

class AuthService extends ValueNotifier<User?> {
  final IAuthRepository _authRepository;
  final UserRepository _userRepository;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  String? _error;

  AuthService(this._authRepository, this._userRepository) : super(null);

  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => value != null;

  Future<void> checkAuthStatus() async {
    try {
      _setLoading(true);
      value = await _authRepository.getCurrentUser();
      _error = null;
    } catch (e) {
      _error = e.toString();
      throw Exception(e);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      _setLoading(true);
      value = await _authRepository.signInWithGoogle();
      _error = null;
    } catch (e) {
      _error = e.toString();
      throw Exception(e);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signOut() async {
    try {
      _setLoading(true);
      await _authRepository.signOut();
      value = null;
      _error = null;
    } catch (e) {
      _error = e.toString();
      throw Exception(e);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> register({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      _setLoading(true);
      // Tạo user với email và password
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Cập nhật displayName
      await userCredential.user?.updateDisplayName(username);
      
      // Tạo user document trong Firestore
      final newUser = app_user.User(
        id: userCredential.user!.uid,
        name: username,
        email: email,
        photoUrl: userCredential.user?.photoURL ?? '',
        occupation: 'Not set',
        location: 'Not set',
      );
      
      await _userRepository.updateUser(newUser);
      
      // Gửi email xác thực
      await userCredential.user?.sendEmailVerification();
      
      value = userCredential.user;
      _error = null;
    } catch (e) {
      _error = e.toString();
      throw AuthException('Failed to register: $e');
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}

class AuthException implements Exception {
  final String message;
  AuthException(this.message);
  
  @override
  String toString() => message;
} 