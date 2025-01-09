import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class UserService extends GetxService {
  final _db = FirebaseFirestore.instance;
  final currentUser = Rxn<UserModel>();

  // Cache để lưu thông tin user
  final _userCache = <String, UserModel>{};

  Future<void> loadUser(String userId) async {
    try {
      // Kiểm tra cache trước
      if (_userCache.containsKey(userId)) {
        currentUser.value = _userCache[userId];
        return;
      }

      final doc = await _db.collection('users').doc(userId).get();
      if (doc.exists && doc.data() != null) {
        final user = UserModel.fromFirestore(
          doc.id,
          doc.data()!,
        );
        currentUser.value = user;
        _userCache[userId] = user; // Lưu vào cache
      }
    } catch (e) {
      print('Error loading user: $e');
      throw Exception('Could not load user data');
    }
  }

  Future<void> updateUser(String userId, Map<String, dynamic> data) async {
    try {
      await _db.collection('users').doc(userId).set(
        data,
        SetOptions(merge: true),
      );
      
      // Cập nhật cache
      if (_userCache.containsKey(userId)) {
        final updatedUser = UserModel.fromFirestore(
          userId,
          {..._userCache[userId]!.toFirestore(), ...data},
        );
        _userCache[userId] = updatedUser;
        currentUser.value = updatedUser;
      }
      
      await loadUser(userId); // Reload để đảm bảo dữ liệu mới nhất
    } catch (e) {
      print('Error updating user: $e');
      throw Exception('Could not update user: $e');
    }
  }

  // Clear cache khi logout
  void clearCache() {
    _userCache.clear();
    currentUser.value = null;
  }
}
