import 'package:flutter/foundation.dart';
import '../domain/models/user.dart';
import '../data/repositories/user_repository.dart';

class UserService extends ValueNotifier<User?> {
  final UserRepository _userRepository;
  bool _isLoading = false;
  String? _error;

  UserService(this._userRepository) : super(null);

  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadUser(String userId) async {
    if (value?.id == userId) return; // Không load lại nếu đã có data của user này
    
    try {
      _setLoading(true);
      value = await _userRepository.getUser(userId);
      _error = null;
    } catch (e) {
      _error = e.toString();
      debugPrint('Error loading user: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateUser(User user) async {
    try {
      _setLoading(true);
      await _userRepository.updateUser(user);
      value = user;
      _error = null;
    } catch (e) {
      _error = e.toString();
      debugPrint('Error updating user: $e');
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
} 