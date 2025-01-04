import 'package:flutter/foundation.dart';
import '../domain/repositories/i_verification_repository.dart';

class VerificationService extends ValueNotifier<bool> {
  final IVerificationRepository _verificationRepository;
  bool _isLoading = false;
  String? _error;

  VerificationService(this._verificationRepository) : super(false);

  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> sendVerificationEmail(String email) async {
    try {
      _setLoading(true);
      await _verificationRepository.sendVerificationEmail(email);
      _error = null;
    } catch (e) {
      _error = e.toString();
      throw VerificationException('Failed to send verification email: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> checkEmailVerified() async {
    try {
      _setLoading(true);
      final isVerified = await _verificationRepository.checkEmailVerified();
      _error = null;
      value = isVerified;
      return isVerified;
    } catch (e) {
      _error = e.toString();
      throw VerificationException('Failed to verify email: $e');
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}

class VerificationException implements Exception {
  final String message;
  VerificationException(this.message);
  
  @override
  String toString() => message;
} 